import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/calorie_calculator.dart';
import 'local/app_database.dart';
import 'repositories/history_repository.dart';
import 'repositories/profile_repository.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.watch(appDatabaseProvider));
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository(ref.watch(appDatabaseProvider));
});

final historyListProvider = StreamProvider<List<FoodEntry>>((ref) {
  return ref.watch(historyRepositoryProvider).watchAll();
});

final profileProvider = StreamProvider<UserProfile>((ref) {
  return ref.watch(profileRepositoryProvider).watchProfile();
});

/// Daily calorie target computed from the profile via Mifflin-St Jeor,
/// re-evaluated whenever the profile changes.
final targetCaloriesProvider = Provider<AsyncValue<int>>((ref) {
  return ref.watch(profileProvider).whenData(
        (profile) => CalorieCalculator.targetCalories(
          gender: profile.gender,
          weightKg: profile.currentWeight,
          heightCm: profile.height,
          age: profile.age,
          activityLevel: ActivityLevel.fromStorage(profile.activityLevel),
        ),
      );
});
