/// How physically active a user is day-to-day, used to scale BMR into a
/// daily calorie target (TDEE).
enum ActivityLevel {
  sedentary('sedentary', 'Jarang olahraga', 1.2),
  light('light', 'Olahraga ringan (1-3x/minggu)', 1.375),
  moderate('moderate', 'Olahraga sedang (3-5x/minggu)', 1.55),
  active('active', 'Olahraga berat (6-7x/minggu)', 1.725),
  veryActive('very_active', 'Sangat aktif (2x sehari)', 1.9);

  const ActivityLevel(this.storageValue, this.label, this.multiplier);

  final String storageValue;
  final String label;
  final double multiplier;

  static ActivityLevel fromStorage(String value) {
    return ActivityLevel.values.firstWhere(
      (level) => level.storageValue == value,
      orElse: () => ActivityLevel.moderate,
    );
  }
}

/// Estimates daily calorie needs using the Mifflin-St Jeor equation.
class CalorieCalculator {
  const CalorieCalculator._();

  static double bmr({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
  }) {
    final base = 10 * weightKg + 6.25 * heightCm - 5 * age;
    return gender.toLowerCase().startsWith('p') ? base - 161 : base + 5;
  }

  /// Total Daily Energy Expenditure: BMR scaled by activity level.
  static int targetCalories({
    required String gender,
    required double weightKg,
    required double heightCm,
    required int age,
    required ActivityLevel activityLevel,
  }) {
    final value = bmr(
          gender: gender,
          weightKg: weightKg,
          heightCm: heightCm,
          age: age,
        ) *
        activityLevel.multiplier;
    return value.round();
  }
}
