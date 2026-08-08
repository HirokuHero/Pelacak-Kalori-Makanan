import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/calorie_calculator.dart';
import '../../data/local/app_database.dart';
import '../../data/providers.dart';
import '../../widgets/primary_button.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  final UserProfile profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late final _nameController =
      TextEditingController(text: widget.profile.name);
  late final _emailController =
      TextEditingController(text: widget.profile.email);
  late final _ageController =
      TextEditingController(text: widget.profile.age.toString());
  late final _currentWeightController =
      TextEditingController(text: widget.profile.currentWeight.toString());
  late final _targetWeightController =
      TextEditingController(text: widget.profile.targetWeight.toString());
  late final _heightController =
      TextEditingController(text: widget.profile.height.toString());

  late String _gender = widget.profile.gender;
  late ActivityLevel _activityLevel =
      ActivityLevel.fromStorage(widget.profile.activityLevel);

  bool _saving = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    _currentWeightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _saving = true);

    await ref.read(profileRepositoryProvider).updateProfile(
          widget.profile.id,
          UserProfilesCompanion(
            name: Value(_nameController.text.trim()),
            email: Value(_emailController.text.trim()),
            gender: Value(_gender),
            age: Value(int.parse(_ageController.text)),
            currentWeight: Value(double.parse(_currentWeightController.text)),
            targetWeight: Value(double.parse(_targetWeightController.text)),
            height: Value(double.parse(_heightController.text)),
            activityLevel: Value(_activityLevel.storageValue),
          ),
        );

    if (mounted) Navigator.pop(context);
  }

  String? _requiredNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'Wajib diisi';
    if (double.tryParse(value) == null) return 'Harus berupa angka';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profil')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) =>
                    (v == null || v.trim().isEmpty) ? 'Wajib diisi' : null,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _gender,
                decoration: const InputDecoration(labelText: 'Jenis kelamin'),
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (v) => setState(() => _gender = v ?? _gender),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _ageController,
                decoration: const InputDecoration(labelText: 'Usia (tahun)'),
                keyboardType: TextInputType.number,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Wajib diisi';
                  if (int.tryParse(v) == null) return 'Harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _currentWeightController,
                decoration:
                    const InputDecoration(labelText: 'Berat saat ini (kg)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _targetWeightController,
                decoration:
                    const InputDecoration(labelText: 'Target berat badan (kg)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _heightController,
                decoration: const InputDecoration(labelText: 'Tinggi (cm)'),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: _requiredNumber,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<ActivityLevel>(
                initialValue: _activityLevel,
                decoration: const InputDecoration(labelText: 'Level aktivitas'),
                items: ActivityLevel.values
                    .map((level) => DropdownMenuItem(
                          value: level,
                          child: Text(level.label),
                        ))
                    .toList(),
                onChanged: (v) =>
                    setState(() => _activityLevel = v ?? _activityLevel),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _saving ? 'Menyimpan...' : 'Simpan',
                onPressed: _saving ? null : _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
