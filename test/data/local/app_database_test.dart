import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kalori_app/data/local/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('insert and read back a food entry', () async {
    final id = await db.into(db.foodEntries).insert(
          FoodEntriesCompanion.insert(
            title: 'Nasi Goreng',
            calories: 450,
            category: 'Makan Siang',
            consumedAt: DateTime(2026, 8, 7, 12, 30),
            protein: const Value(15.0),
          ),
        );

    final stored = await (db.select(db.foodEntries)
          ..where((t) => t.id.equals(id)))
        .getSingle();

    expect(stored.title, 'Nasi Goreng');
    expect(stored.calories, 450);
    expect(stored.category, 'Makan Siang');
    expect(stored.protein, 15.0);
  });

  test('insert and read back a user profile', () async {
    await db.into(db.userProfiles).insert(
          UserProfilesCompanion.insert(
            name: 'Budi Santoso',
            email: 'budi@example.com',
            gender: 'Laki-laki',
            currentWeight: 70.0,
            targetWeight: 65.0,
            height: 172.0,
          ),
        );

    final profiles = await db.select(db.userProfiles).get();

    expect(profiles, hasLength(1));
    expect(profiles.single.name, 'Budi Santoso');
    expect(profiles.single.currentWeight, 70.0);
  });

  test('food entries persist across queries within the same session', () async {
    await db.into(db.foodEntries).insert(
          FoodEntriesCompanion.insert(
            title: 'Salad Buah',
            calories: 180,
            category: 'Snack',
            consumedAt: DateTime(2026, 8, 7, 17, 45),
          ),
        );

    final all = await db.select(db.foodEntries).get();
    expect(all, hasLength(1));
  });
}
