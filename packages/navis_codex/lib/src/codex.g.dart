// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codex.dart';

// ignore_for_file: type=lint
class $CodexBuildsTable extends CodexBuilds
    with TableInfo<$CodexBuildsTable, CodexBuild> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CodexBuildsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _buildLabelMeta = const VerificationMeta(
    'buildLabel',
  );
  @override
  late final GeneratedColumn<String> buildLabel = GeneratedColumn<String>(
    'build_label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _timestampMeta = const VerificationMeta(
    'timestamp',
  );
  @override
  late final GeneratedColumn<DateTime> timestamp = GeneratedColumn<DateTime>(
    'timestamp',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, buildLabel, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'codex_builds';
  @override
  VerificationContext validateIntegrity(
    Insertable<CodexBuild> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('build_label')) {
      context.handle(
        _buildLabelMeta,
        buildLabel.isAcceptableOrUnknown(data['build_label']!, _buildLabelMeta),
      );
    } else if (isInserting) {
      context.missing(_buildLabelMeta);
    }
    if (data.containsKey('timestamp')) {
      context.handle(
        _timestampMeta,
        timestamp.isAcceptableOrUnknown(data['timestamp']!, _timestampMeta),
      );
    } else if (isInserting) {
      context.missing(_timestampMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CodexBuild map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CodexBuild(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      buildLabel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}build_label'],
      )!,
      timestamp: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}timestamp'],
      )!,
    );
  }

  @override
  $CodexBuildsTable createAlias(String alias) {
    return $CodexBuildsTable(attachedDatabase, alias);
  }
}

