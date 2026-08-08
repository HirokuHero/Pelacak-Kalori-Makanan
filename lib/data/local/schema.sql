-- Reference copy of the SQLite schema generated and managed by drift.
--
-- This file is NOT read by the app — drift builds and runs this schema
-- from the Dart table definitions in app_database.dart (and its generated
-- counterpart app_database.g.dart) at runtime. It exists purely as
-- human-readable documentation of the current database structure
-- (schemaVersion 2).

CREATE TABLE IF NOT EXISTS food_entries (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    title TEXT NOT NULL CHECK (LENGTH(title) BETWEEN 1 AND 100),
    calories INTEGER NOT NULL,
    protein REAL NULL,
    carbs REAL NULL,
    fat REAL NULL,
    category TEXT NOT NULL CHECK (LENGTH(category) BETWEEN 1 AND 30),
    consumed_at DATETIME NOT NULL
);

CREATE TABLE IF NOT EXISTS user_profiles (
    id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL CHECK (LENGTH(name) BETWEEN 1 AND 100),
    email TEXT NOT NULL,
    gender TEXT NOT NULL,
    age INTEGER NOT NULL DEFAULT 28,
    current_weight REAL NOT NULL,
    target_weight REAL NOT NULL,
    height REAL NOT NULL,
    activity_level TEXT NOT NULL DEFAULT 'moderate'
);
