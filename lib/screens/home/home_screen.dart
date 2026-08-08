import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/providers.dart';
import '../../routes/app_routes.dart';
import '../../widgets/info_card.dart';
import '../../widgets/kalori_bottom_nav.dart';
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
            setState(() => selectedIndex = index);
          },
        ),
        floatingActionButton: selectedIndex == 0
            ? FloatingActionButton.extended(
                onPressed: () => setState(() => selectedIndex = 1),
                icon: const Icon(Icons.camera_alt),
                label: const Text('Scan'),
              )
            : null,
      ),
    );
  }
}

class _HomeTab extends ConsumerWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetCalories = ref.watch(targetCaloriesProvider);

    return Scaffold(
      appBar:
          AppBar(automaticallyImplyLeading: false, title: const Text('Home')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 8),
            const Text(
              'Selamat Datang',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            InfoCard(
              icon: Icons.local_fire_department,
              label: 'Target Kalori',
              value: targetCalories.when(
                data: (value) => '$value kcal',
                loading: () => '...',
                error: (_, __) => '-',
              ),
            ),
            const InfoCard(
              icon: Icons.restaurant,
              label: 'Target Protein',
              value: '120 g',
            ),
            const InfoCard(
              icon: Icons.water_drop,
              label: 'Target Air Minum',
              value: '2.5 L',
            ),
          ],
        ),
      ),
    );
  }
}
