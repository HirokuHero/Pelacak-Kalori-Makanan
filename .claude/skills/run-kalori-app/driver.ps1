# Driver for launching and visually driving kalori_app (Flutter web/Chrome)
# on a Windows machine that has no chromium-cli / Node / Python.
#
# All coordinates for `click` are IMAGE-LOCAL pixels from the PNG produced
# by `screenshot`/`rect` (i.e. what you see when you open the screenshot) —
# the script adds the live window offset for you. Always take a fresh
# screenshot before clicking; window position/size can drift between calls.
#
# Usage:
#   powershell -File driver.ps1 launch    [-ProjectDir <path>] [-Port 5757] [-LogPath <path>]
#   powershell -File driver.ps1 resize    [-Width 1200] [-Height 800] [-TitleMatch "kalori"]
#   powershell -File driver.ps1 rect      [-TitleMatch "kalori"]
#   powershell -File driver.ps1 screenshot -Out <path.png> [-TitleMatch "kalori"]
#   powershell -File driver.ps1 click     -X <int> -Y <int> [-TitleMatch "kalori"]
#   powershell -File driver.ps1 type      -Text "<string>" [-ClearFirst]
#   powershell -File driver.ps1 key       -Key "{ESC}" | "{TAB}" | "^a" | ...  (SendKeys syntax)
#   powershell -File driver.ps1 stop      [-Port 5757]
#
# ALWAYS run `resize` once right after `launch` (and before the first
# `rect`/`screenshot`/`click`). On a multi-monitor machine, Chrome can
# maximize to bounds taller than the primary display's visible work
# area, which pushes page content (e.g. a bottom nav bar) out from
# under the taskbar and off whatever you screenshot. `resize` pins the
# window to a small fixed size fully inside the primary monitor so
# every later coordinate is reproducible.

param(
    [Parameter(Position=0, Mandatory=$true)]
    [ValidateSet("launch","resize","rect","screenshot","click","type","key","stop")]
    [string]$Command,

    [string]$ProjectDir = (Get-Location).Path,
    [int]$Port = 5757,
    [string]$LogPath = "$env:TEMP\kalori_app_flutter_run.log",
    [string]$TitleMatch = "kalori",
    [string]$Out,
    [int]$X,
    [int]$Y,
    [string]$Text,
    [switch]$ClearFirst,
    [string]$Key,
    [int]$Width = 1200,
    [int]$Height = 800
)

