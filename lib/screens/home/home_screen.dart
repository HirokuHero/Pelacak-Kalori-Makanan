import 'package:flutter/material.dart';

import '../../../routes/app_routes.dart';
import '../../../widgets/kalori_bottom_nav.dart';
import '../history/history_screen.dart';
import '../profile/profile_screen.dart';
import '../scan/scan_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final pages = const [
    _HomeTab(),
    ScanScreen(),
    HistoryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        Navigator.pushReplacementNamed(context, AppRoutes.home);
      },
      child: Scaffold(
        body: pages[selectedIndex],
        bottomNavigationBar: KaloriBottomNav(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        floatingActionButton: selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () {
                  // Navigasi ke scan tab
                  setState(() => selectedIndex = 1);
                  Navigator.pushReplacementNamed(context, AppRoutes.scan);
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan'),
              )
            : null,
      ),
    );
  }
}

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: false, title: const Text('Home')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            SizedBox(height: 8),
            Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16),
            _TargetCard(
              title: 'Target Kalori',
              value: '2000 kcal',
              icon: Icons.local_fire_department,
            ),
            _TargetCard(
              title: 'Target Protein',
              value: '120 g',
              icon: Icons.restaurant,
            ),
            _TargetCard(
              title: 'Target Air Minum',
              value: '2.5 L',
              icon: Icons.water_drop,
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _TargetCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
