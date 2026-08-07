import '../models/dummy_models.dart';

/// Provides profile data. Currently backed by dummy data;
/// swap the implementation for a real data source later.
class ProfileRepository {
  const ProfileRepository();

  ProfileData getProfile() {
    return const ProfileData(
      name: 'Budi Santoso',
      email: 'budi@example.com',
      gender: 'Laki-laki',
      currentWeight: 70.0,
      targetWeight: 65.0,
      height: 172.0,
    );
  }
}
