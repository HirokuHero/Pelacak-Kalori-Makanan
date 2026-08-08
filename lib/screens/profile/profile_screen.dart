import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/calorie_calculator.dart';
import '../../data/providers.dart';
import '../../routes/app_routes.dart';
import '../../widgets/home_back_scaffold.dart';
import '../../widgets/info_card.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(profileProvider);

    return HomeBackScaffold(
      title: 'Profile',
      actions: [
        profileAsync.maybeWhen(
          data: (profile) => IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit Profil',
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EditProfileScreen(profile: profile),
              ),
            ),
          ),
          orElse: () => const SizedBox.shrink(),
        ),
      ],
      body: profileAsync.when(
        data: (profile) => ListView(
          padding: const EdgeInsets.all(16),
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: const Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 16),
            Text(
              profile.name,
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              profile.email,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            InfoCard(
              icon: Icons.wc,
              label: 'Jenis kelamin',
              value: profile.gender,
            ),
            InfoCard(
              icon: Icons.scale,
              label: 'Berat saat ini',
              value: '${profile.currentWeight.toStringAsFixed(1)} kg',
            ),
            InfoCard(
              icon: Icons.flag,
              label: 'Target berat badan',
              value: '${profile.targetWeight.toStringAsFixed(1)} kg',
            ),
            InfoCard(
              icon: Icons.height,
              label: 'Tinggi',
              value: '${profile.height.toStringAsFixed(1)} cm',
            ),
            InfoCard(
              icon: Icons.cake,
              label: 'Usia',
              value: '${profile.age} tahun',
            ),
            InfoCard(
              icon: Icons.directions_run,
              label: 'Level aktivitas',
              value: ActivityLevel.fromStorage(profile.activityLevel).label,
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, AppRoutes.login);
                },
                child: const Text('Logout'),
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(child: Text('Gagal memuat profil: $error')),
      ),
    );
  }
}
