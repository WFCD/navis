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
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
      xp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}xp'],
      ),
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
  final int? xp;
  const InventoryItemData({
    required this.uniqueName,
    required this.name,
    this.description,
    this.image,
    this.productCategory,
    required this.type,
    this.xp,
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
    if (!nullToAbsent || xp != null) {
      map['xp'] = Variable<int>(xp);
    }
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
      xp: xp == null && nullToAbsent ? const Value.absent() : Value(xp),
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
      xp: serializer.fromJson<int?>(json['xp']),
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
      'xp': serializer.toJson<int?>(xp),
    };
  }

  InventoryItemData copyWith({
    String? uniqueName,
    String? name,
    Value<String?> description = const Value.absent(),
    Value<String?> image = const Value.absent(),
    Value<String?> productCategory = const Value.absent(),
    String? type,
    Value<int?> xp = const Value.absent(),
  }) => InventoryItemData(
    uniqueName: uniqueName ?? this.uniqueName,
    name: name ?? this.name,
    description: description.present ? description.value : this.description,
    image: image.present ? image.value : this.image,
    productCategory:
        productCategory.present ? productCategory.value : this.productCategory,
    type: type ?? this.type,
    xp: xp.present ? xp.value : this.xp,
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
          ..write('xp: $xp')
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
          other.xp == this.xp);
}

class InventoryItemCompanion extends UpdateCompanion<InventoryItemData> {
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> image;
  final Value<String?> productCategory;
  final Value<String> type;
  final Value<int?> xp;
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
    Value<int?>? xp,
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

class DatabaseAtV1 extends GeneratedDatabase {
  DatabaseAtV1(QueryExecutor e) : super(e);
  late final InventoryItem inventoryItem = InventoryItem(this);
  late final DriftProfile driftProfile = DriftProfile(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    inventoryItem,
    driftProfile,
  ];
  @override
  int get schemaVersion => 1;
}
