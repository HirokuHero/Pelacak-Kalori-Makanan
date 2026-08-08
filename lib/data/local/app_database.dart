import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

// All reads/writes in this app go through drift's type-safe query builder
// (`select`, `where(...equals(...))`, `insert`, `update`) instead of hand-
// written SQL strings. Drift compiles these to parameterized statements —
// values are always sent as bound `?` parameters, never string-concatenated
// into the query — so SQL injection isn't a reachable code path here. Keep
// it that way: avoid `customSelect`/`customStatement` with interpolated
// user input; if a raw query is ever unavoidable, bind values via
// `Variable(...)` rather than string interpolation.

/// One row per logged food item (the "Scan"/history entries).
class FoodEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text().withLength(min: 1, max: 100)();
  IntColumn get calories => integer()();
  RealColumn get protein => real().nullable()();
  RealColumn get carbs => real().nullable()();
  RealColumn get fat => real().nullable()();
  TextColumn get category => text().withLength(min: 1, max: 30)();
  DateTimeColumn get consumedAt => dateTime()();
}

/// Single-row table holding the signed-in user's profile.
class UserProfiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 100)();
  TextColumn get email => text()();
  TextColumn get gender => text()();
  IntColumn get age => integer().withDefault(const Constant(28))();
  RealColumn get currentWeight => real()();
  RealColumn get targetWeight => real()();
  RealColumn get height => real()();
  TextColumn get activityLevel =>
      text().withDefault(const Constant('moderate'))();
}

@DriftDatabase(tables: [FoodEntries, UserProfiles])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) => m.createAll(),
        onUpgrade: (m, from, to) async {
          if (from < 2) {
            await m.addColumn(userProfiles, userProfiles.age);
            await m.addColumn(userProfiles, userProfiles.activityLevel);
          }
        },
      );

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'kalori_app',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }
}
