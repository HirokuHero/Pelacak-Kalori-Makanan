import 'package:drift/drift.dart';

import '../local/app_database.dart';

/// Reads and writes logged food entries, backed by [AppDatabase].
class HistoryRepository {
  final AppDatabase _db;

  const HistoryRepository(this._db);

  List<FoodEntriesCompanion> _seed() {
    final now = DateTime.now();
    DateTime at(int hour, int minute) =>
        DateTime(now.year, now.month, now.day, hour, minute);

    return [
      FoodEntriesCompanion.insert(
        title: 'Ayam Panggang',
        calories: 450,
        category: 'Sarapan',
        consumedAt: at(8, 15),
      ),
      FoodEntriesCompanion.insert(
        title: 'Nasi + Telur',
        calories: 520,
        category: 'Makan Siang',
        consumedAt: at(12, 30),
      ),
      FoodEntriesCompanion.insert(
        title: 'Salad Buah',
        calories: 180,
        category: 'Snack',
        consumedAt: at(17, 45),
      ),
      FoodEntriesCompanion.insert(
        title: 'Sate Ayam',
        calories: 330,
        category: 'Makan Malam',
        consumedAt: at(20, 10),
      ),
    ];
  }

  /// Emits the food log, seeded with sample entries the first time it's read.
  Stream<List<FoodEntry>> watchAll() async* {
    final existing = await _db.select(_db.foodEntries).get();
    if (existing.isEmpty) {
      await _db.batch((batch) => batch.insertAll(_db.foodEntries, _seed()));
    }

    final query = _db.select(_db.foodEntries)
      ..orderBy([(t) => OrderingTerm(expression: t.consumedAt)]);
    yield* query.watch();
  }
}
