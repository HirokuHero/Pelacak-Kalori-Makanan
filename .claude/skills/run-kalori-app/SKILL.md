---
name: run-kalori-app
description: Build, run, and visually drive kalori_app (Flutter). Use when asked to start kalori_app, launch it, take a screenshot of its UI, click through its screens, or verify a change works in the real running app.
---

kalori_app is a Flutter app with no chromium-cli/Node/Python on this
machine, so it's driven as a Chrome web build via raw Win32 API calls
from PowerShell: `.claude/skills/run-kalori-app/driver.ps1`. The
driver launches `flutter run -d chrome`, finds the browser window by
title, and exposes `resize` / `screenshot` / `click` / `type` / `key`
/ `stop` subcommands. All paths below are relative to the repo root
(`C:\Users\HP\Desktop\kalori_app`).

## Prerequisites

- Flutter SDK on `PATH` (already present on this machine — `flutter --version` works).
- Google Chrome (already present — `flutter devices` lists it as `chrome`).
- `flutter run -d windows` does **NOT** work on this machine (no Visual
  Studio C++ toolchain installed — fails with "Unable to find suitable
  Visual Studio toolchain"). Chrome is the only reliably drivable target
  here; don't try `-d windows` again without first checking `flutter doctor`.

No separate build step — `flutter run` compiles and launches in one go.

## Run (agent path)

```powershell
powershell -File ".claude\skills\run-kalori-app\driver.ps1" launch
```

Waits (up to 90s) for `flutter run` to report ready, or prints `ERROR`/`TIMEOUT` with the log. Then, **always** pin the window to a known size before doing anything else (see Gotchas — a maximized window can land off the visible screen on this multi-monitor machine):

```powershell
powershell -File ".claude\skills\run-kalori-app\driver.ps1" resize -Width 1200 -Height 800
```

Now drive it. `click`/`type`/`key` all target whatever **Chrome**
window's title contains "kalori" (default `-TitleMatch`, matches both
the transient tab title right after launch and the final "Kalori App"
MaterialApp title — see Gotchas), refinding and refocusing it every
call, so it's fine to interleave with other work on the machine.

