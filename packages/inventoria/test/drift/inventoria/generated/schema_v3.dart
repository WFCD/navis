// dart format width=80
// GENERATED CODE, DO NOT EDIT BY HAND.
// ignore_for_file: type=lint
import 'package:drift/drift.dart';

class InventoryItem extends Table
    with TableInfo<InventoryItem, InventoryItemData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InventoryItem(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
    'unique_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> productCategory = GeneratedColumn<String>(
    'product_category',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
    'xp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const CustomExpression('0'),
  );
  late final GeneratedColumn<bool> isMissing = GeneratedColumn<bool>(
    'is_missing',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_missing" IN (0, 1))',
    ),
  );
  late final GeneratedColumn<bool> isHidden = GeneratedColumn<bool>(
    'is_hidden',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
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
  InventoryItem createAlias(String alias) {
    return InventoryItem(attachedDatabase, alias);
  }
}

class InventoryItemData extends DataClass
    implements Insertable<InventoryItemData> {
  final String uniqueName;
  final String name;
  final String? description;
  final String? image;
  final String? productCategory;
  final String type;
  final int xp;
  final bool isMissing;
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
    map['is_missing'] = Variable<bool>(isMissing);
    map['is_hidden'] = Variable<bool>(isHidden);
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
      isMissing: Value(isMissing),
      isHidden: Value(isHidden),
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
  InventoryItemData copyWithCompanion(InventoryItemCompanion data) {
    return InventoryItemData(
      uniqueName:
          data.uniqueName.present ? data.uniqueName.value : this.uniqueName,
      name: data.name.present ? data.name.value : this.name,
      description:
          data.description.present ? data.description.value : this.description,
      image: data.image.present ? data.image.value : this.image,
      productCategory:
          data.productCategory.present
              ? data.productCategory.value
              : this.productCategory,
      type: data.type.present ? data.type.value : this.type,
      xp: data.xp.present ? data.xp.value : this.xp,
      isMissing: data.isMissing.present ? data.isMissing.value : this.isMissing,
      isHidden: data.isHidden.present ? data.isHidden.value : this.isHidden,
    );
  }

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
  final Value<bool> isMissing;
  final Value<bool> isHidden;
  final Value<int> rowid;
  const InventoryItemCompanion({
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.image = const Value.absent(),
    this.productCategory = const Value.absent(),
    this.type = const Value.absent(),
    this.xp = const Value.absent(),
    this.isMissing = const Value.absent(),
    this.isHidden = const Value.absent(),
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
    required bool isMissing,
    required bool isHidden,
    this.rowid = const Value.absent(),
  }) : uniqueName = Value(uniqueName),
       name = Value(name),
       type = Value(type),
       isMissing = Value(isMissing),
       isHidden = Value(isHidden);
  static Insertable<InventoryItemData> custom({
    Expression<String>? uniqueName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? image,
    Expression<String>? productCategory,
    Expression<String>? type,
    Expression<int>? xp,
    Expression<bool>? isMissing,
    Expression<bool>? isHidden,
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
      if (isMissing != null) 'is_missing': isMissing,
      if (isHidden != null) 'is_hidden': isHidden,
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
    Value<bool>? isMissing,
    Value<bool>? isHidden,
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
      isMissing: isMissing ?? this.isMissing,
      isHidden: isHidden ?? this.isHidden,
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
    if (isMissing.present) {
      map['is_missing'] = Variable<bool>(isMissing.value);
    }
    if (isHidden.present) {
      map['is_hidden'] = Variable<bool>(isHidden.value);
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
          ..write('isMissing: $isMissing, ')
          ..write('isHidden: $isHidden, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class DriftProfile extends Table
    with TableInfo<DriftProfile, DriftProfileData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  DriftProfile(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  DriftProfile createAlias(String alias) {
    return DriftProfile(attachedDatabase, alias);
  }
}

class DriftProfileData extends DataClass
    implements Insertable<DriftProfileData> {
  final String id;
  final String username;
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

class InventoriaManifest extends Table
    with TableInfo<InventoriaManifest, InventoriaManifestData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  InventoriaManifest(this.attachedDatabase, [this._alias]);
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  late final GeneratedColumn<String> hash = GeneratedColumn<String>(
    'hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  InventoriaManifest createAlias(String alias) {
    return InventoriaManifest(attachedDatabase, alias);
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

class DatabaseAtV3 extends GeneratedDatabase {
  DatabaseAtV3(QueryExecutor e) : super(e);
  late final InventoryItem inventoryItem = InventoryItem(this);
  late final DriftProfile driftProfile = DriftProfile(this);
  late final InventoriaManifest inventoriaManifest = InventoriaManifest(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    inventoryItem,
    driftProfile,
    inventoriaManifest,
  ];
  @override
  int get schemaVersion => 3;
}
