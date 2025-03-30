// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventoria.dart';

// ignore_for_file: type=lint
class $InventoryItemTable extends InventoryItem
    with TableInfo<$InventoryItemTable, InventoryItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoryItemTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _productCategoryMeta = const VerificationMeta(
    'productCategory',
  );
  @override
  late final GeneratedColumn<String> productCategory = GeneratedColumn<String>(
    'product_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
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
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isMissingMeta = const VerificationMeta(
    'isMissing',
  );
  @override
  late final GeneratedColumn<bool> isMissing = GeneratedColumn<bool>(
    'is_missing',
    aliasedName,
    false,
    generatedAs: GeneratedAs(xp.equals(0), false),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_missing" IN (0, 1))',
    ),
  );
  static const VerificationMeta _isHiddenMeta = const VerificationMeta(
    'isHidden',
  );
  @override
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    generatedAs: GeneratedAs(isMissing & name.isIn(hidden), false),
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_hidden" IN (0, 1))',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    uniqueName,
    name,
    description,
    image,
    productCategory,
    type,
    xp,
    isMissing,
    isHidden,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventory_item';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoryItemData> instance, {
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
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    }
    if (data.containsKey('product_category')) {
      context.handle(
        _productCategoryMeta,
        productCategory.isAcceptableOrUnknown(
          data['product_category']!,
          _productCategoryMeta,
        ),
      );
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('xp')) {
      context.handle(_xpMeta, xp.isAcceptableOrUnknown(data['xp']!, _xpMeta));
    }
    if (data.containsKey('is_missing')) {
      context.handle(
        _isMissingMeta,
        isMissing.isAcceptableOrUnknown(data['is_missing']!, _isMissingMeta),
      );
    }
    if (data.containsKey('is_hidden')) {
      context.handle(
        _isHiddenMeta,
        isHidden.isAcceptableOrUnknown(data['is_hidden']!, _isHiddenMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uniqueName};
  @override
  InventoryItemData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoryItemData(
      uniqueName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}unique_name'],
          )!,
      name:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}name'],
          )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      ),
      productCategory: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_category'],
      ),
      type:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}type'],
          )!,
      xp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}xp'],
          )!,
      isMissing:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_missing'],
          )!,
      isHidden:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_hidden'],
          )!,
    );
  }

  @override
  $InventoryItemTable createAlias(String alias) {
    return $InventoryItemTable(attachedDatabase, alias);
  }
}

