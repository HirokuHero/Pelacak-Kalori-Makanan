import 'package:drift/drift.dart';

import '../local/app_database.dart';

/// Reads and writes the signed-in user's profile, backed by [AppDatabase].
class ProfileRepository {
  final AppDatabase _db;

  const ProfileRepository(this._db);

  static final _defaultProfile = UserProfilesCompanion.insert(
    name: 'Budi Santoso',
    email: 'budi@example.com',
    gender: 'Laki-laki',
    age: const Value(28),
    currentWeight: 70.0,
    targetWeight: 65.0,
    height: 172.0,
    activityLevel: const Value('moderate'),
  );

  /// Emits the profile, seeded with a default the first time it's read.
  Stream<UserProfile> watchProfile() async* {
    final existing =
        await (_db.select(_db.userProfiles)..limit(1)).getSingleOrNull();
    if (existing == null) {
      await _db.into(_db.userProfiles).insert(_defaultProfile);
    }
    yield* _db.select(_db.userProfiles).watchSingle();
  }

  Future<void> updateProfile(int id, UserProfilesCompanion changes) {
    return (_db.update(_db.userProfiles)..where((t) => t.id.equals(id)))
        .write(changes);
  }
}
