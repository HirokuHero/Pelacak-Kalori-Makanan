// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FoodEntriesTable extends FoodEntries
    with TableInfo<$FoodEntriesTable, FoodEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FoodEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _caloriesMeta =
      const VerificationMeta('calories');
  @override
  late final GeneratedColumn<int> calories = GeneratedColumn<int>(
      'calories', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _proteinMeta =
      const VerificationMeta('protein');
  @override
  late final GeneratedColumn<double> protein = GeneratedColumn<double>(
      'protein', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _carbsMeta = const VerificationMeta('carbs');
  @override
  late final GeneratedColumn<double> carbs = GeneratedColumn<double>(
      'carbs', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _fatMeta = const VerificationMeta('fat');
  @override
  late final GeneratedColumn<double> fat = GeneratedColumn<double>(
      'fat', aliasedName, true,
      type: DriftSqlType.double, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _consumedAtMeta =
      const VerificationMeta('consumedAt');
  @override
  late final GeneratedColumn<DateTime> consumedAt = GeneratedColumn<DateTime>(
      'consumed_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, calories, protein, carbs, fat, category, consumedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'food_entries';
  @override
  VerificationContext validateIntegrity(Insertable<FoodEntry> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('calories')) {
      context.handle(_caloriesMeta,
          calories.isAcceptableOrUnknown(data['calories']!, _caloriesMeta));
    } else if (isInserting) {
      context.missing(_caloriesMeta);
    }
    if (data.containsKey('protein')) {
      context.handle(_proteinMeta,
          protein.isAcceptableOrUnknown(data['protein']!, _proteinMeta));
    }
    if (data.containsKey('carbs')) {
      context.handle(
          _carbsMeta, carbs.isAcceptableOrUnknown(data['carbs']!, _carbsMeta));
    }
    if (data.containsKey('fat')) {
      context.handle(
          _fatMeta, fat.isAcceptableOrUnknown(data['fat']!, _fatMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('consumed_at')) {
      context.handle(
          _consumedAtMeta,
          consumedAt.isAcceptableOrUnknown(
              data['consumed_at']!, _consumedAtMeta));
    } else if (isInserting) {
      context.missing(_consumedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FoodEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FoodEntry(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      calories: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}calories'])!,
      protein: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}protein']),
      carbs: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}carbs']),
      fat: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}fat']),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      consumedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}consumed_at'])!,
    );
  }

  @override
  $FoodEntriesTable createAlias(String alias) {
    return $FoodEntriesTable(attachedDatabase, alias);
  }
}

class FoodEntry extends DataClass implements Insertable<FoodEntry> {
  final int id;
  final String title;
  final int calories;
  final double? protein;
  final double? carbs;
  final double? fat;
  final String category;
  final DateTime consumedAt;
  const FoodEntry(
      {required this.id,
      required this.title,
      required this.calories,
      this.protein,
      this.carbs,
      this.fat,
      required this.category,
      required this.consumedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['calories'] = Variable<int>(calories);
    if (!nullToAbsent || protein != null) {
      map['protein'] = Variable<double>(protein);
    }
    if (!nullToAbsent || carbs != null) {
      map['carbs'] = Variable<double>(carbs);
    }
    if (!nullToAbsent || fat != null) {
      map['fat'] = Variable<double>(fat);
    }
    map['category'] = Variable<String>(category);
    map['consumed_at'] = Variable<DateTime>(consumedAt);
    return map;
  }

  FoodEntriesCompanion toCompanion(bool nullToAbsent) {
    return FoodEntriesCompanion(
      id: Value(id),
      title: Value(title),
      calories: Value(calories),
      protein: protein == null && nullToAbsent
          ? const Value.absent()
          : Value(protein),
      carbs:
          carbs == null && nullToAbsent ? const Value.absent() : Value(carbs),
      fat: fat == null && nullToAbsent ? const Value.absent() : Value(fat),
      category: Value(category),
      consumedAt: Value(consumedAt),
    );
  }

  factory FoodEntry.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FoodEntry(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      calories: serializer.fromJson<int>(json['calories']),
      protein: serializer.fromJson<double?>(json['protein']),
      carbs: serializer.fromJson<double?>(json['carbs']),
      fat: serializer.fromJson<double?>(json['fat']),
      category: serializer.fromJson<String>(json['category']),
      consumedAt: serializer.fromJson<DateTime>(json['consumedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'calories': serializer.toJson<int>(calories),
      'protein': serializer.toJson<double?>(protein),
      'carbs': serializer.toJson<double?>(carbs),
      'fat': serializer.toJson<double?>(fat),
      'category': serializer.toJson<String>(category),
      'consumedAt': serializer.toJson<DateTime>(consumedAt),
    };
  }

  FoodEntry copyWith(
          {int? id,
          String? title,
          int? calories,
          Value<double?> protein = const Value.absent(),
          Value<double?> carbs = const Value.absent(),
          Value<double?> fat = const Value.absent(),
          String? category,
          DateTime? consumedAt}) =>
      FoodEntry(
        id: id ?? this.id,
        title: title ?? this.title,
        calories: calories ?? this.calories,
        protein: protein.present ? protein.value : this.protein,
        carbs: carbs.present ? carbs.value : this.carbs,
        fat: fat.present ? fat.value : this.fat,
        category: category ?? this.category,
        consumedAt: consumedAt ?? this.consumedAt,
      );
  FoodEntry copyWithCompanion(FoodEntriesCompanion data) {
    return FoodEntry(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      calories: data.calories.present ? data.calories.value : this.calories,
      protein: data.protein.present ? data.protein.value : this.protein,
      carbs: data.carbs.present ? data.carbs.value : this.carbs,
      fat: data.fat.present ? data.fat.value : this.fat,
      category: data.category.present ? data.category.value : this.category,
      consumedAt:
          data.consumedAt.present ? data.consumedAt.value : this.consumedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntry(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('category: $category, ')
          ..write('consumedAt: $consumedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, title, calories, protein, carbs, fat, category, consumedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FoodEntry &&
          other.id == this.id &&
          other.title == this.title &&
          other.calories == this.calories &&
          other.protein == this.protein &&
          other.carbs == this.carbs &&
          other.fat == this.fat &&
          other.category == this.category &&
          other.consumedAt == this.consumedAt);
}

class FoodEntriesCompanion extends UpdateCompanion<FoodEntry> {
  final Value<int> id;
  final Value<String> title;
  final Value<int> calories;
  final Value<double?> protein;
  final Value<double?> carbs;
  final Value<double?> fat;
  final Value<String> category;
  final Value<DateTime> consumedAt;
  const FoodEntriesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.calories = const Value.absent(),
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    this.category = const Value.absent(),
    this.consumedAt = const Value.absent(),
  });
  FoodEntriesCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required int calories,
    this.protein = const Value.absent(),
    this.carbs = const Value.absent(),
    this.fat = const Value.absent(),
    required String category,
    required DateTime consumedAt,
  })  : title = Value(title),
        calories = Value(calories),
        category = Value(category),
        consumedAt = Value(consumedAt);
  static Insertable<FoodEntry> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<int>? calories,
    Expression<double>? protein,
    Expression<double>? carbs,
    Expression<double>? fat,
    Expression<String>? category,
    Expression<DateTime>? consumedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (calories != null) 'calories': calories,
      if (protein != null) 'protein': protein,
      if (carbs != null) 'carbs': carbs,
      if (fat != null) 'fat': fat,
      if (category != null) 'category': category,
      if (consumedAt != null) 'consumed_at': consumedAt,
    });
  }

  FoodEntriesCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<int>? calories,
      Value<double?>? protein,
      Value<double?>? carbs,
      Value<double?>? fat,
      Value<String>? category,
      Value<DateTime>? consumedAt}) {
    return FoodEntriesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      calories: calories ?? this.calories,
      protein: protein ?? this.protein,
      carbs: carbs ?? this.carbs,
      fat: fat ?? this.fat,
      category: category ?? this.category,
      consumedAt: consumedAt ?? this.consumedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (calories.present) {
      map['calories'] = Variable<int>(calories.value);
    }
    if (protein.present) {
      map['protein'] = Variable<double>(protein.value);
    }
    if (carbs.present) {
      map['carbs'] = Variable<double>(carbs.value);
    }
    if (fat.present) {
      map['fat'] = Variable<double>(fat.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (consumedAt.present) {
      map['consumed_at'] = Variable<DateTime>(consumedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FoodEntriesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('calories: $calories, ')
          ..write('protein: $protein, ')
          ..write('carbs: $carbs, ')
          ..write('fat: $fat, ')
          ..write('category: $category, ')
          ..write('consumedAt: $consumedAt')
          ..write(')'))
        .toString();
  }
}

class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _genderMeta = const VerificationMeta('gender');
  @override
  late final GeneratedColumn<String> gender = GeneratedColumn<String>(
      'gender', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _ageMeta = const VerificationMeta('age');
  @override
  late final GeneratedColumn<int> age = GeneratedColumn<int>(
      'age', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(28));
  static const VerificationMeta _currentWeightMeta =
      const VerificationMeta('currentWeight');
  @override
  late final GeneratedColumn<double> currentWeight = GeneratedColumn<double>(
      'current_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _targetWeightMeta =
      const VerificationMeta('targetWeight');
  @override
  late final GeneratedColumn<double> targetWeight = GeneratedColumn<double>(
      'target_weight', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _heightMeta = const VerificationMeta('height');
  @override
  late final GeneratedColumn<double> height = GeneratedColumn<double>(
      'height', aliasedName, false,
      type: DriftSqlType.double, requiredDuringInsert: true);
  static const VerificationMeta _activityLevelMeta =
      const VerificationMeta('activityLevel');
  @override
  late final GeneratedColumn<String> activityLevel = GeneratedColumn<String>(
      'activity_level', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('moderate'));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        email,
        gender,
        age,
        currentWeight,
        targetWeight,
        height,
        activityLevel
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(Insertable<UserProfile> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('gender')) {
      context.handle(_genderMeta,
          gender.isAcceptableOrUnknown(data['gender']!, _genderMeta));
    } else if (isInserting) {
      context.missing(_genderMeta);
    }
    if (data.containsKey('age')) {
      context.handle(
          _ageMeta, age.isAcceptableOrUnknown(data['age']!, _ageMeta));
    }
    if (data.containsKey('current_weight')) {
      context.handle(
          _currentWeightMeta,
          currentWeight.isAcceptableOrUnknown(
              data['current_weight']!, _currentWeightMeta));
    } else if (isInserting) {
      context.missing(_currentWeightMeta);
    }
    if (data.containsKey('target_weight')) {
      context.handle(
          _targetWeightMeta,
          targetWeight.isAcceptableOrUnknown(
              data['target_weight']!, _targetWeightMeta));
    } else if (isInserting) {
      context.missing(_targetWeightMeta);
    }
    if (data.containsKey('height')) {
      context.handle(_heightMeta,
          height.isAcceptableOrUnknown(data['height']!, _heightMeta));
    } else if (isInserting) {
      context.missing(_heightMeta);
    }
    if (data.containsKey('activity_level')) {
      context.handle(
          _activityLevelMeta,
          activityLevel.isAcceptableOrUnknown(
              data['activity_level']!, _activityLevelMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      gender: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}gender'])!,
      age: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}age'])!,
      currentWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}current_weight'])!,
      targetWeight: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}target_weight'])!,
      height: attachedDatabase.typeMapping
          .read(DriftSqlType.double, data['${effectivePrefix}height'])!,
      activityLevel: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}activity_level'])!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final int id;
  final String name;
  final String email;
  final String gender;
  final int age;
  final double currentWeight;
  final double targetWeight;
  final double height;
  final String activityLevel;
  const UserProfile(
      {required this.id,
      required this.name,
      required this.email,
      required this.gender,
      required this.age,
      required this.currentWeight,
      required this.targetWeight,
      required this.height,
      required this.activityLevel});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['email'] = Variable<String>(email);
    map['gender'] = Variable<String>(gender);
    map['age'] = Variable<int>(age);
    map['current_weight'] = Variable<double>(currentWeight);
    map['target_weight'] = Variable<double>(targetWeight);
    map['height'] = Variable<double>(height);
    map['activity_level'] = Variable<String>(activityLevel);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      email: Value(email),
      gender: Value(gender),
      age: Value(age),
      currentWeight: Value(currentWeight),
      targetWeight: Value(targetWeight),
      height: Value(height),
      activityLevel: Value(activityLevel),
    );
  }

  factory UserProfile.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String>(json['email']),
      gender: serializer.fromJson<String>(json['gender']),
      age: serializer.fromJson<int>(json['age']),
      currentWeight: serializer.fromJson<double>(json['currentWeight']),
      targetWeight: serializer.fromJson<double>(json['targetWeight']),
      height: serializer.fromJson<double>(json['height']),
      activityLevel: serializer.fromJson<String>(json['activityLevel']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String>(email),
      'gender': serializer.toJson<String>(gender),
      'age': serializer.toJson<int>(age),
      'currentWeight': serializer.toJson<double>(currentWeight),
      'targetWeight': serializer.toJson<double>(targetWeight),
      'height': serializer.toJson<double>(height),
      'activityLevel': serializer.toJson<String>(activityLevel),
    };
  }

  UserProfile copyWith(
          {int? id,
          String? name,
          String? email,
          String? gender,
          int? age,
          double? currentWeight,
          double? targetWeight,
          double? height,
          String? activityLevel}) =>
      UserProfile(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        gender: gender ?? this.gender,
        age: age ?? this.age,
        currentWeight: currentWeight ?? this.currentWeight,
        targetWeight: targetWeight ?? this.targetWeight,
        height: height ?? this.height,
        activityLevel: activityLevel ?? this.activityLevel,
      );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      gender: data.gender.present ? data.gender.value : this.gender,
      age: data.age.present ? data.age.value : this.age,
      currentWeight: data.currentWeight.present
          ? data.currentWeight.value
          : this.currentWeight,
      targetWeight: data.targetWeight.present
          ? data.targetWeight.value
          : this.targetWeight,
      height: data.height.present ? data.height.value : this.height,
      activityLevel: data.activityLevel.present
          ? data.activityLevel.value
          : this.activityLevel,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('currentWeight: $currentWeight, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('height: $height, ')
          ..write('activityLevel: $activityLevel')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, email, gender, age, currentWeight,
      targetWeight, height, activityLevel);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.gender == this.gender &&
          other.age == this.age &&
          other.currentWeight == this.currentWeight &&
          other.targetWeight == this.targetWeight &&
          other.height == this.height &&
          other.activityLevel == this.activityLevel);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> email;
  final Value<String> gender;
  final Value<int> age;
  final Value<double> currentWeight;
  final Value<double> targetWeight;
  final Value<double> height;
  final Value<String> activityLevel;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.gender = const Value.absent(),
    this.age = const Value.absent(),
    this.currentWeight = const Value.absent(),
    this.targetWeight = const Value.absent(),
    this.height = const Value.absent(),
    this.activityLevel = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String email,
    required String gender,
    this.age = const Value.absent(),
    required double currentWeight,
    required double targetWeight,
    required double height,
    this.activityLevel = const Value.absent(),
  })  : name = Value(name),
        email = Value(email),
        gender = Value(gender),
        currentWeight = Value(currentWeight),
        targetWeight = Value(targetWeight),
        height = Value(height);
  static Insertable<UserProfile> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? gender,
    Expression<int>? age,
    Expression<double>? currentWeight,
    Expression<double>? targetWeight,
    Expression<double>? height,
    Expression<String>? activityLevel,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (gender != null) 'gender': gender,
      if (age != null) 'age': age,
      if (currentWeight != null) 'current_weight': currentWeight,
      if (targetWeight != null) 'target_weight': targetWeight,
      if (height != null) 'height': height,
      if (activityLevel != null) 'activity_level': activityLevel,
    });
  }

  UserProfilesCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? email,
      Value<String>? gender,
      Value<int>? age,
      Value<double>? currentWeight,
      Value<double>? targetWeight,
      Value<double>? height,
      Value<String>? activityLevel}) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      age: age ?? this.age,
      currentWeight: currentWeight ?? this.currentWeight,
      targetWeight: targetWeight ?? this.targetWeight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (gender.present) {
      map['gender'] = Variable<String>(gender.value);
    }
    if (age.present) {
      map['age'] = Variable<int>(age.value);
    }
    if (currentWeight.present) {
      map['current_weight'] = Variable<double>(currentWeight.value);
    }
    if (targetWeight.present) {
      map['target_weight'] = Variable<double>(targetWeight.value);
    }
    if (height.present) {
      map['height'] = Variable<double>(height.value);
    }
    if (activityLevel.present) {
      map['activity_level'] = Variable<String>(activityLevel.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('gender: $gender, ')
          ..write('age: $age, ')
          ..write('currentWeight: $currentWeight, ')
          ..write('targetWeight: $targetWeight, ')
          ..write('height: $height, ')
          ..write('activityLevel: $activityLevel')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FoodEntriesTable foodEntries = $FoodEntriesTable(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [foodEntries, userProfiles];
}

typedef $$FoodEntriesTableCreateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  required String title,
  required int calories,
  Value<double?> protein,
  Value<double?> carbs,
  Value<double?> fat,
  required String category,
  required DateTime consumedAt,
});
typedef $$FoodEntriesTableUpdateCompanionBuilder = FoodEntriesCompanion
    Function({
  Value<int> id,
  Value<String> title,
  Value<int> calories,
  Value<double?> protein,
  Value<double?> carbs,
  Value<double?> fat,
  Value<String> category,
  Value<DateTime> consumedAt,
});