Add-Type @"
using System;
using System.Runtime.InteropServices;
using System.Text;
using System.Collections.Generic;
public class KaloriDriver {
    [DllImport("user32.dll")] public static extern bool SetProcessDPIAware();
    [DllImport("user32.dll")] public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);
    [DllImport("user32.dll")] public static extern int GetWindowText(IntPtr hWnd, StringBuilder text, int count);
    [DllImport("user32.dll")] public static extern int GetClassName(IntPtr hWnd, StringBuilder text, int count);
    [DllImport("user32.dll")] public static extern bool IsWindowVisible(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool GetWindowRect(IntPtr hWnd, out RECT lpRect);
    [DllImport("user32.dll")] public static extern bool SetForegroundWindow(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool BringWindowToTop(IntPtr hWnd);
    [DllImport("user32.dll")] public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("user32.dll")] public static extern IntPtr GetForegroundWindow();
    [DllImport("user32.dll")] public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);
    [DllImport("user32.dll")] public static extern bool AttachThreadInput(uint idAttach, uint idAttachTo, bool fAttach);
    [DllImport("kernel32.dll")] public static extern uint GetCurrentThreadId();
    [DllImport("user32.dll")] public static extern void keybd_event(byte bVk, byte bScan, uint dwFlags, UIntPtr dwExtraInfo);
    [DllImport("user32.dll")] public static extern bool SetCursorPos(int x, int y);
    [DllImport("user32.dll")] public static extern void mouse_event(uint dwFlags, uint dx, uint dy, uint dwData, UIntPtr dwExtraInfo);
    [DllImport("user32.dll")] public static extern bool SetWindowPos(IntPtr hWnd, IntPtr hWndInsertAfter, int X, int Y, int cx, int cy, uint uFlags);
    [DllImport("user32.dll")] public static extern bool PostMessage(IntPtr hWnd, uint Msg, IntPtr wParam, IntPtr lParam);

    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
    [StructLayout(LayoutKind.Sequential)]
    public struct RECT { public int Left; public int Top; public int Right; public int Bottom; }

    public const uint MOUSEEVENTF_LEFTDOWN = 0x02;
    public const uint MOUSEEVENTF_LEFTUP = 0x04;
    public const int SW_RESTORE = 9;

    public static List<KeyValuePair<IntPtr,string>> GetWindows() {
        var list = new List<KeyValuePair<IntPtr,string>>();
        EnumWindows((hWnd, lParam) => {
            if (IsWindowVisible(hWnd)) {
                var sb = new StringBuilder(256);
                GetWindowText(hWnd, sb, 256);
                if (sb.Length > 0) list.Add(new KeyValuePair<IntPtr,string>(hWnd, sb.ToString()));
            }
            return true;
        }, IntPtr.Zero);
        return list;
    }

    // Chrome's top-level window class is "Chrome_WidgetWin_1". Filtering
    // on it (in addition to title) matters because other apps' windows
    // can share a title substring with the project folder name (e.g. a
    // File Explorer window titled "kalori_app and 1 more tab") -- and
    // right after launch, before Flutter's first frame runs, Chrome's
    // tab title is still the bare project folder name, not the app's
    // MaterialApp title, so a loose title-only match is genuinely
    // ambiguous during that window.
    public static bool IsChromeWindow(IntPtr hWnd) {
        var sb = new StringBuilder(256);
        GetClassName(hWnd, sb, 256);
        return sb.ToString() == "Chrome_WidgetWin_1";
    }

    public static List<IntPtr> FindAllByTitle(string substr) {
        var found = new List<IntPtr>();
        foreach (var kv in GetWindows())
            if (kv.Value.IndexOf(substr, StringComparison.OrdinalIgnoreCase) >= 0 && IsChromeWindow(kv.Key))
                found.Add(kv.Key);
        return found;
    }

    public static IntPtr FindByTitle(string substr) {
        var found = FindAllByTitle(substr);
        return found.Count > 0 ? found[0] : IntPtr.Zero;
    }

    // Foreground-lock workaround: a background process's plain
    // SetForegroundWindow is routinely ignored by Windows. Faking an
    // Alt keypress + attaching thread input is the reliable combo.
    public static bool ForceForeground(IntPtr hwnd) {
        for (int i = 0; i < 3; i++) {
            keybd_event(0x12, 0, 0, UIntPtr.Zero);
            keybd_event(0x12, 0, 2, UIntPtr.Zero);
            IntPtr fg = GetForegroundWindow();
            uint fgProc;
            uint fgThread = GetWindowThreadProcessId(fg, out fgProc);
            uint curThread = GetCurrentThreadId();
            AttachThreadInput(curThread, fgThread, true);
            ShowWindow(hwnd, SW_RESTORE);
            BringWindowToTop(hwnd);
            SetForegroundWindow(hwnd);
            AttachThreadInput(curThread, fgThread, false);
            System.Threading.Thread.Sleep(250);
            if (GetForegroundWindow() == hwnd) return true;
        }
        return false;
    }

    public static void Click(int x, int y) {
        SetCursorPos(x, y);
        System.Threading.Thread.Sleep(120);
        mouse_event(MOUSEEVENTF_LEFTDOWN, 0, 0, 0, UIntPtr.Zero);
        System.Threading.Thread.Sleep(80);
        mouse_event(MOUSEEVENTF_LEFTUP, 0, 0, 0, UIntPtr.Zero);
    }
}
"@

# DPI awareness must be (re)set at the top of every invocation: each
# `powershell -File` call is a fresh process, and without this,
# GetWindowRect/CopyFromScreen report DPI-virtualized (scaled-down)
# coordinates while SetCursorPos expects physical pixels -- clicks
# silently land on the wrong element.
[KaloriDriver]::SetProcessDPIAware() | Out-Null

function Get-TargetWindowRect {
    param([string]$Title)
    # Right after `launch`, Chrome's window can take a couple seconds to
    # appear at all (and its class only reliably becomes queryable once
    # the tab has actually opened) -- poll briefly instead of failing on
    # the first miss.
    $matches = @()
    for ($i = 0; $i -lt 10; $i++) {
        $matches = [KaloriDriver]::FindAllByTitle($Title)
        if ($matches.Count -gt 0) { break }
        Start-Sleep -Milliseconds 500
    }
    if ($matches.Count -eq 0) {
        throw "No window found matching title '$Title'. Is the app running? (driver.ps1 launch)"
    }
    if ($matches.Count -gt 1) {
        Write-Warning "Multiple windows match '$Title' ($($matches.Count) found) -- likely a stale window left over from a previous session. Using the first one found (not guaranteed to be the newest). Run 'stop' to close stragglers, or close extra Chrome windows manually."
    }
    $hwnd = $matches[0]
    [KaloriDriver]::ForceForeground($hwnd) | Out-Null
    $rect = New-Object KaloriDriver+RECT
    [KaloriDriver]::GetWindowRect($hwnd, [ref]$rect) | Out-Null
    return $rect
}

