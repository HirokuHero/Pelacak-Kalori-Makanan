import 'package:flutter/material.dart';

import '../../data/profile_repository.dart';
import '../../routes/app_routes.dart';
import '../../widgets/home_back_scaffold.dart';
import '../../widgets/info_card.dart';

class ProfileScreen extends StatelessWidget {
  final ProfileRepository _repository;

  const ProfileScreen(
      {super.key, ProfileRepository repository = const ProfileRepository()})
      : _repository = repository;

  @override
  Widget build(BuildContext context) {
    final profile = _repository.getProfile();

    return HomeBackScaffold(
      title: 'Profile',
      body: ListView(
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
    );
  }
}