class CodexBuild extends DataClass implements Insertable<CodexBuild> {
  final int id;
  final String buildLabel;
  final DateTime timestamp;
  const CodexBuild({
    required this.id,
    required this.buildLabel,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['build_label'] = Variable<String>(buildLabel);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  CodexBuildsCompanion toCompanion(bool nullToAbsent) {
    return CodexBuildsCompanion(
      id: Value(id),
      buildLabel: Value(buildLabel),
      timestamp: Value(timestamp),
    );
  }

  factory CodexBuild.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CodexBuild(
      id: serializer.fromJson<int>(json['id']),
      buildLabel: serializer.fromJson<String>(json['buildLabel']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'buildLabel': serializer.toJson<String>(buildLabel),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  CodexBuild copyWith({int? id, String? buildLabel, DateTime? timestamp}) =>
      CodexBuild(
        id: id ?? this.id,
        buildLabel: buildLabel ?? this.buildLabel,
        timestamp: timestamp ?? this.timestamp,
      );
  CodexBuild copyWithCompanion(CodexBuildsCompanion data) {
    return CodexBuild(
      id: data.id.present ? data.id.value : this.id,
      buildLabel: data.buildLabel.present
          ? data.buildLabel.value
          : this.buildLabel,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CodexBuild(')
          ..write('id: $id, ')
          ..write('buildLabel: $buildLabel, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, buildLabel, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CodexBuild &&
          other.id == this.id &&
          other.buildLabel == this.buildLabel &&
          other.timestamp == this.timestamp);
}

class CodexBuildsCompanion extends UpdateCompanion<CodexBuild> {
  final Value<int> id;
  final Value<String> buildLabel;
  final Value<DateTime> timestamp;
  const CodexBuildsCompanion({
    this.id = const Value.absent(),
    this.buildLabel = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  CodexBuildsCompanion.insert({
    this.id = const Value.absent(),
    required String buildLabel,
    required DateTime timestamp,
  }) : buildLabel = Value(buildLabel),
       timestamp = Value(timestamp);
  static Insertable<CodexBuild> custom({
    Expression<int>? id,
    Expression<String>? buildLabel,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (buildLabel != null) 'build_label': buildLabel,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  CodexBuildsCompanion copyWith({
    Value<int>? id,
    Value<String>? buildLabel,
    Value<DateTime>? timestamp,
  }) {
    return CodexBuildsCompanion(
      id: id ?? this.id,
      buildLabel: buildLabel ?? this.buildLabel,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (buildLabel.present) {
      map['build_label'] = Variable<String>(buildLabel.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CodexBuildsCompanion(')
          ..write('id: $id, ')
          ..write('buildLabel: $buildLabel, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

class $CodexItemsTable extends CodexItems
    with TableInfo<$CodexItemsTable, CodexItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CodexItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uniqueNameMeta = const VerificationMeta(
    'uniqueName',
  );
  @override
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
    'unique_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _imageNameMeta = const VerificationMeta(
    'imageName',
  );
  @override
  late final GeneratedColumn<String> imageName = GeneratedColumn<String>(
    'image_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isVaultedMeta = const VerificationMeta(
    'isVaulted',
  );
  @override
  late final GeneratedColumn<bool> isVaulted = GeneratedColumn<bool>(
    'is_vaulted',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_vaulted" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isMasterableMeta = const VerificationMeta(
    'isMasterable',
  );
  @override
  late final GeneratedColumn<bool> isMasterable = GeneratedColumn<bool>(
    'is_masterable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_masterable" IN (0, 1))',
    ),
  );
  static const VerificationMeta _maxLevelMeta = const VerificationMeta(
    'maxLevel',
  );
  @override
  late final GeneratedColumn<int> maxLevel = GeneratedColumn<int>(
    'max_level',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wikiaUrlMeta = const VerificationMeta(
    'wikiaUrl',
  );
  @override
  late final GeneratedColumn<String> wikiaUrl = GeneratedColumn<String>(
    'wikia_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _wikiaThumbnailMeta = const VerificationMeta(
    'wikiaThumbnail',
  );
  @override
  late final GeneratedColumn<String> wikiaThumbnail = GeneratedColumn<String>(
    'wikia_thumbnail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<wfcd.ItemType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<wfcd.ItemType>($CodexItemsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [
    uniqueName,
    name,
    description,
    imageName,
    category,
    isVaulted,
    isMasterable,
    maxLevel,
    wikiaUrl,
    wikiaThumbnail,
    type,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'codex_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CodexItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unique_name')) {
      context.handle(
        _uniqueNameMeta,
        uniqueName.isAcceptableOrUnknown(data['unique_name']!, _uniqueNameMeta),
      );
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('image_name')) {
      context.handle(
        _imageNameMeta,
        imageName.isAcceptableOrUnknown(data['image_name']!, _imageNameMeta),
      );
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('is_vaulted')) {
      context.handle(
        _isVaultedMeta,
        isVaulted.isAcceptableOrUnknown(data['is_vaulted']!, _isVaultedMeta),
      );
    } else if (isInserting) {
      context.missing(_isVaultedMeta);
    }
    if (data.containsKey('is_masterable')) {
      context.handle(
        _isMasterableMeta,
        isMasterable.isAcceptableOrUnknown(
          data['is_masterable']!,
          _isMasterableMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isMasterableMeta);
    }
    if (data.containsKey('max_level')) {
      context.handle(
        _maxLevelMeta,
        maxLevel.isAcceptableOrUnknown(data['max_level']!, _maxLevelMeta),
      );
    }
    if (data.containsKey('wikia_url')) {
      context.handle(
        _wikiaUrlMeta,
        wikiaUrl.isAcceptableOrUnknown(data['wikia_url']!, _wikiaUrlMeta),
      );
    }
    if (data.containsKey('wikia_thumbnail')) {
      context.handle(
        _wikiaThumbnailMeta,
        wikiaThumbnail.isAcceptableOrUnknown(
          data['wikia_thumbnail']!,
          _wikiaThumbnailMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uniqueName};
  @override
  CodexItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CodexItem(
      uniqueName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unique_name'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      imageName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image_name'],
      ),
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      isVaulted: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_vaulted'],
      )!,
      isMasterable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_masterable'],
      )!,
      maxLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_level'],
      ),
      wikiaUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wikia_url'],
      ),
      wikiaThumbnail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}wikia_thumbnail'],
      ),
      type: $CodexItemsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $CodexItemsTable createAlias(String alias) {
    return $CodexItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<wfcd.ItemType, String, String> $convertertype =
      const EnumNameConverter<wfcd.ItemType>(wfcd.ItemType.values);
}

class CodexItem extends DataClass implements Insertable<CodexItem> {
  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
  final String category;
  final bool isVaulted;
  final bool isMasterable;
  final int? maxLevel;
  final String? wikiaUrl;
  final String? wikiaThumbnail;
  final wfcd.ItemType type;
  const CodexItem({
    required this.uniqueName,
    required this.name,
    this.description,
    this.imageName,
    required this.category,
    required this.isVaulted,
    required this.isMasterable,
    this.maxLevel,
    this.wikiaUrl,
    this.wikiaThumbnail,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unique_name'] = Variable<String>(uniqueName);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || imageName != null) {
      map['image_name'] = Variable<String>(imageName);
    }
    map['category'] = Variable<String>(category);
    map['is_vaulted'] = Variable<bool>(isVaulted);
    map['is_masterable'] = Variable<bool>(isMasterable);
    if (!nullToAbsent || maxLevel != null) {
      map['max_level'] = Variable<int>(maxLevel);
    }
    if (!nullToAbsent || wikiaUrl != null) {
      map['wikia_url'] = Variable<String>(wikiaUrl);
    }
    if (!nullToAbsent || wikiaThumbnail != null) {
      map['wikia_thumbnail'] = Variable<String>(wikiaThumbnail);
    }
    {
      map['type'] = Variable<String>(
        $CodexItemsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  CodexItemsCompanion toCompanion(bool nullToAbsent) {
    return CodexItemsCompanion(
      uniqueName: Value(uniqueName),
      name: Value(name),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      imageName: imageName == null && nullToAbsent
          ? const Value.absent()
          : Value(imageName),
      category: Value(category),
      isVaulted: Value(isVaulted),
      isMasterable: Value(isMasterable),
      maxLevel: maxLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(maxLevel),
      wikiaUrl: wikiaUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(wikiaUrl),
      wikiaThumbnail: wikiaThumbnail == null && nullToAbsent
          ? const Value.absent()
          : Value(wikiaThumbnail),
      type: Value(type),
    );
  }

  factory CodexItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CodexItem(
      uniqueName: serializer.fromJson<String>(json['uniqueName']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      imageName: serializer.fromJson<String?>(json['imageName']),
      category: serializer.fromJson<String>(json['category']),
      isVaulted: serializer.fromJson<bool>(json['isVaulted']),
      isMasterable: serializer.fromJson<bool>(json['isMasterable']),
      maxLevel: serializer.fromJson<int?>(json['maxLevel']),
      wikiaUrl: serializer.fromJson<String?>(json['wikiaUrl']),
      wikiaThumbnail: serializer.fromJson<String?>(json['wikiaThumbnail']),
      type: $CodexItemsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uniqueName': serializer.toJson<String>(uniqueName),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'imageName': serializer.toJson<String?>(imageName),
      'category': serializer.toJson<String>(category),
      'isVaulted': serializer.toJson<bool>(isVaulted),
      'isMasterable': serializer.toJson<bool>(isMasterable),
      'maxLevel': serializer.toJson<int?>(maxLevel),
      'wikiaUrl': serializer.toJson<String?>(wikiaUrl),
      'wikiaThumbnail': serializer.toJson<String?>(wikiaThumbnail),
      'type': serializer.toJson<String>(
        $CodexItemsTable.$convertertype.toJson(type),
      ),
    };
  }

  CodexItem copyWith({
    String? uniqueName,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> imageName = const Value.absent(),
    String? category,
    bool? isVaulted,
    bool? isMasterable,
    Value<int?> maxLevel = const Value.absent(),
    Value<String?> wikiaUrl = const Value.absent(),
    Value<String?> wikiaThumbnail = const Value.absent(),
    wfcd.ItemType? type,
  }) => CodexItem(
    uniqueName: uniqueName ?? this.uniqueName,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    imageName: imageName.present ? imageName.value : this.imageName,
    category: category ?? this.category,
    isVaulted: isVaulted ?? this.isVaulted,
    isMasterable: isMasterable ?? this.isMasterable,
    maxLevel: maxLevel.present ? maxLevel.value : this.maxLevel,
    wikiaUrl: wikiaUrl.present ? wikiaUrl.value : this.wikiaUrl,
    wikiaThumbnail: wikiaThumbnail.present
        ? wikiaThumbnail.value
        : this.wikiaThumbnail,
    type: type ?? this.type,
  );
  CodexItem copyWithCompanion(CodexItemsCompanion data) {
    return CodexItem(
      uniqueName: data.uniqueName.present
          ? data.uniqueName.value
          : this.uniqueName,
      name: data.name.present ? data.name.value : this.name,
      description: data.description.present
          ? data.description.value
          : this.description,
      imageName: data.imageName.present ? data.imageName.value : this.imageName,
      category: data.category.present ? data.category.value : this.category,
      isVaulted: data.isVaulted.present ? data.isVaulted.value : this.isVaulted,
      isMasterable: data.isMasterable.present
          ? data.isMasterable.value
          : this.isMasterable,
      maxLevel: data.maxLevel.present ? data.maxLevel.value : this.maxLevel,
      wikiaUrl: data.wikiaUrl.present ? data.wikiaUrl.value : this.wikiaUrl,
      wikiaThumbnail: data.wikiaThumbnail.present
          ? data.wikiaThumbnail.value
          : this.wikiaThumbnail,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CodexItem(')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageName: $imageName, ')
          ..write('category: $category, ')
          ..write('isVaulted: $isVaulted, ')
          ..write('isMasterable: $isMasterable, ')
          ..write('maxLevel: $maxLevel, ')
          ..write('wikiaUrl: $wikiaUrl, ')
          ..write('wikiaThumbnail: $wikiaThumbnail, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uniqueName,
    name,
    description,
    imageName,
    category,
    isVaulted,
    isMasterable,
    maxLevel,
    wikiaUrl,
    wikiaThumbnail,
    type,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CodexItem &&
          other.uniqueName == this.uniqueName &&
          other.name == this.name &&
          other.description == this.description &&
          other.imageName == this.imageName &&
          other.category == this.category &&
          other.isVaulted == this.isVaulted &&
          other.isMasterable == this.isMasterable &&
          other.maxLevel == this.maxLevel &&
          other.wikiaUrl == this.wikiaUrl &&
          other.wikiaThumbnail == this.wikiaThumbnail &&
          other.type == this.type);
}

class CodexItemsCompanion extends UpdateCompanion<CodexItem> {
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imageName;
  final Value<String> category;
  final Value<bool> isVaulted;
  final Value<bool> isMasterable;
  final Value<int?> maxLevel;
  final Value<String?> wikiaUrl;
  final Value<String?> wikiaThumbnail;
  final Value<wfcd.ItemType> type;
  final Value<int> rowid;
  const CodexItemsCompanion({
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageName = const Value.absent(),
    this.category = const Value.absent(),
    this.isVaulted = const Value.absent(),
    this.isMasterable = const Value.absent(),
    this.maxLevel = const Value.absent(),
    this.wikiaUrl = const Value.absent(),
    this.wikiaThumbnail = const Value.absent(),
    this.type = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CodexItemsCompanion.insert({
    required String uniqueName,
    required String name,
    this.description = const Value.absent(),
    this.imageName = const Value.absent(),
    required String category,
    required bool isVaulted,
    required bool isMasterable,
    this.maxLevel = const Value.absent(),
    this.wikiaUrl = const Value.absent(),
    this.wikiaThumbnail = const Value.absent(),
    required wfcd.ItemType type,
    this.rowid = const Value.absent(),
  }) : uniqueName = Value(uniqueName),
       name = Value(name),
       category = Value(category),
       isVaulted = Value(isVaulted),
       isMasterable = Value(isMasterable),
       type = Value(type);
  static Insertable<CodexItem> custom({
    Expression<String>? uniqueName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageName,
    Expression<String>? category,
    Expression<bool>? isVaulted,
    Expression<bool>? isMasterable,
    Expression<int>? maxLevel,
    Expression<String>? wikiaUrl,
    Expression<String>? wikiaThumbnail,
    Expression<String>? type,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uniqueName != null) 'unique_name': uniqueName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageName != null) 'image_name': imageName,
      if (category != null) 'category': category,
      if (isVaulted != null) 'is_vaulted': isVaulted,
      if (isMasterable != null) 'is_masterable': isMasterable,
      if (maxLevel != null) 'max_level': maxLevel,
      if (wikiaUrl != null) 'wikia_url': wikiaUrl,
      if (wikiaThumbnail != null) 'wikia_thumbnail': wikiaThumbnail,
      if (type != null) 'type': type,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CodexItemsCompanion copyWith({
    Value<String>? uniqueName,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? imageName,
    Value<String>? category,
    Value<bool>? isVaulted,
    Value<bool>? isMasterable,
    Value<int?>? maxLevel,
    Value<String?>? wikiaUrl,
    Value<String?>? wikiaThumbnail,
    Value<wfcd.ItemType>? type,
    Value<int>? rowid,
  }) {
    return CodexItemsCompanion(
      uniqueName: uniqueName ?? this.uniqueName,
      name: name ?? this.name,
      description: description ?? this.description,
      imageName: imageName ?? this.imageName,
      category: category ?? this.category,
      isVaulted: isVaulted ?? this.isVaulted,
      isMasterable: isMasterable ?? this.isMasterable,
      maxLevel: maxLevel ?? this.maxLevel,
      wikiaUrl: wikiaUrl ?? this.wikiaUrl,
      wikiaThumbnail: wikiaThumbnail ?? this.wikiaThumbnail,
      type: type ?? this.type,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uniqueName.present) {
      map['unique_name'] = Variable<String>(uniqueName.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (imageName.present) {
      map['image_name'] = Variable<String>(imageName.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (isVaulted.present) {
      map['is_vaulted'] = Variable<bool>(isVaulted.value);
    }
    if (isMasterable.present) {
      map['is_masterable'] = Variable<bool>(isMasterable.value);
    }
    if (maxLevel.present) {
      map['max_level'] = Variable<int>(maxLevel.value);
    }
    if (wikiaUrl.present) {
      map['wikia_url'] = Variable<String>(wikiaUrl.value);
    }
    if (wikiaThumbnail.present) {
      map['wikia_thumbnail'] = Variable<String>(wikiaThumbnail.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $CodexItemsTable.$convertertype.toSql(type.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CodexItemsCompanion(')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageName: $imageName, ')
          ..write('category: $category, ')
          ..write('isVaulted: $isVaulted, ')
          ..write('isMasterable: $isMasterable, ')
          ..write('maxLevel: $maxLevel, ')
          ..write('wikiaUrl: $wikiaUrl, ')
          ..write('wikiaThumbnail: $wikiaThumbnail, ')
          ..write('type: $type, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $XpItemsTable extends XpItems with TableInfo<$XpItemsTable, XpItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $XpItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uniqueNameMeta = const VerificationMeta(
    'uniqueName',
  );
  @override
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
    'unique_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [uniqueName, xp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'xp_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<XpItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unique_name')) {
      context.handle(
        _uniqueNameMeta,
        uniqueName.isAcceptableOrUnknown(data['unique_name']!, _uniqueNameMeta),
      );
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    } else if (isInserting) {
      context.missing(_xpMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uniqueName};
  @override
  XpItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return XpItem(
      uniqueName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unique_name'],
      )!,
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      )!,
    );
  }

  @override
  $XpItemsTable createAlias(String alias) {
    return $XpItemsTable(attachedDatabase, alias);
  }
}

class XpItem extends DataClass implements Insertable<XpItem> {
  final String uniqueName;
  final int xp;
  const XpItem({required this.uniqueName, required this.xp});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unique_name'] = Variable<String>(uniqueName);
    map['xp'] = Variable<int>(xp);
    return map;
  }

  XpItemsCompanion toCompanion(bool nullToAbsent) {
    return XpItemsCompanion(uniqueName: Value(uniqueName), xp: Value(xp));
  }

  factory XpItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return XpItem(
      uniqueName: serializer.fromJson<String>(json['uniqueName']),
      xp: serializer.fromJson<int>(json['xp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uniqueName': serializer.toJson<String>(uniqueName),
      'xp': serializer.toJson<int>(xp),
    };
  }

  XpItem copyWith({String? uniqueName, int? xp}) =>
      XpItem(uniqueName: uniqueName ?? this.uniqueName, xp: xp ?? this.xp);
  XpItem copyWithCompanion(XpItemsCompanion data) {
    return XpItem(
      uniqueName: data.uniqueName.present
          ? data.uniqueName.value
          : this.uniqueName,
      xp: data.xp.present ? data.xp.value : this.xp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('XpItem(')
          ..write('uniqueName: $uniqueName, ')
          ..write('xp: $xp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(uniqueName, xp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is XpItem &&
          other.uniqueName == this.uniqueName &&
          other.xp == this.xp);
}

class XpItemsCompanion extends UpdateCompanion<XpItem> {
  final Value<String> uniqueName;
  final Value<int> xp;
  final Value<int> rowid;
  const XpItemsCompanion({
    this.uniqueName = const Value.absent(),
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  XpItemsCompanion.insert({
    required String uniqueName,
    required int xp,
    this.rowid = const Value.absent(),
  }) : uniqueName = Value(uniqueName),
       xp = Value(xp);
  static Insertable<XpItem> custom({
    Expression<String>? uniqueName,
    Expression<int>? xp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uniqueName != null) 'unique_name': uniqueName,
      if (xp != null) 'xp': xp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  XpItemsCompanion copyWith({
    Value<String>? uniqueName,
    Value<int>? xp,
    Value<int>? rowid,
  }) {
    return XpItemsCompanion(
      uniqueName: uniqueName ?? this.uniqueName,
      xp: xp ?? this.xp,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (uniqueName.present) {
      map['unique_name'] = Variable<String>(uniqueName.value);
    }
    if (xp.present) {
      map['xp'] = Variable<int>(xp.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('XpItemsCompanion(')
          ..write('uniqueName: $uniqueName, ')
          ..write('xp: $xp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CodexDatabase extends GeneratedDatabase {
  _$CodexDatabase(QueryExecutor e) : super(e);
  $CodexDatabaseManager get managers => $CodexDatabaseManager(this);
  late final $CodexBuildsTable codexBuilds = $CodexBuildsTable(this);
  late final $CodexItemsTable codexItems = $CodexItemsTable(this);
  late final $XpItemsTable xpItems = $XpItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    codexBuilds,
    codexItems,
    xpItems,
  ];
}

typedef $$CodexBuildsTableCreateCompanionBuilder =
    CodexBuildsCompanion Function({
      Value<int> id,
      required String buildLabel,
      required DateTime timestamp,
    });
typedef $$CodexBuildsTableUpdateCompanionBuilder =
    CodexBuildsCompanion Function({
      Value<int> id,
      Value<String> buildLabel,
      Value<DateTime> timestamp,
    });

class $$CodexBuildsTableFilterComposer
    extends Composer<_$CodexDatabase, $CodexBuildsTable> {
  $$CodexBuildsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get buildLabel => $composableBuilder(
    column: $table.buildLabel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CodexBuildsTableOrderingComposer
    extends Composer<_$CodexDatabase, $CodexBuildsTable> {
  $$CodexBuildsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get buildLabel => $composableBuilder(
    column: $table.buildLabel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CodexBuildsTableAnnotationComposer
    extends Composer<_$CodexDatabase, $CodexBuildsTable> {
  $$CodexBuildsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get buildLabel => $composableBuilder(
    column: $table.buildLabel,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$CodexBuildsTableTableManager
    extends
        RootTableManager<
          _$CodexDatabase,
          $CodexBuildsTable,
          CodexBuild,
          $$CodexBuildsTableFilterComposer,
          $$CodexBuildsTableOrderingComposer,
          $$CodexBuildsTableAnnotationComposer,
          $$CodexBuildsTableCreateCompanionBuilder,
          $$CodexBuildsTableUpdateCompanionBuilder,
          (
            CodexBuild,
            BaseReferences<_$CodexDatabase, $CodexBuildsTable, CodexBuild>,
          ),
          CodexBuild,
          PrefetchHooks Function()
        > {
  $$CodexBuildsTableTableManager(_$CodexDatabase db, $CodexBuildsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CodexBuildsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CodexBuildsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CodexBuildsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> buildLabel = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => CodexBuildsCompanion(
                id: id,
                buildLabel: buildLabel,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String buildLabel,
                required DateTime timestamp,
              }) => CodexBuildsCompanion.insert(
                id: id,
                buildLabel: buildLabel,
                timestamp: timestamp,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CodexBuildsTableProcessedTableManager =
    ProcessedTableManager<
      _$CodexDatabase,
      $CodexBuildsTable,
      CodexBuild,
      $$CodexBuildsTableFilterComposer,
      $$CodexBuildsTableOrderingComposer,
      $$CodexBuildsTableAnnotationComposer,
      $$CodexBuildsTableCreateCompanionBuilder,
      $$CodexBuildsTableUpdateCompanionBuilder,
      (
        CodexBuild,
        BaseReferences<_$CodexDatabase, $CodexBuildsTable, CodexBuild>,
      ),
      CodexBuild,
      PrefetchHooks Function()
    >;
typedef $$CodexItemsTableCreateCompanionBuilder =
    CodexItemsCompanion Function({
      required String uniqueName,
      required String name,
      Value<String?> description,
      Value<String?> imageName,
      required String category,
      required bool isVaulted,
      required bool isMasterable,
      Value<int?> maxLevel,
      Value<String?> wikiaUrl,
      Value<String?> wikiaThumbnail,
      required wfcd.ItemType type,
      Value<int> rowid,
    });
typedef $$CodexItemsTableUpdateCompanionBuilder =
    CodexItemsCompanion Function({
      Value<String> uniqueName,
      Value<String> name,
      Value<String?> description,
      Value<String?> imageName,
      Value<String> category,
      Value<bool> isVaulted,
      Value<bool> isMasterable,
      Value<int?> maxLevel,
      Value<String?> wikiaUrl,
      Value<String?> wikiaThumbnail,
      Value<wfcd.ItemType> type,
      Value<int> rowid,
    });

class $$CodexItemsTableFilterComposer
    extends Composer<_$CodexDatabase, $CodexItemsTable> {
  $$CodexItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isVaulted => $composableBuilder(
    column: $table.isVaulted,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMasterable => $composableBuilder(
    column: $table.isMasterable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxLevel => $composableBuilder(
    column: $table.maxLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wikiaUrl => $composableBuilder(
    column: $table.wikiaUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wikiaThumbnail => $composableBuilder(
    column: $table.wikiaThumbnail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<wfcd.ItemType, wfcd.ItemType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$CodexItemsTableOrderingComposer
    extends Composer<_$CodexDatabase, $CodexItemsTable> {
  $$CodexItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imageName => $composableBuilder(
    column: $table.imageName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isVaulted => $composableBuilder(
    column: $table.isVaulted,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMasterable => $composableBuilder(
    column: $table.isMasterable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxLevel => $composableBuilder(
    column: $table.maxLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wikiaUrl => $composableBuilder(
    column: $table.wikiaUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wikiaThumbnail => $composableBuilder(
    column: $table.wikiaThumbnail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CodexItemsTableAnnotationComposer
    extends Composer<_$CodexDatabase, $CodexItemsTable> {
  $$CodexItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imageName =>
      $composableBuilder(column: $table.imageName, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get isVaulted =>
      $composableBuilder(column: $table.isVaulted, builder: (column) => column);

  GeneratedColumn<bool> get isMasterable => $composableBuilder(
    column: $table.isMasterable,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxLevel =>
      $composableBuilder(column: $table.maxLevel, builder: (column) => column);

  GeneratedColumn<String> get wikiaUrl =>
      $composableBuilder(column: $table.wikiaUrl, builder: (column) => column);

  GeneratedColumn<String> get wikiaThumbnail => $composableBuilder(
    column: $table.wikiaThumbnail,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<wfcd.ItemType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);
}

class $$CodexItemsTableTableManager
    extends
        RootTableManager<
          _$CodexDatabase,
          $CodexItemsTable,
          CodexItem,
          $$CodexItemsTableFilterComposer,
          $$CodexItemsTableOrderingComposer,
          $$CodexItemsTableAnnotationComposer,
          $$CodexItemsTableCreateCompanionBuilder,
          $$CodexItemsTableUpdateCompanionBuilder,
          (
            CodexItem,
            BaseReferences<_$CodexDatabase, $CodexItemsTable, CodexItem>,
          ),
          CodexItem,
          PrefetchHooks Function()
        > {
  $$CodexItemsTableTableManager(_$CodexDatabase db, $CodexItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CodexItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CodexItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CodexItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uniqueName = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> imageName = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<bool> isVaulted = const Value.absent(),
                Value<bool> isMasterable = const Value.absent(),
                Value<int?> maxLevel = const Value.absent(),
                Value<String?> wikiaUrl = const Value.absent(),
                Value<String?> wikiaThumbnail = const Value.absent(),
                Value<wfcd.ItemType> type = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CodexItemsCompanion(
                uniqueName: uniqueName,
                name: name,
                description: description,
                imageName: imageName,
                category: category,
                isVaulted: isVaulted,
                isMasterable: isMasterable,
                maxLevel: maxLevel,
                wikiaUrl: wikiaUrl,
                wikiaThumbnail: wikiaThumbnail,
                type: type,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uniqueName,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> imageName = const Value.absent(),
                required String category,
                required bool isVaulted,
                required bool isMasterable,
                Value<int?> maxLevel = const Value.absent(),
                Value<String?> wikiaUrl = const Value.absent(),
                Value<String?> wikiaThumbnail = const Value.absent(),
                required wfcd.ItemType type,
                Value<int> rowid = const Value.absent(),
              }) => CodexItemsCompanion.insert(
                uniqueName: uniqueName,
                name: name,
                description: description,
                imageName: imageName,
                category: category,
                isVaulted: isVaulted,
                isMasterable: isMasterable,
                maxLevel: maxLevel,
                wikiaUrl: wikiaUrl,
                wikiaThumbnail: wikiaThumbnail,
                type: type,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CodexItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$CodexDatabase,
      $CodexItemsTable,
      CodexItem,
      $$CodexItemsTableFilterComposer,
      $$CodexItemsTableOrderingComposer,
      $$CodexItemsTableAnnotationComposer,
      $$CodexItemsTableCreateCompanionBuilder,
      $$CodexItemsTableUpdateCompanionBuilder,
      (CodexItem, BaseReferences<_$CodexDatabase, $CodexItemsTable, CodexItem>),
      CodexItem,
      PrefetchHooks Function()
    >;
typedef $$XpItemsTableCreateCompanionBuilder =
    XpItemsCompanion Function({
      required String uniqueName,
      required int xp,
      Value<int> rowid,
    });
typedef $$XpItemsTableUpdateCompanionBuilder =
    XpItemsCompanion Function({
      Value<String> uniqueName,
      Value<int> xp,
      Value<int> rowid,
    });

class $$XpItemsTableFilterComposer
    extends Composer<_$CodexDatabase, $XpItemsTable> {
  $$XpItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$XpItemsTableOrderingComposer
    extends Composer<_$CodexDatabase, $XpItemsTable> {
  $$XpItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$XpItemsTableAnnotationComposer
    extends Composer<_$CodexDatabase, $XpItemsTable> {
  $$XpItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uniqueName => $composableBuilder(
    column: $table.uniqueName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);
}

class $$XpItemsTableTableManager
    extends
        RootTableManager<
          _$CodexDatabase,
          $XpItemsTable,
          XpItem,
          $$XpItemsTableFilterComposer,
          $$XpItemsTableOrderingComposer,
          $$XpItemsTableAnnotationComposer,
          $$XpItemsTableCreateCompanionBuilder,
          $$XpItemsTableUpdateCompanionBuilder,
          (XpItem, BaseReferences<_$CodexDatabase, $XpItemsTable, XpItem>),
          XpItem,
          PrefetchHooks Function()
        > {
  $$XpItemsTableTableManager(_$CodexDatabase db, $XpItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$XpItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$XpItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$XpItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> uniqueName = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => XpItemsCompanion(
                uniqueName: uniqueName,
                xp: xp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uniqueName,
                required int xp,
                Value<int> rowid = const Value.absent(),
              }) => XpItemsCompanion.insert(
                uniqueName: uniqueName,
                xp: xp,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$XpItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$CodexDatabase,
      $XpItemsTable,
      XpItem,
      $$XpItemsTableFilterComposer,
      $$XpItemsTableOrderingComposer,
      $$XpItemsTableAnnotationComposer,
      $$XpItemsTableCreateCompanionBuilder,
      $$XpItemsTableUpdateCompanionBuilder,
      (XpItem, BaseReferences<_$CodexDatabase, $XpItemsTable, XpItem>),
      XpItem,
      PrefetchHooks Function()
    >;

class $CodexDatabaseManager {
  final _$CodexDatabase _db;
  $CodexDatabaseManager(this._db);
  $$CodexBuildsTableTableManager get codexBuilds =>
      $$CodexBuildsTableTableManager(_db, _db.codexBuilds);
  $$CodexItemsTableTableManager get codexItems =>
      $$CodexItemsTableTableManager(_db, _db.codexItems);
  $$XpItemsTableTableManager get xpItems =>
      $$XpItemsTableTableManager(_db, _db.xpItems);
}