switch ($Command) {

    "launch" {
        Push-Location $ProjectDir
        Remove-Item $LogPath -ErrorAction SilentlyContinue
        Start-Process -FilePath "flutter" -ArgumentList "run","-d","chrome","--web-port",$Port `
            -RedirectStandardOutput $LogPath -RedirectStandardError "$LogPath.err" -WindowStyle Hidden
        Pop-Location
        $deadline = (Get-Date).AddSeconds(90)
        while ((Get-Date) -lt $deadline) {
            if (Test-Path $LogPath) {
                $content = Get-Content $LogPath -Raw -ErrorAction SilentlyContinue
                if ($content -match "Flutter run key commands") { Write-Output "READY`n$content"; exit 0 }
                if ($content -match "(?i)error|exception") { Write-Output "ERROR`n$content"; exit 1 }
            }
            Start-Sleep -Seconds 2
        }
        Write-Output "TIMEOUT waiting for app to become ready. Log so far:"
        Get-Content $LogPath -ErrorAction SilentlyContinue
        exit 1
    }

    "resize" {
        $hwnd = [IntPtr]::Zero
        for ($i = 0; $i -lt 10; $i++) {
            $hwnd = [KaloriDriver]::FindByTitle($TitleMatch)
            if ($hwnd -ne [IntPtr]::Zero) { break }
            Start-Sleep -Milliseconds 500
        }
        if ($hwnd -eq [IntPtr]::Zero) { throw "No window found matching title '$TitleMatch'." }
        [KaloriDriver]::ForceForeground($hwnd) | Out-Null
        # SWP_NOZORDER=0x4. Pin to (0,0) on the primary monitor so bounds
        # never spill onto a second monitor or under/behind the taskbar.
        [KaloriDriver]::SetWindowPos($hwnd, [IntPtr]::Zero, 0, 0, $Width, $Height, 0x4) | Out-Null
        Start-Sleep -Milliseconds 300
        $r = New-Object KaloriDriver+RECT
        [KaloriDriver]::GetWindowRect($hwnd, [ref]$r) | Out-Null
        "Resized to: Left=$($r.Left) Top=$($r.Top) Right=$($r.Right) Bottom=$($r.Bottom)"
    }

    "rect" {
        $r = Get-TargetWindowRect -Title $TitleMatch
        "Left=$($r.Left) Top=$($r.Top) Right=$($r.Right) Bottom=$($r.Bottom) Width=$($r.Right-$r.Left) Height=$($r.Bottom-$r.Top)"
    }

    "screenshot" {
        if (-not $Out) { throw "screenshot requires -Out <path.png>" }
        Add-Type -AssemblyName System.Drawing
        $r = Get-TargetWindowRect -Title $TitleMatch
        $w = $r.Right - $r.Left
        $h = $r.Bottom - $r.Top
        $bmp = New-Object System.Drawing.Bitmap $w, $h
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.CopyFromScreen($r.Left, $r.Top, 0, 0, (New-Object System.Drawing.Size $w, $h))
        $bmp.Save($Out, [System.Drawing.Imaging.ImageFormat]::Png)
        $g.Dispose(); $bmp.Dispose()
        "Saved $Out (window rect: L=$($r.Left) T=$($r.Top) W=$w H=$h)"
    }

    "click" {
        $r = Get-TargetWindowRect -Title $TitleMatch
        [KaloriDriver]::Click($r.Left + $X, $r.Top + $Y)
        "Clicked image-local ($X,$Y) -> screen ($($r.Left + $X),$($r.Top + $Y))"
    }

    "type" {
        if (-not $Text) { throw "type requires -Text '<string>'" }
        Add-Type -AssemblyName System.Windows.Forms
        if ($ClearFirst) { [System.Windows.Forms.SendKeys]::SendWait("^a") }
        # SendKeys treats +^%~(){} as special; escape literal braces if ever needed.
        [System.Windows.Forms.SendKeys]::SendWait($Text)
        "Typed: $Text"
    }

    "key" {
        if (-not $Key) { throw "key requires -Key '<SendKeys token>' e.g. '{ESC}', '{TAB}', '~' (Enter)" }
        Add-Type -AssemblyName System.Windows.Forms
        [System.Windows.Forms.SendKeys]::SendWait($Key)
        "Sent key: $Key"
    }

    "stop" {
        $conn = netstat -ano | Select-String ":$Port\s" | Select-Object -First 1
        if ($conn) {
            $procId = ($conn -split '\s+')[-1]
            taskkill /PID $procId /F
            "Stopped process $procId (port $Port)"
        } else {
            "Nothing listening on port $Port"
        }
        # Also close any lingering browser window(s) from this or a past
        # session -- otherwise a stale window with the same title can
        # confuse the NEXT launch's window lookup (we hit this directly:
        # a window left open from an earlier session got picked up by a
        # fresh launch and showed frozen/stale content).
        $WM_CLOSE = 0x0010
        foreach ($hwnd in [KaloriDriver]::FindAllByTitle($TitleMatch)) {
            [KaloriDriver]::PostMessage($hwnd, $WM_CLOSE, [IntPtr]::Zero, [IntPtr]::Zero) | Out-Null
            "Closed window $hwnd matching '$TitleMatch'"
        }
    }
}
