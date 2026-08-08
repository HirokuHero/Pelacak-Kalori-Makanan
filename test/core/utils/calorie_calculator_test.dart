import 'package:flutter_test/flutter_test.dart';
import 'package:kalori_app/core/utils/calorie_calculator.dart';

void main() {
  test('computes TDEE for a male profile using Mifflin-St Jeor', () {
    final result = CalorieCalculator.targetCalories(
      gender: 'Laki-laki',
      weightKg: 70,
      heightCm: 172,
      age: 28,
      activityLevel: ActivityLevel.moderate,
    );

    // BMR = 10*70 + 6.25*172 - 5*28 + 5 = 1640; TDEE = 1640 * 1.55 = 2542
    expect(result, 2542);
  });

  test('computes TDEE for a female profile using Mifflin-St Jeor', () {
    final result = CalorieCalculator.targetCalories(
      gender: 'Perempuan',
      weightKg: 60,
      heightCm: 160,
      age: 28,
      activityLevel: ActivityLevel.sedentary,
    );

    // BMR = 10*60 + 6.25*160 - 5*28 - 161 = 1299; TDEE = 1299 * 1.2 = 1558.8
    expect(result, 1559);
  });

  test('ActivityLevel.fromStorage falls back to moderate for unknown values', () {
    expect(ActivityLevel.fromStorage('does_not_exist'), ActivityLevel.moderate);
    expect(ActivityLevel.fromStorage('very_active'), ActivityLevel.veryActive);
  });
}