class $$FoodEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get protein => $composableBuilder(
      column: $table.protein, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get carbs => $composableBuilder(
      column: $table.carbs, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => ColumnFilters(column));
}

class $$FoodEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get calories => $composableBuilder(
      column: $table.calories, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get protein => $composableBuilder(
      column: $table.protein, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get carbs => $composableBuilder(
      column: $table.carbs, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get fat => $composableBuilder(
      column: $table.fat, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => ColumnOrderings(column));
}

class $$FoodEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $FoodEntriesTable> {
  $$FoodEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get calories =>
      $composableBuilder(column: $table.calories, builder: (column) => column);

  GeneratedColumn<double> get protein =>
      $composableBuilder(column: $table.protein, builder: (column) => column);

  GeneratedColumn<double> get carbs =>
      $composableBuilder(column: $table.carbs, builder: (column) => column);

  GeneratedColumn<double> get fat =>
      $composableBuilder(column: $table.fat, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<DateTime> get consumedAt => $composableBuilder(
      column: $table.consumedAt, builder: (column) => column);
}

class $$FoodEntriesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>),
    FoodEntry,
    PrefetchHooks Function()> {
  $$FoodEntriesTableTableManager(_$AppDatabase db, $FoodEntriesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FoodEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FoodEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FoodEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<int> calories = const Value.absent(),
            Value<double?> protein = const Value.absent(),
            Value<double?> carbs = const Value.absent(),
            Value<double?> fat = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<DateTime> consumedAt = const Value.absent(),
          }) =>
              FoodEntriesCompanion(
            id: id,
            title: title,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            category: category,
            consumedAt: consumedAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String title,
            required int calories,
            Value<double?> protein = const Value.absent(),
            Value<double?> carbs = const Value.absent(),
            Value<double?> fat = const Value.absent(),
            required String category,
            required DateTime consumedAt,
          }) =>
              FoodEntriesCompanion.insert(
            id: id,
            title: title,
            calories: calories,
            protein: protein,
            carbs: carbs,
            fat: fat,
            category: category,
            consumedAt: consumedAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$FoodEntriesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $FoodEntriesTable,
    FoodEntry,
    $$FoodEntriesTableFilterComposer,
    $$FoodEntriesTableOrderingComposer,
    $$FoodEntriesTableAnnotationComposer,
    $$FoodEntriesTableCreateCompanionBuilder,
    $$FoodEntriesTableUpdateCompanionBuilder,
    (FoodEntry, BaseReferences<_$AppDatabase, $FoodEntriesTable, FoodEntry>),
    FoodEntry,
    PrefetchHooks Function()>;
typedef $$UserProfilesTableCreateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  required String name,
  required String email,
  required String gender,
  Value<int> age,
  required double currentWeight,
  required double targetWeight,
  required double height,
  Value<String> activityLevel,
});
typedef $$UserProfilesTableUpdateCompanionBuilder = UserProfilesCompanion
    Function({
  Value<int> id,
  Value<String> name,
  Value<String> email,
  Value<String> gender,
  Value<int> age,
  Value<double> currentWeight,
  Value<double> targetWeight,
  Value<double> height,
  Value<String> activityLevel,
});

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get currentWeight => $composableBuilder(
      column: $table.currentWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight, builder: (column) => ColumnFilters(column));

  ColumnFilters<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel, builder: (column) => ColumnFilters(column));
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get gender => $composableBuilder(
      column: $table.gender, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get age => $composableBuilder(
      column: $table.age, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get currentWeight => $composableBuilder(
      column: $table.currentWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<double> get height => $composableBuilder(
      column: $table.height, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel,
      builder: (column) => ColumnOrderings(column));
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get gender =>
      $composableBuilder(column: $table.gender, builder: (column) => column);

  GeneratedColumn<int> get age =>
      $composableBuilder(column: $table.age, builder: (column) => column);

  GeneratedColumn<double> get currentWeight => $composableBuilder(
      column: $table.currentWeight, builder: (column) => column);

  GeneratedColumn<double> get targetWeight => $composableBuilder(
      column: $table.targetWeight, builder: (column) => column);

  GeneratedColumn<double> get height =>
      $composableBuilder(column: $table.height, builder: (column) => column);

  GeneratedColumn<String> get activityLevel => $composableBuilder(
      column: $table.activityLevel, builder: (column) => column);
}

class $$UserProfilesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()> {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String> gender = const Value.absent(),
            Value<int> age = const Value.absent(),
            Value<double> currentWeight = const Value.absent(),
            Value<double> targetWeight = const Value.absent(),
            Value<double> height = const Value.absent(),
            Value<String> activityLevel = const Value.absent(),
          }) =>
              UserProfilesCompanion(
            id: id,
            name: name,
            email: email,
            gender: gender,
            age: age,
            currentWeight: currentWeight,
            targetWeight: targetWeight,
            height: height,
            activityLevel: activityLevel,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String name,
            required String email,
            required String gender,
            Value<int> age = const Value.absent(),
            required double currentWeight,
            required double targetWeight,
            required double height,
            Value<String> activityLevel = const Value.absent(),
          }) =>
              UserProfilesCompanion.insert(
            id: id,
            name: name,
            email: email,
            gender: gender,
            age: age,
            currentWeight: currentWeight,
            targetWeight: targetWeight,
            height: height,
            activityLevel: activityLevel,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$UserProfilesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UserProfilesTable,
    UserProfile,
    $$UserProfilesTableFilterComposer,
    $$UserProfilesTableOrderingComposer,
    $$UserProfilesTableAnnotationComposer,
    $$UserProfilesTableCreateCompanionBuilder,
    $$UserProfilesTableUpdateCompanionBuilder,
    (
      UserProfile,
      BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>
    ),
    UserProfile,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FoodEntriesTableTableManager get foodEntries =>
      $$FoodEntriesTableTableManager(_db, _db.foodEntries);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
}