class InventoryItemData extends DataClass
    implements Insertable<InventoryItemData> {
  /// Unique name provided by DE
  final String uniqueName;

  /// Item name
  final String name;

  /// Item description if possible
  final String? description;

  /// Image name
  final String? image;

  /// Item category according to DE
  final String? productCategory;

  /// Item type
  final String type;

  /// Affinity
  final int xp;

  /// If the item is missing based on stored xp
  final bool isMissing;

  /// If the item can be hidden from the user
  final bool isHidden;
  const InventoryItemData({
    required this.uniqueName,
    required this.name,
    this.description,
    this.image,
    this.productCategory,
    required this.type,
    required this.xp,
    required this.isMissing,
    required this.isHidden,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['unique_name'] = Variable<String>(uniqueName);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || image != null) {
      map['image'] = Variable<String>(image);
    }
    if (!nullToAbsent || productCategory != null) {
      map['product_category'] = Variable<String>(productCategory);
    }
    map['type'] = Variable<String>(type);
    map['xp'] = Variable<int>(xp);
    return map;
  }

  InventoryItemCompanion toCompanion(bool nullToAbsent) {
    return InventoryItemCompanion(
      uniqueName: Value(uniqueName),
      name: Value(name),
      description:
          description == null && nullToAbsent
              ? const Value.absent()
              : Value(description),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      productCategory:
          productCategory == null && nullToAbsent
              ? const Value.absent()
              : Value(productCategory),
      type: Value(type),
      xp: Value(xp),
    );
  }

  factory InventoryItemData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoryItemData(
      uniqueName: serializer.fromJson<String>(json['uniqueName']),
      name: serializer.fromJson<String>(json['name']),
      description: serializer.fromJson<String?>(json['description']),
      image: serializer.fromJson<String?>(json['image']),
      productCategory: serializer.fromJson<String?>(json['productCategory']),
      type: serializer.fromJson<String>(json['type']),
      xp: serializer.fromJson<int>(json['xp']),
      isMissing: serializer.fromJson<bool>(json['isMissing']),
      isHidden: serializer.fromJson<bool>(json['isHidden']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'uniqueName': serializer.toJson<String>(uniqueName),
      'name': serializer.toJson<String>(name),
      'description': serializer.toJson<String?>(description),
      'image': serializer.toJson<String?>(image),
      'productCategory': serializer.toJson<String?>(productCategory),
      'type': serializer.toJson<String>(type),
      'xp': serializer.toJson<int>(xp),
      'isMissing': serializer.toJson<bool>(isMissing),
      'isHidden': serializer.toJson<bool>(isHidden),
    };
  }

  InventoryItemData copyWith({
    String? uniqueName,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> productCategory = const Value.absent(),
    String? type,
    int? xp,
    bool? isMissing,
    bool? isHidden,
  }) => InventoryItemData(
    uniqueName: uniqueName ?? this.uniqueName,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    image: image.present ? image.value : this.image,
    productCategory:
        productCategory.present ? productCategory.value : this.productCategory,
    type: type ?? this.type,
    xp: xp ?? this.xp,
    isMissing: isMissing ?? this.isMissing,
    isHidden: isHidden ?? this.isHidden,
  );
  @override
  String toString() {
    return (StringBuffer('InventoryItemData(')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('productCategory: $productCategory, ')
          ..write('type: $type, ')
          ..write('xp: $xp, ')
          ..write('isMissing: $isMissing, ')
          ..write('isHidden: $isHidden')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    uniqueName,
    name,
    description,
    image,
    productCategory,
    type,
    xp,
    isMissing,
    isHidden,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoryItemData &&
          other.uniqueName == this.uniqueName &&
          other.name == this.name &&
          other.description == this.description &&
          other.image == this.image &&
          other.productCategory == this.productCategory &&
          other.type == this.type &&
          other.xp == this.xp &&
          other.isMissing == this.isMissing &&
          other.isHidden == this.isHidden);
}

class InventoryItemCompanion extends UpdateCompanion<InventoryItemData> {
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> image;
  final Value<String?> productCategory;
  final Value<String> type;
  final Value<int> xp;
  final Value<int> rowid;
  const InventoryItemCompanion({
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.productCategory = const Value.absent(),
    this.type = const Value.absent(),
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  InventoryItemCompanion.insert({
    required String uniqueName,
    required String name,
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.productCategory = const Value.absent(),
    required String type,
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : uniqueName = Value(uniqueName),
       name = Value(name),
       type = Value(type);
  static Insertable<InventoryItemData> custom({
    Expression<String>? uniqueName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? image,
    Expression<String>? productCategory,
    Expression<String>? type,
    Expression<int>? xp,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uniqueName != null) 'unique_name': uniqueName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (image != null) 'image': image,
      if (productCategory != null) 'product_category': productCategory,
      if (type != null) 'type': type,
      if (xp != null) 'xp': xp,
      if (rowid != null) 'rowid': rowid,
    });
  }

  InventoryItemCompanion copyWith({
    Value<String>? uniqueName,
    Value<String>? name,
    Value<String?>? description,
    Value<String?>? image,
    Value<String?>? productCategory,
    Value<String>? type,
    Value<int>? xp,
    Value<int>? rowid,
  }) {
    return InventoryItemCompanion(
      uniqueName: uniqueName ?? this.uniqueName,
      name: name ?? this.name,
      description: description ?? this.description,
      image: image ?? this.image,
      productCategory: productCategory ?? this.productCategory,
      type: type ?? this.type,
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
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (productCategory.present) {
      map['product_category'] = Variable<String>(productCategory.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
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
    return (StringBuffer('InventoryItemCompanion(')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('image: $image, ')
          ..write('productCategory: $productCategory, ')
          ..write('type: $type, ')
          ..write('xp: $xp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DriftProfileTable extends DriftProfile
    with TableInfo<$DriftProfileTable, DriftProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DriftProfileTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rankMeta = const VerificationMeta('rank');
  @override
  late final GeneratedColumn<int> rank = GeneratedColumn<int>(
    'rank',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, username, rank];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'drift_profile';
  @override
  VerificationContext validateIntegrity(
    Insertable<DriftProfileData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('rank')) {
      context.handle(
        _rankMeta,
        rank.isAcceptableOrUnknown(data['rank']!, _rankMeta),
      );
    } else if (isInserting) {
      context.missing(_rankMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DriftProfileData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DriftProfileData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}id'],
          )!,
      username:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}username'],
          )!,
      rank:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}rank'],
          )!,
    );
  }

  @override
  $DriftProfileTable createAlias(String alias) {
    return $DriftProfileTable(attachedDatabase, alias);
  }
}

class DriftProfileData extends DataClass
    implements Insertable<DriftProfileData> {
  /// ID provided by DE
  final String id;

  /// in-game username
  final String username;

  /// Player rank
  final int rank;
  const DriftProfileData({
    required this.id,
    required this.username,
    required this.rank,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['username'] = Variable<String>(username);
    map['rank'] = Variable<int>(rank);
    return map;
  }

  DriftProfileCompanion toCompanion(bool nullToAbsent) {
    return DriftProfileCompanion(
      id: Value(id),
      username: Value(username),
      rank: Value(rank),
    );
  }

  factory DriftProfileData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DriftProfileData(
      id: serializer.fromJson<String>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      rank: serializer.fromJson<int>(json['rank']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'username': serializer.toJson<String>(username),
      'rank': serializer.toJson<int>(rank),
    };
  }

  DriftProfileData copyWith({String? id, String? username, int? rank}) =>
      DriftProfileData(
        id: id ?? this.id,
        username: username ?? this.username,
        rank: rank ?? this.rank,
      );
  DriftProfileData copyWithCompanion(DriftProfileCompanion data) {
    return DriftProfileData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      rank: data.rank.present ? data.rank.value : this.rank,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DriftProfileData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('rank: $rank')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, username, rank);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DriftProfileData &&
          other.id == this.id &&
          other.username == this.username &&
          other.rank == this.rank);
}

class DriftProfileCompanion extends UpdateCompanion<DriftProfileData> {
  final Value<String> id;
  final Value<String> username;
  final Value<int> rank;
  final Value<int> rowid;
  const DriftProfileCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.rank = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DriftProfileCompanion.insert({
    required String id,
    required String username,
    required int rank,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       username = Value(username),
       rank = Value(rank);
  static Insertable<DriftProfileData> custom({
    Expression<String>? id,
    Expression<String>? username,
    Expression<int>? rank,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (rank != null) 'rank': rank,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DriftProfileCompanion copyWith({
    Value<String>? id,
    Value<String>? username,
    Value<int>? rank,
    Value<int>? rowid,
  }) {
    return DriftProfileCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      rank: rank ?? this.rank,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (rank.present) {
      map['rank'] = Variable<int>(rank.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DriftProfileCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('rank: $rank, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InventoriaManifestTable extends InventoriaManifest
    with TableInfo<$InventoriaManifestTable, InventoriaManifestData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InventoriaManifestTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hashMeta = const VerificationMeta('hash');
  @override
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
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
  List<GeneratedColumn> get $columns => [id, hash, timestamp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'inventoria_manifest';
  @override
  VerificationContext validateIntegrity(
    Insertable<InventoriaManifestData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('hash')) {
      context.handle(
        _hashMeta,
        hash.isAcceptableOrUnknown(data['hash']!, _hashMeta),
      );
    } else if (isInserting) {
      context.missing(_hashMeta);
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
  InventoriaManifestData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InventoriaManifestData(
      id:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}id'],
          )!,
      hash:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hash'],
          )!,
      timestamp:
          attachedDatabase.typeMapping.read(
            DriftSqlType.dateTime,
            data['${effectivePrefix}timestamp'],
          )!,
    );
  }

  @override
  $InventoriaManifestTable createAlias(String alias) {
    return $InventoriaManifestTable(attachedDatabase, alias);
  }
}

class InventoriaManifestData extends DataClass
    implements Insertable<InventoriaManifestData> {
  final int id;
  final String hash;
  final DateTime timestamp;
  const InventoriaManifestData({
    required this.id,
    required this.hash,
    required this.timestamp,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['hash'] = Variable<String>(hash);
    map['timestamp'] = Variable<DateTime>(timestamp);
    return map;
  }

  InventoriaManifestCompanion toCompanion(bool nullToAbsent) {
    return InventoriaManifestCompanion(
      id: Value(id),
      hash: Value(hash),
      timestamp: Value(timestamp),
    );
  }

  factory InventoriaManifestData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InventoriaManifestData(
      id: serializer.fromJson<int>(json['id']),
      hash: serializer.fromJson<String>(json['hash']),
      timestamp: serializer.fromJson<DateTime>(json['timestamp']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'hash': serializer.toJson<String>(hash),
      'timestamp': serializer.toJson<DateTime>(timestamp),
    };
  }

  InventoriaManifestData copyWith({
    int? id,
    String? hash,
    DateTime? timestamp,
  }) => InventoriaManifestData(
    id: id ?? this.id,
    hash: hash ?? this.hash,
    timestamp: timestamp ?? this.timestamp,
  );
  InventoriaManifestData copyWithCompanion(InventoriaManifestCompanion data) {
    return InventoriaManifestData(
      id: data.id.present ? data.id.value : this.id,
      hash: data.hash.present ? data.hash.value : this.hash,
      timestamp: data.timestamp.present ? data.timestamp.value : this.timestamp,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InventoriaManifestData(')
          ..write('id: $id, ')
          ..write('hash: $hash, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, hash, timestamp);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InventoriaManifestData &&
          other.id == this.id &&
          other.hash == this.hash &&
          other.timestamp == this.timestamp);
}

class InventoriaManifestCompanion
    extends UpdateCompanion<InventoriaManifestData> {
  final Value<int> id;
  final Value<String> hash;
  final Value<DateTime> timestamp;
  const InventoriaManifestCompanion({
    this.id = const Value.absent(),
    this.hash = const Value.absent(),
    this.timestamp = const Value.absent(),
  });
  InventoriaManifestCompanion.insert({
    this.id = const Value.absent(),
    required String hash,
    required DateTime timestamp,
  }) : hash = Value(hash),
       timestamp = Value(timestamp);
  static Insertable<InventoriaManifestData> custom({
    Expression<int>? id,
    Expression<String>? hash,
    Expression<DateTime>? timestamp,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (hash != null) 'hash': hash,
      if (timestamp != null) 'timestamp': timestamp,
    });
  }

  InventoriaManifestCompanion copyWith({
    Value<int>? id,
    Value<String>? hash,
    Value<DateTime>? timestamp,
  }) {
    return InventoriaManifestCompanion(
      id: id ?? this.id,
      hash: hash ?? this.hash,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (hash.present) {
      map['hash'] = Variable<String>(hash.value);
    }
    if (timestamp.present) {
      map['timestamp'] = Variable<DateTime>(timestamp.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InventoriaManifestCompanion(')
          ..write('id: $id, ')
          ..write('hash: $hash, ')
          ..write('timestamp: $timestamp')
          ..write(')'))
        .toString();
  }
}

abstract class _$InventoriaDatabase extends GeneratedDatabase {
  _$InventoriaDatabase(QueryExecutor e) : super(e);
  $InventoriaDatabaseManager get managers => $InventoriaDatabaseManager(this);
  late final $InventoryItemTable inventoryItem = $InventoryItemTable(this);
  late final $DriftProfileTable driftProfile = $DriftProfileTable(this);
  late final $InventoriaManifestTable inventoriaManifest =
      $InventoriaManifestTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    inventoryItem,
    driftProfile,
    inventoriaManifest,
  ];
}

typedef $$InventoryItemTableCreateCompanionBuilder =
    InventoryItemCompanion Function({
      required String uniqueName,
      required String name,
      Value<String?> description,
      Value<String?> image,
      Value<String?> productCategory,
      required String type,
      Value<int> xp,
      Value<int> rowid,
    });
typedef $$InventoryItemTableUpdateCompanionBuilder =
    InventoryItemCompanion Function({
      Value<String> uniqueName,
      Value<String> name,
      Value<String?> description,
      Value<String?> image,
      Value<String?> productCategory,
      Value<String> type,
      Value<int> xp,
      Value<int> rowid,
    });

class $$InventoryItemTableFilterComposer
    extends Composer<_$InventoriaDatabase, $InventoryItemTable> {
  $$InventoryItemTableFilterComposer({
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

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productCategory => $composableBuilder(
    column: $table.productCategory,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMissing => $composableBuilder(
    column: $table.isMissing,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoryItemTableOrderingComposer
    extends Composer<_$InventoriaDatabase, $InventoryItemTable> {
  $$InventoryItemTableOrderingComposer({
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

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productCategory => $composableBuilder(
    column: $table.productCategory,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get xp => $composableBuilder(
    column: $table.xp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMissing => $composableBuilder(
    column: $table.isMissing,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isHidden => $composableBuilder(
    column: $table.isHidden,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoryItemTableAnnotationComposer
    extends Composer<_$InventoriaDatabase, $InventoryItemTable> {
  $$InventoryItemTableAnnotationComposer({
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

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<String> get productCategory => $composableBuilder(
    column: $table.productCategory,
    builder: (column) => column,
  );

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);

  GeneratedColumn<bool> get isMissing =>
      $composableBuilder(column: $table.isMissing, builder: (column) => column);

  GeneratedColumn<bool> get isHidden =>
      $composableBuilder(column: $table.isHidden, builder: (column) => column);
}

class $$InventoryItemTableTableManager
    extends
        RootTableManager<
          _$InventoriaDatabase,
          $InventoryItemTable,
          InventoryItemData,
          $$InventoryItemTableFilterComposer,
          $$InventoryItemTableOrderingComposer,
          $$InventoryItemTableAnnotationComposer,
          $$InventoryItemTableCreateCompanionBuilder,
          $$InventoryItemTableUpdateCompanionBuilder,
          (
            InventoryItemData,
            BaseReferences<
              _$InventoriaDatabase,
              $InventoryItemTable,
              InventoryItemData
            >,
          ),
          InventoryItemData,
          PrefetchHooks Function()
        > {
  $$InventoryItemTableTableManager(
    _$InventoriaDatabase db,
    $InventoryItemTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InventoryItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () =>
                  $$InventoryItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () => $$InventoryItemTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> uniqueName = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> productCategory = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> xp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemCompanion(
                uniqueName: uniqueName,
                name: name,
                description: description,
                image: image,
                productCategory: productCategory,
                type: type,
                xp: xp,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String uniqueName,
                required String name,
                Value<String?> description = const Value.absent(),
                Value<String?> image = const Value.absent(),
                Value<String?> productCategory = const Value.absent(),
                required String type,
                Value<int> xp = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => InventoryItemCompanion.insert(
                uniqueName: uniqueName,
                name: name,
                description: description,
                image: image,
                productCategory: productCategory,
                type: type,
                xp: xp,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoryItemTableProcessedTableManager =
    ProcessedTableManager<
      _$InventoriaDatabase,
      $InventoryItemTable,
      InventoryItemData,
      $$InventoryItemTableFilterComposer,
      $$InventoryItemTableOrderingComposer,
      $$InventoryItemTableAnnotationComposer,
      $$InventoryItemTableCreateCompanionBuilder,
      $$InventoryItemTableUpdateCompanionBuilder,
      (
        InventoryItemData,
        BaseReferences<
          _$InventoriaDatabase,
          $InventoryItemTable,
          InventoryItemData
        >,
      ),
      InventoryItemData,
      PrefetchHooks Function()
    >;
typedef $$DriftProfileTableCreateCompanionBuilder =
    DriftProfileCompanion Function({
      required String id,
      required String username,
      required int rank,
      Value<int> rowid,
    });
typedef $$DriftProfileTableUpdateCompanionBuilder =
    DriftProfileCompanion Function({
      Value<String> id,
      Value<String> username,
      Value<int> rank,
      Value<int> rowid,
    });

class $$DriftProfileTableFilterComposer
    extends Composer<_$InventoriaDatabase, $DriftProfileTable> {
  $$DriftProfileTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DriftProfileTableOrderingComposer
    extends Composer<_$InventoriaDatabase, $DriftProfileTable> {
  $$DriftProfileTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rank => $composableBuilder(
    column: $table.rank,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DriftProfileTableAnnotationComposer
    extends Composer<_$InventoriaDatabase, $DriftProfileTable> {
  $$DriftProfileTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<int> get rank =>
      $composableBuilder(column: $table.rank, builder: (column) => column);
}

class $$DriftProfileTableTableManager
    extends
        RootTableManager<
          _$InventoriaDatabase,
          $DriftProfileTable,
          DriftProfileData,
          $$DriftProfileTableFilterComposer,
          $$DriftProfileTableOrderingComposer,
          $$DriftProfileTableAnnotationComposer,
          $$DriftProfileTableCreateCompanionBuilder,
          $$DriftProfileTableUpdateCompanionBuilder,
          (
            DriftProfileData,
            BaseReferences<
              _$InventoriaDatabase,
              $DriftProfileTable,
              DriftProfileData
            >,
          ),
          DriftProfileData,
          PrefetchHooks Function()
        > {
  $$DriftProfileTableTableManager(
    _$InventoriaDatabase db,
    $DriftProfileTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$DriftProfileTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$DriftProfileTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$DriftProfileTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<int> rank = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DriftProfileCompanion(
                id: id,
                username: username,
                rank: rank,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String username,
                required int rank,
                Value<int> rowid = const Value.absent(),
              }) => DriftProfileCompanion.insert(
                id: id,
                username: username,
                rank: rank,
                rowid: rowid,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DriftProfileTableProcessedTableManager =
    ProcessedTableManager<
      _$InventoriaDatabase,
      $DriftProfileTable,
      DriftProfileData,
      $$DriftProfileTableFilterComposer,
      $$DriftProfileTableOrderingComposer,
      $$DriftProfileTableAnnotationComposer,
      $$DriftProfileTableCreateCompanionBuilder,
      $$DriftProfileTableUpdateCompanionBuilder,
      (
        DriftProfileData,
        BaseReferences<
          _$InventoriaDatabase,
          $DriftProfileTable,
          DriftProfileData
        >,
      ),
      DriftProfileData,
      PrefetchHooks Function()
    >;
typedef $$InventoriaManifestTableCreateCompanionBuilder =
    InventoriaManifestCompanion Function({
      Value<int> id,
      required String hash,
      required DateTime timestamp,
    });
typedef $$InventoriaManifestTableUpdateCompanionBuilder =
    InventoriaManifestCompanion Function({
      Value<int> id,
      Value<String> hash,
      Value<DateTime> timestamp,
    });

class $$InventoriaManifestTableFilterComposer
    extends Composer<_$InventoriaDatabase, $InventoriaManifestTable> {
  $$InventoriaManifestTableFilterComposer({
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

  ColumnFilters<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnFilters(column),
  );
}

class $$InventoriaManifestTableOrderingComposer
    extends Composer<_$InventoriaDatabase, $InventoriaManifestTable> {
  $$InventoriaManifestTableOrderingComposer({
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

  ColumnOrderings<String> get hash => $composableBuilder(
    column: $table.hash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get timestamp => $composableBuilder(
    column: $table.timestamp,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$InventoriaManifestTableAnnotationComposer
    extends Composer<_$InventoriaDatabase, $InventoriaManifestTable> {
  $$InventoriaManifestTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get hash =>
      $composableBuilder(column: $table.hash, builder: (column) => column);

  GeneratedColumn<DateTime> get timestamp =>
      $composableBuilder(column: $table.timestamp, builder: (column) => column);
}

class $$InventoriaManifestTableTableManager
    extends
        RootTableManager<
          _$InventoriaDatabase,
          $InventoriaManifestTable,
          InventoriaManifestData,
          $$InventoriaManifestTableFilterComposer,
          $$InventoriaManifestTableOrderingComposer,
          $$InventoriaManifestTableAnnotationComposer,
          $$InventoriaManifestTableCreateCompanionBuilder,
          $$InventoriaManifestTableUpdateCompanionBuilder,
          (
            InventoriaManifestData,
            BaseReferences<
              _$InventoriaDatabase,
              $InventoriaManifestTable,
              InventoriaManifestData
            >,
          ),
          InventoriaManifestData,
          PrefetchHooks Function()
        > {
  $$InventoriaManifestTableTableManager(
    _$InventoriaDatabase db,
    $InventoriaManifestTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$InventoriaManifestTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$InventoriaManifestTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$InventoriaManifestTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> hash = const Value.absent(),
                Value<DateTime> timestamp = const Value.absent(),
              }) => InventoriaManifestCompanion(
                id: id,
                hash: hash,
                timestamp: timestamp,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String hash,
                required DateTime timestamp,
              }) => InventoriaManifestCompanion.insert(
                id: id,
                hash: hash,
                timestamp: timestamp,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$InventoriaManifestTableProcessedTableManager =
    ProcessedTableManager<
      _$InventoriaDatabase,
      $InventoriaManifestTable,
      InventoriaManifestData,
      $$InventoriaManifestTableFilterComposer,
      $$InventoriaManifestTableOrderingComposer,
      $$InventoriaManifestTableAnnotationComposer,
      $$InventoriaManifestTableCreateCompanionBuilder,
      $$InventoriaManifestTableUpdateCompanionBuilder,
      (
        InventoriaManifestData,
        BaseReferences<
          _$InventoriaDatabase,
          $InventoriaManifestTable,
          InventoriaManifestData
        >,
      ),
      InventoriaManifestData,
      PrefetchHooks Function()
    >;

class $InventoriaDatabaseManager {
  final _$InventoriaDatabase _db;
  $InventoriaDatabaseManager(this._db);
  $$InventoryItemTableTableManager get inventoryItem =>
      $$InventoryItemTableTableManager(_db, _db.inventoryItem);
  $$DriftProfileTableTableManager get driftProfile =>
      $$DriftProfileTableTableManager(_db, _db.driftProfile);
  $$InventoriaManifestTableTableManager get inventoriaManifest =>
      $$InventoriaManifestTableTableManager(_db, _db.inventoriaManifest);
}