| command | what it does |
|---|---|
| `rect` | prints the live window bounds (debug aid) |
| `screenshot -Out <path.png>` | screenshots the window, prints the rect used |
| `click -X <int> -Y <int>` | clicks a point — **image-local pixels from your last screenshot**, not screen pixels; the script adds the window's live offset for you |
| `type -Text "<string>" [-ClearFirst]` | sends keystrokes to whatever has focus; `-ClearFirst` sends Ctrl+A first to replace existing field content |
| `key -Key "{ESC}"` | sends a special key using [SendKeys](https://learn.microsoft.com/en-us/dotnet/api/system.windows.forms.sendkeys) syntax (`{ESC}`, `{TAB}`, `~` for Enter, `^a` for Ctrl+A, ...) |
| `stop [-Port 5757]` | kills the dev-server process on that port AND closes any lingering matching browser window(s) (see Gotchas) |

Example end-to-end run (this exact sequence, with these exact
coordinates, was run twice in verification — once to confirm the
login → Home → Scan flow, once fully clean after fixing the gotchas
below):

```powershell
powershell -File ".claude\skills\run-kalori-app\driver.ps1" launch
powershell -File ".claude\skills\run-kalori-app\driver.ps1" resize -Width 1200 -Height 800
powershell -File ".claude\skills\run-kalori-app\driver.ps1" screenshot -Out shot1.png
# <read shot1.png, locate the Username field, e.g. at image (300,235)>
powershell -File ".claude\skills\run-kalori-app\driver.ps1" click -X 300 -Y 235
powershell -File ".claude\skills\run-kalori-app\driver.ps1" type -Text "admin"
powershell -File ".claude\skills\run-kalori-app\driver.ps1" click -X 300 -Y 300
powershell -File ".claude\skills\run-kalori-app\driver.ps1" type -Text "admin" -ClearFirst
powershell -File ".claude\skills\run-kalori-app\driver.ps1" click -X 800 -Y 378   # Masuk button
powershell -File ".claude\skills\run-kalori-app\driver.ps1" screenshot -Out shot2.png
# <read shot2.png -- if Chrome's "Save password?" dialog is covering
#  the screen, click its "No thanks" button (image coords vary slightly
#  by window size; it's in the dialog's bottom-right) rather than
#  trying {ESC} -- ESC does not dismiss this dialog, it's native Chrome
#  UI outside the page's keyboard focus>
powershell -File ".claude\skills\run-kalori-app\driver.ps1" stop
```

Screenshots → wherever you pass to `-Out` (this skill's own verification shots are gitignored in `shots/`; use your scratchpad for one-off runs). Flutter's own log → `%TEMP%\kalori_app_flutter_run.log` by default.

**There is no DOM/accessibility tree here** — Flutter web (CanvasKit)
paints everything to a `<canvas>`, so every interaction is
screenshot-then-coordinate-click. Read the screenshot after every
click that's supposed to change focus/state before issuing the next
one — don't chain blind clicks.

## Run (human path)

```powershell
flutter run -d chrome
```

Opens a visible Chrome window a person can click through normally. `q` in the terminal quits it.

## Test

```bash
flutter analyze
```

No `test/` files currently exist in this project (empty `test/` dir) — `flutter analyze` is the only automated check.

---

## Gotchas

- **Must call `SetProcessDPIAware()` at the top of every PowerShell
  invocation.** Each `powershell -File` call is a fresh process, and
  without it, `GetWindowRect`/`CopyFromScreen` report DPI-virtualized
  (scaled-down) coordinates while `SetCursorPos` expects physical
  pixels — clicks silently land on the wrong element (one field lower
  than intended, in our case). `driver.ps1` does this automatically at
  the top of the script; if you ever bypass the driver and write raw
  Win32 calls yourself, you must do the same.
- **Multi-monitor + maximize is unpredictable.** This machine has two
  monitors of different resolutions (`1536x864` primary + `1920x1080`
  secondary). A freshly-launched Chrome window can maximize to bounds
  taller than the primary monitor's visible work area (we saw
  `1600x1104` on a `1536x864`/`816`-working-area primary display),
  which pushes page content — specifically the bottom nav bar — down
  past the taskbar and out of any screenshot. Always run `resize`
  right after `launch`, before the first `rect`/`screenshot`/`click`,
  to pin the window to a small size fully inside the primary monitor.
- **`SetForegroundWindow` alone is routinely ignored** when called
  from a background/non-interactive process (Windows foreground-lock).
  The driver works around this with a fake Alt keypress
  (`keybd_event`) + `AttachThreadInput` + `BringWindowToTop` +
  `SetForegroundWindow`, retried up to 3x. If you ever see clicks
  landing on some *other* window (e.g. a chat app, file explorer),
  it's because this handshake failed silently — check
  `GetForegroundWindow()` actually equals your target hwnd before
  trusting subsequent coordinates.
- **Window position/size can drift between calls even without you
  doing anything** — we observed Chrome's window resize itself between
  two otherwise-identical calls. Don't cache a rect from an earlier
  step; `driver.ps1`'s `click`/`screenshot` always re-fetch it live,
  and you should always take a fresh screenshot before computing new
  click coordinates rather than reusing ones from several steps ago.
- **Chrome's native "Save password?" popup** appears after submitting
  the login form and covers a chunk of the window. `key -Key "{ESC}"`
  does **not** dismiss it — it's native Chrome UI, not part of the
  page, so it ignores keystrokes sent to the page's focus. Screenshot
  after submit, and if the dialog is there, `click` its "No thanks"
  button directly.
- **A stray window from a previous session can be mistaken for the
  live one.** We hit this directly: an old Chrome window left open
  from an earlier session had the exact same title as a freshly
  launched one, and the driver's title search grabbed the stale one
  first, screenshotting frozen/stale content. Two defenses are already
  built into `driver.ps1`: (1) window matching filters on Chrome's
  window class (`Chrome_WidgetWin_1`), not just title substring, so
  unrelated windows (e.g. a File Explorer window titled with the
  project folder name) can never match; (2) `Get-TargetWindowRect`
  prints a `WARNING` when more than one Chrome window matches. If you
  ever see that warning, run `stop` first (it closes all matching
  windows) and relaunch, rather than trusting which one got picked.
- **Right after `launch` reports `READY`, Chrome's tab title is
  briefly the bare project folder name** (`kalori_app`), not yet the
  app's `MaterialApp.title` ("Kalori App") — that only gets set once
  Flutter's first frame actually paints, a moment after the VM service
  connects. A title match of exactly `"Kalori App"` can race and miss
  the window during that gap. `driver.ps1` defaults `-TitleMatch` to
  the lowercase substring `"kalori"`, which matches both the
  transient and final titles, plus retries window lookup for up to 5s
  in `resize`/`rect`/`screenshot`/`click` to absorb the gap — don't
  narrow `-TitleMatch` back to the full "Kalori App" string, it'll
  reintroduce this race.
- **`flutter run -d windows` fails on this machine** (missing Visual
  Studio C++ toolchain) — don't waste a round-trip retrying it; go
  straight to `-d chrome`.

## Troubleshooting

- **`Error: Unable to find suitable Visual Studio toolchain`**: happens
  with `flutter run -d windows` on this machine. Use `-d chrome`
  instead (what `driver.ps1 launch` does).
- **Click lands on the wrong field/element**: almost always the DPI
  issue above. Confirm by comparing a `rect` call's reported `Width`
  to `[System.Windows.Forms.Screen]::PrimaryScreen.Bounds` — if `rect`
  reports something implausibly large (e.g. wider than the primary
  monitor), DPI virtualization or a stray second-monitor placement is
  the cause. Re-run `resize`.
- **`launch` prints `TIMEOUT`**: check the printed log tail — usually
  either the port is already in use (run `stop` first) or
  `flutter pub get` is needed (run it manually, then retry `launch`).
