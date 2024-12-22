// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'arsenal_database.dart';

// ignore_for_file: type=lint
class $ArsenalItemTable extends ArsenalItem
    with TableInfo<$ArsenalItemTable, MinimalItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArsenalItemTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uniqueNameMeta =
      const VerificationMeta('uniqueName');
  @override
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
      'unique_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _imageNameMeta =
      const VerificationMeta('imageName');
  @override
  late final GeneratedColumn<String> imageName = GeneratedColumn<String>(
      'image_name', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumnWithTypeConverter<ItemType, String> type =
      GeneratedColumn<String>('type', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<ItemType>($ArsenalItemTable.$convertertype);
  static const VerificationMeta _productCategoryMeta =
      const VerificationMeta('productCategory');
  @override
  late final GeneratedColumn<String> productCategory = GeneratedColumn<String>(
      'product_category', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _categoryMeta =
      const VerificationMeta('category');
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
      'category', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tradableMeta =
      const VerificationMeta('tradable');
  @override
  late final GeneratedColumn<bool> tradable = GeneratedColumn<bool>(
      'tradable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("tradable" IN (0, 1))'));
  static const VerificationMeta _excludeFromCodexMeta =
      const VerificationMeta('excludeFromCodex');
  @override
  late final GeneratedColumn<bool> excludeFromCodex = GeneratedColumn<bool>(
      'exclude_from_codex', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'CHECK ("exclude_from_codex" IN (0, 1))'));
  static const VerificationMeta _vaultDateMeta =
      const VerificationMeta('vaultDate');
  @override
  late final GeneratedColumn<String> vaultDate = GeneratedColumn<String>(
      'vault_date', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _vaultedMeta =
      const VerificationMeta('vaulted');
  @override
  late final GeneratedColumn<bool> vaulted = GeneratedColumn<bool>(
      'vaulted', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("vaulted" IN (0, 1))'));
  static const VerificationMeta _wikiaUrlMeta =
      const VerificationMeta('wikiaUrl');
  @override
  late final GeneratedColumn<String> wikiaUrl = GeneratedColumn<String>(
      'wikia_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _masterableMeta =
      const VerificationMeta('masterable');
  @override
  late final GeneratedColumn<bool> masterable = GeneratedColumn<bool>(
      'masterable', aliasedName, true,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("masterable" IN (0, 1))'));
  @override
  List<GeneratedColumn> get $columns => [
        uniqueName,
        name,
        description,
        imageName,
        type,
        productCategory,
        category,
        tradable,
        excludeFromCodex,
        vaultDate,
        vaulted,
        wikiaUrl,
        masterable
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'arsenal_item';
  @override
  VerificationContext validateIntegrity(Insertable<MinimalItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unique_name')) {
      context.handle(
          _uniqueNameMeta,
          uniqueName.isAcceptableOrUnknown(
              data['unique_name']!, _uniqueNameMeta));
    } else if (isInserting) {
      context.missing(_uniqueNameMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('image_name')) {
      context.handle(_imageNameMeta,
          imageName.isAcceptableOrUnknown(data['image_name']!, _imageNameMeta));
    }
    context.handle(_typeMeta, const VerificationResult.success());
    if (data.containsKey('product_category')) {
      context.handle(
          _productCategoryMeta,
          productCategory.isAcceptableOrUnknown(
              data['product_category']!, _productCategoryMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('tradable')) {
      context.handle(_tradableMeta,
          tradable.isAcceptableOrUnknown(data['tradable']!, _tradableMeta));
    } else if (isInserting) {
      context.missing(_tradableMeta);
    }
    if (data.containsKey('exclude_from_codex')) {
      context.handle(
          _excludeFromCodexMeta,
          excludeFromCodex.isAcceptableOrUnknown(
              data['exclude_from_codex']!, _excludeFromCodexMeta));
    }
    if (data.containsKey('vault_date')) {
      context.handle(_vaultDateMeta,
          vaultDate.isAcceptableOrUnknown(data['vault_date']!, _vaultDateMeta));
    }
    if (data.containsKey('vaulted')) {
      context.handle(_vaultedMeta,
          vaulted.isAcceptableOrUnknown(data['vaulted']!, _vaultedMeta));
    }
    if (data.containsKey('wikia_url')) {
      context.handle(_wikiaUrlMeta,
          wikiaUrl.isAcceptableOrUnknown(data['wikia_url']!, _wikiaUrlMeta));
    }
    if (data.containsKey('masterable')) {
      context.handle(
          _masterableMeta,
          masterable.isAcceptableOrUnknown(
              data['masterable']!, _masterableMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {uniqueName};
  @override
  MinimalItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MinimalItem(
      uniqueName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unique_name'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      type: $ArsenalItemTable.$convertertype.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!),
      category: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}category'])!,
      productCategory: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}product_category']),
      imageName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}image_name']),
      tradable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}tradable'])!,
      excludeFromCodex: attachedDatabase.typeMapping.read(
          DriftSqlType.bool, data['${effectivePrefix}exclude_from_codex']),
      wikiaUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}wikia_url']),
      vaultDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}vault_date']),
      vaulted: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}vaulted']),
      masterable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}masterable']),
    );
  }

  @override
  $ArsenalItemTable createAlias(String alias) {
    return $ArsenalItemTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ItemType, String, String> $convertertype =
      const ItemTypeConverter();
}

class ArsenalItemCompanion extends UpdateCompanion<MinimalItem> {
  final Value<String> uniqueName;
  final Value<String> name;
  final Value<String?> description;
  final Value<String?> imageName;
  final Value<ItemType> type;
  final Value<String?> productCategory;
  final Value<String> category;
  final Value<bool> tradable;
  final Value<bool?> excludeFromCodex;
  final Value<String?> vaultDate;
  final Value<bool?> vaulted;
  final Value<String?> wikiaUrl;
  final Value<bool?> masterable;
  final Value<int> rowid;
  const ArsenalItemCompanion({
    this.uniqueName = const Value.absent(),
    this.name = const Value.absent(),
    this.description = const Value.absent(),
    this.imageName = const Value.absent(),
    this.type = const Value.absent(),
    this.productCategory = const Value.absent(),
    this.category = const Value.absent(),
    this.tradable = const Value.absent(),
    this.excludeFromCodex = const Value.absent(),
    this.vaultDate = const Value.absent(),
    this.vaulted = const Value.absent(),
    this.wikiaUrl = const Value.absent(),
    this.masterable = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArsenalItemCompanion.insert({
    required String uniqueName,
    required String name,
    this.description = const Value.absent(),
    this.imageName = const Value.absent(),
    required ItemType type,
    this.productCategory = const Value.absent(),
    required String category,
    required bool tradable,
    this.excludeFromCodex = const Value.absent(),
    this.vaultDate = const Value.absent(),
    this.vaulted = const Value.absent(),
    this.wikiaUrl = const Value.absent(),
    this.masterable = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : uniqueName = Value(uniqueName),
        name = Value(name),
        type = Value(type),
        category = Value(category),
        tradable = Value(tradable);
  static Insertable<MinimalItem> custom({
    Expression<String>? uniqueName,
    Expression<String>? name,
    Expression<String>? description,
    Expression<String>? imageName,
    Expression<String>? type,
    Expression<String>? productCategory,
    Expression<String>? category,
    Expression<bool>? tradable,
    Expression<bool>? excludeFromCodex,
    Expression<String>? vaultDate,
    Expression<bool>? vaulted,
    Expression<String>? wikiaUrl,
    Expression<bool>? masterable,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (uniqueName != null) 'unique_name': uniqueName,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (imageName != null) 'image_name': imageName,
      if (type != null) 'type': type,
      if (productCategory != null) 'product_category': productCategory,
      if (category != null) 'category': category,
      if (tradable != null) 'tradable': tradable,
      if (excludeFromCodex != null) 'exclude_from_codex': excludeFromCodex,
      if (vaultDate != null) 'vault_date': vaultDate,
      if (vaulted != null) 'vaulted': vaulted,
      if (wikiaUrl != null) 'wikia_url': wikiaUrl,
      if (masterable != null) 'masterable': masterable,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArsenalItemCompanion copyWith(
      {Value<String>? uniqueName,
      Value<String>? name,
      Value<String?>? description,
      Value<String?>? imageName,
      Value<ItemType>? type,
      Value<String?>? productCategory,
      Value<String>? category,
      Value<bool>? tradable,
      Value<bool?>? excludeFromCodex,
      Value<String?>? vaultDate,
      Value<bool?>? vaulted,
      Value<String?>? wikiaUrl,
      Value<bool?>? masterable,
      Value<int>? rowid}) {
    return ArsenalItemCompanion(
      uniqueName: uniqueName ?? this.uniqueName,
      name: name ?? this.name,
      description: description ?? this.description,
      imageName: imageName ?? this.imageName,
      type: type ?? this.type,
      productCategory: productCategory ?? this.productCategory,
      category: category ?? this.category,
      tradable: tradable ?? this.tradable,
      excludeFromCodex: excludeFromCodex ?? this.excludeFromCodex,
      vaultDate: vaultDate ?? this.vaultDate,
      vaulted: vaulted ?? this.vaulted,
      wikiaUrl: wikiaUrl ?? this.wikiaUrl,
      masterable: masterable ?? this.masterable,
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
    if (type.present) {
      map['type'] =
          Variable<String>($ArsenalItemTable.$convertertype.toSql(type.value));
    }
    if (productCategory.present) {
      map['product_category'] = Variable<String>(productCategory.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (tradable.present) {
      map['tradable'] = Variable<bool>(tradable.value);
    }
    if (excludeFromCodex.present) {
      map['exclude_from_codex'] = Variable<bool>(excludeFromCodex.value);
    }
    if (vaultDate.present) {
      map['vault_date'] = Variable<String>(vaultDate.value);
    }
    if (vaulted.present) {
      map['vaulted'] = Variable<bool>(vaulted.value);
    }
    if (wikiaUrl.present) {
      map['wikia_url'] = Variable<String>(wikiaUrl.value);
    }
    if (masterable.present) {
      map['masterable'] = Variable<bool>(masterable.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArsenalItemCompanion(')
          ..write('uniqueName: $uniqueName, ')
          ..write('name: $name, ')
          ..write('description: $description, ')
          ..write('imageName: $imageName, ')
          ..write('type: $type, ')
          ..write('productCategory: $productCategory, ')
          ..write('category: $category, ')
          ..write('tradable: $tradable, ')
          ..write('excludeFromCodex: $excludeFromCodex, ')
          ..write('vaultDate: $vaultDate, ')
          ..write('vaulted: $vaulted, ')
          ..write('wikiaUrl: $wikiaUrl, ')
          ..write('masterable: $masterable, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArsenalManifestTable extends ArsenalManifest
    with TableInfo<$ArsenalManifestTable, ArsenalManifestData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArsenalManifestTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _lastUpdateMeta =
      const VerificationMeta('lastUpdate');
  @override
  late final GeneratedColumn<DateTime> lastUpdate = GeneratedColumn<DateTime>(
      'last_update', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, lastUpdate];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'arsenal_manifest';
  @override
  VerificationContext validateIntegrity(
      Insertable<ArsenalManifestData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('last_update')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['last_update']!, _lastUpdateMeta));
    } else if (isInserting) {
      context.missing(_lastUpdateMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArsenalManifestData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArsenalManifestData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      lastUpdate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_update'])!,
    );
  }

  @override
  $ArsenalManifestTable createAlias(String alias) {
    return $ArsenalManifestTable(attachedDatabase, alias);
  }
}

class ArsenalManifestData extends DataClass
    implements Insertable<ArsenalManifestData> {
  final int id;
  final DateTime lastUpdate;
  const ArsenalManifestData({required this.id, required this.lastUpdate});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['last_update'] = Variable<DateTime>(lastUpdate);
    return map;
  }

  ArsenalManifestCompanion toCompanion(bool nullToAbsent) {
    return ArsenalManifestCompanion(
      id: Value(id),
      lastUpdate: Value(lastUpdate),
    );
  }

  factory ArsenalManifestData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArsenalManifestData(
      id: serializer.fromJson<int>(json['id']),
      lastUpdate: serializer.fromJson<DateTime>(json['lastUpdate']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'lastUpdate': serializer.toJson<DateTime>(lastUpdate),
    };
  }

  ArsenalManifestData copyWith({int? id, DateTime? lastUpdate}) =>
      ArsenalManifestData(
        id: id ?? this.id,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );
  ArsenalManifestData copyWithCompanion(ArsenalManifestCompanion data) {
    return ArsenalManifestData(
      id: data.id.present ? data.id.value : this.id,
      lastUpdate:
          data.lastUpdate.present ? data.lastUpdate.value : this.lastUpdate,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArsenalManifestData(')
          ..write('id: $id, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, lastUpdate);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArsenalManifestData &&
          other.id == this.id &&
          other.lastUpdate == this.lastUpdate);
}

class ArsenalManifestCompanion extends UpdateCompanion<ArsenalManifestData> {
  final Value<int> id;
  final Value<DateTime> lastUpdate;
  const ArsenalManifestCompanion({
    this.id = const Value.absent(),
    this.lastUpdate = const Value.absent(),
  });
  ArsenalManifestCompanion.insert({
    this.id = const Value.absent(),
    required DateTime lastUpdate,
  }) : lastUpdate = Value(lastUpdate);
  static Insertable<ArsenalManifestData> custom({
    Expression<int>? id,
    Expression<DateTime>? lastUpdate,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (lastUpdate != null) 'last_update': lastUpdate,
    });
  }

  ArsenalManifestCompanion copyWith(
      {Value<int>? id, Value<DateTime>? lastUpdate}) {
    return ArsenalManifestCompanion(
      id: id ?? this.id,
      lastUpdate: lastUpdate ?? this.lastUpdate,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (lastUpdate.present) {
      map['last_update'] = Variable<DateTime>(lastUpdate.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArsenalManifestCompanion(')
          ..write('id: $id, ')
          ..write('lastUpdate: $lastUpdate')
          ..write(')'))
        .toString();
  }
}

class $ArsenalItemXpTable extends ArsenalItemXp
    with TableInfo<$ArsenalItemXpTable, XpItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArsenalItemXpTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _uniqueNameMeta =
      const VerificationMeta('uniqueName');
  @override
  late final GeneratedColumn<String> uniqueName = GeneratedColumn<String>(
      'unique_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _xpMeta = const VerificationMeta('xp');
  @override
  late final GeneratedColumn<int> xp = GeneratedColumn<int>(
      'xp', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [uniqueName, xp];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'arsenal_item_xp';
  @override
  VerificationContext validateIntegrity(Insertable<XpItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('unique_name')) {
      context.handle(
          _uniqueNameMeta,
          uniqueName.isAcceptableOrUnknown(
              data['unique_name']!, _uniqueNameMeta));
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
      uniqueName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}unique_name'])!,
      xp: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}xp'])!,
    );
  }

  @override
  $ArsenalItemXpTable createAlias(String alias) {
    return $ArsenalItemXpTable(attachedDatabase, alias);
  }
}

class ArsenalItemXpCompanion extends UpdateCompanion<XpItem> {
  final Value<String> uniqueName;
  final Value<int> xp;
  final Value<int> rowid;
  const ArsenalItemXpCompanion({
    this.uniqueName = const Value.absent(),
    this.xp = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArsenalItemXpCompanion.insert({
    required String uniqueName,
    required int xp,
    this.rowid = const Value.absent(),
  })  : uniqueName = Value(uniqueName),
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

  ArsenalItemXpCompanion copyWith(
      {Value<String>? uniqueName, Value<int>? xp, Value<int>? rowid}) {
    return ArsenalItemXpCompanion(
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
    return (StringBuffer('ArsenalItemXpCompanion(')
          ..write('uniqueName: $uniqueName, ')
          ..write('xp: $xp, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$ArsenalDatabase extends GeneratedDatabase {
  _$ArsenalDatabase(QueryExecutor e) : super(e);
  $ArsenalDatabaseManager get managers => $ArsenalDatabaseManager(this);
  late final $ArsenalItemTable arsenalItem = $ArsenalItemTable(this);
  late final $ArsenalManifestTable arsenalManifest =
      $ArsenalManifestTable(this);
  late final $ArsenalItemXpTable arsenalItemXp = $ArsenalItemXpTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [arsenalItem, arsenalManifest, arsenalItemXp];
}

typedef $$ArsenalItemTableCreateCompanionBuilder = ArsenalItemCompanion
    Function({
  required String uniqueName,
  required String name,
  Value<String?> description,
  Value<String?> imageName,
  required ItemType type,
  Value<String?> productCategory,
  required String category,
  required bool tradable,
  Value<bool?> excludeFromCodex,
  Value<String?> vaultDate,
  Value<bool?> vaulted,
  Value<String?> wikiaUrl,
  Value<bool?> masterable,
  Value<int> rowid,
});
typedef $$ArsenalItemTableUpdateCompanionBuilder = ArsenalItemCompanion
    Function({
  Value<String> uniqueName,
  Value<String> name,
  Value<String?> description,
  Value<String?> imageName,
  Value<ItemType> type,
  Value<String?> productCategory,
  Value<String> category,
  Value<bool> tradable,
  Value<bool?> excludeFromCodex,
  Value<String?> vaultDate,
  Value<bool?> vaulted,
  Value<String?> wikiaUrl,
  Value<bool?> masterable,
  Value<int> rowid,
});

class $$ArsenalItemTableFilterComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemTable> {
  $$ArsenalItemTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get imageName => $composableBuilder(
      column: $table.imageName, builder: (column) => ColumnFilters(column));

  ColumnWithTypeConverterFilters<ItemType, ItemType, String> get type =>
      $composableBuilder(
          column: $table.type,
          builder: (column) => ColumnWithTypeConverterFilters(column));

  ColumnFilters<String> get productCategory => $composableBuilder(
      column: $table.productCategory,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get tradable => $composableBuilder(
      column: $table.tradable, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get excludeFromCodex => $composableBuilder(
      column: $table.excludeFromCodex,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get vaultDate => $composableBuilder(
      column: $table.vaultDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get vaulted => $composableBuilder(
      column: $table.vaulted, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get wikiaUrl => $composableBuilder(
      column: $table.wikiaUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get masterable => $composableBuilder(
      column: $table.masterable, builder: (column) => ColumnFilters(column));
}

class $$ArsenalItemTableOrderingComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemTable> {
  $$ArsenalItemTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get name => $composableBuilder(
      column: $table.name, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get imageName => $composableBuilder(
      column: $table.imageName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get type => $composableBuilder(
      column: $table.type, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get productCategory => $composableBuilder(
      column: $table.productCategory,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get category => $composableBuilder(
      column: $table.category, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get tradable => $composableBuilder(
      column: $table.tradable, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get excludeFromCodex => $composableBuilder(
      column: $table.excludeFromCodex,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get vaultDate => $composableBuilder(
      column: $table.vaultDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get vaulted => $composableBuilder(
      column: $table.vaulted, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get wikiaUrl => $composableBuilder(
      column: $table.wikiaUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get masterable => $composableBuilder(
      column: $table.masterable, builder: (column) => ColumnOrderings(column));
}

class $$ArsenalItemTableAnnotationComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemTable> {
  $$ArsenalItemTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<String> get imageName =>
      $composableBuilder(column: $table.imageName, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ItemType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get productCategory => $composableBuilder(
      column: $table.productCategory, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<bool> get tradable =>
      $composableBuilder(column: $table.tradable, builder: (column) => column);

  GeneratedColumn<bool> get excludeFromCodex => $composableBuilder(
      column: $table.excludeFromCodex, builder: (column) => column);

  GeneratedColumn<String> get vaultDate =>
      $composableBuilder(column: $table.vaultDate, builder: (column) => column);

  GeneratedColumn<bool> get vaulted =>
      $composableBuilder(column: $table.vaulted, builder: (column) => column);

  GeneratedColumn<String> get wikiaUrl =>
      $composableBuilder(column: $table.wikiaUrl, builder: (column) => column);

  GeneratedColumn<bool> get masterable => $composableBuilder(
      column: $table.masterable, builder: (column) => column);
}

class $$ArsenalItemTableTableManager extends RootTableManager<
    _$ArsenalDatabase,
    $ArsenalItemTable,
    MinimalItem,
    $$ArsenalItemTableFilterComposer,
    $$ArsenalItemTableOrderingComposer,
    $$ArsenalItemTableAnnotationComposer,
    $$ArsenalItemTableCreateCompanionBuilder,
    $$ArsenalItemTableUpdateCompanionBuilder,
    (
      MinimalItem,
      BaseReferences<_$ArsenalDatabase, $ArsenalItemTable, MinimalItem>
    ),
    MinimalItem,
    PrefetchHooks Function()> {
  $$ArsenalItemTableTableManager(_$ArsenalDatabase db, $ArsenalItemTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArsenalItemTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArsenalItemTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArsenalItemTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uniqueName = const Value.absent(),
            Value<String> name = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<String?> imageName = const Value.absent(),
            Value<ItemType> type = const Value.absent(),
            Value<String?> productCategory = const Value.absent(),
            Value<String> category = const Value.absent(),
            Value<bool> tradable = const Value.absent(),
            Value<bool?> excludeFromCodex = const Value.absent(),
            Value<String?> vaultDate = const Value.absent(),
            Value<bool?> vaulted = const Value.absent(),
            Value<String?> wikiaUrl = const Value.absent(),
            Value<bool?> masterable = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArsenalItemCompanion(
            uniqueName: uniqueName,
            name: name,
            description: description,
            imageName: imageName,
            type: type,
            productCategory: productCategory,
            category: category,
            tradable: tradable,
            excludeFromCodex: excludeFromCodex,
            vaultDate: vaultDate,
            vaulted: vaulted,
            wikiaUrl: wikiaUrl,
            masterable: masterable,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uniqueName,
            required String name,
            Value<String?> description = const Value.absent(),
            Value<String?> imageName = const Value.absent(),
            required ItemType type,
            Value<String?> productCategory = const Value.absent(),
            required String category,
            required bool tradable,
            Value<bool?> excludeFromCodex = const Value.absent(),
            Value<String?> vaultDate = const Value.absent(),
            Value<bool?> vaulted = const Value.absent(),
            Value<String?> wikiaUrl = const Value.absent(),
            Value<bool?> masterable = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArsenalItemCompanion.insert(
            uniqueName: uniqueName,
            name: name,
            description: description,
            imageName: imageName,
            type: type,
            productCategory: productCategory,
            category: category,
            tradable: tradable,
            excludeFromCodex: excludeFromCodex,
            vaultDate: vaultDate,
            vaulted: vaulted,
            wikiaUrl: wikiaUrl,
            masterable: masterable,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArsenalItemTableProcessedTableManager = ProcessedTableManager<
    _$ArsenalDatabase,
    $ArsenalItemTable,
    MinimalItem,
    $$ArsenalItemTableFilterComposer,
    $$ArsenalItemTableOrderingComposer,
    $$ArsenalItemTableAnnotationComposer,
    $$ArsenalItemTableCreateCompanionBuilder,
    $$ArsenalItemTableUpdateCompanionBuilder,
    (
      MinimalItem,
      BaseReferences<_$ArsenalDatabase, $ArsenalItemTable, MinimalItem>
    ),
    MinimalItem,
    PrefetchHooks Function()>;
typedef $$ArsenalManifestTableCreateCompanionBuilder = ArsenalManifestCompanion
    Function({
  Value<int> id,
  required DateTime lastUpdate,
});
typedef $$ArsenalManifestTableUpdateCompanionBuilder = ArsenalManifestCompanion
    Function({
  Value<int> id,
  Value<DateTime> lastUpdate,
});

class $$ArsenalManifestTableFilterComposer
    extends Composer<_$ArsenalDatabase, $ArsenalManifestTable> {
  $$ArsenalManifestTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnFilters(column));
}

class $$ArsenalManifestTableOrderingComposer
    extends Composer<_$ArsenalDatabase, $ArsenalManifestTable> {
  $$ArsenalManifestTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => ColumnOrderings(column));
}

class $$ArsenalManifestTableAnnotationComposer
    extends Composer<_$ArsenalDatabase, $ArsenalManifestTable> {
  $$ArsenalManifestTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get lastUpdate => $composableBuilder(
      column: $table.lastUpdate, builder: (column) => column);
}

class $$ArsenalManifestTableTableManager extends RootTableManager<
    _$ArsenalDatabase,
    $ArsenalManifestTable,
    ArsenalManifestData,
    $$ArsenalManifestTableFilterComposer,
    $$ArsenalManifestTableOrderingComposer,
    $$ArsenalManifestTableAnnotationComposer,
    $$ArsenalManifestTableCreateCompanionBuilder,
    $$ArsenalManifestTableUpdateCompanionBuilder,
    (
      ArsenalManifestData,
      BaseReferences<_$ArsenalDatabase, $ArsenalManifestTable,
          ArsenalManifestData>
    ),
    ArsenalManifestData,
    PrefetchHooks Function()> {
  $$ArsenalManifestTableTableManager(
      _$ArsenalDatabase db, $ArsenalManifestTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArsenalManifestTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArsenalManifestTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArsenalManifestTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<DateTime> lastUpdate = const Value.absent(),
          }) =>
              ArsenalManifestCompanion(
            id: id,
            lastUpdate: lastUpdate,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required DateTime lastUpdate,
          }) =>
              ArsenalManifestCompanion.insert(
            id: id,
            lastUpdate: lastUpdate,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArsenalManifestTableProcessedTableManager = ProcessedTableManager<
    _$ArsenalDatabase,
    $ArsenalManifestTable,
    ArsenalManifestData,
    $$ArsenalManifestTableFilterComposer,
    $$ArsenalManifestTableOrderingComposer,
    $$ArsenalManifestTableAnnotationComposer,
    $$ArsenalManifestTableCreateCompanionBuilder,
    $$ArsenalManifestTableUpdateCompanionBuilder,
    (
      ArsenalManifestData,
      BaseReferences<_$ArsenalDatabase, $ArsenalManifestTable,
          ArsenalManifestData>
    ),
    ArsenalManifestData,
    PrefetchHooks Function()>;
typedef $$ArsenalItemXpTableCreateCompanionBuilder = ArsenalItemXpCompanion
    Function({
  required String uniqueName,
  required int xp,
  Value<int> rowid,
});
typedef $$ArsenalItemXpTableUpdateCompanionBuilder = ArsenalItemXpCompanion
    Function({
  Value<String> uniqueName,
  Value<int> xp,
  Value<int> rowid,
});

class $$ArsenalItemXpTableFilterComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemXpTable> {
  $$ArsenalItemXpTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnFilters(column));
}

class $$ArsenalItemXpTableOrderingComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemXpTable> {
  $$ArsenalItemXpTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get xp => $composableBuilder(
      column: $table.xp, builder: (column) => ColumnOrderings(column));
}

class $$ArsenalItemXpTableAnnotationComposer
    extends Composer<_$ArsenalDatabase, $ArsenalItemXpTable> {
  $$ArsenalItemXpTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get uniqueName => $composableBuilder(
      column: $table.uniqueName, builder: (column) => column);

  GeneratedColumn<int> get xp =>
      $composableBuilder(column: $table.xp, builder: (column) => column);
}

class $$ArsenalItemXpTableTableManager extends RootTableManager<
    _$ArsenalDatabase,
    $ArsenalItemXpTable,
    XpItem,
    $$ArsenalItemXpTableFilterComposer,
    $$ArsenalItemXpTableOrderingComposer,
    $$ArsenalItemXpTableAnnotationComposer,
    $$ArsenalItemXpTableCreateCompanionBuilder,
    $$ArsenalItemXpTableUpdateCompanionBuilder,
    (XpItem, BaseReferences<_$ArsenalDatabase, $ArsenalItemXpTable, XpItem>),
    XpItem,
    PrefetchHooks Function()> {
  $$ArsenalItemXpTableTableManager(
      _$ArsenalDatabase db, $ArsenalItemXpTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArsenalItemXpTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArsenalItemXpTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArsenalItemXpTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> uniqueName = const Value.absent(),
            Value<int> xp = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              ArsenalItemXpCompanion(
            uniqueName: uniqueName,
            xp: xp,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String uniqueName,
            required int xp,
            Value<int> rowid = const Value.absent(),
          }) =>
              ArsenalItemXpCompanion.insert(
            uniqueName: uniqueName,
            xp: xp,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$ArsenalItemXpTableProcessedTableManager = ProcessedTableManager<
    _$ArsenalDatabase,
    $ArsenalItemXpTable,
    XpItem,
    $$ArsenalItemXpTableFilterComposer,
    $$ArsenalItemXpTableOrderingComposer,
    $$ArsenalItemXpTableAnnotationComposer,
    $$ArsenalItemXpTableCreateCompanionBuilder,
    $$ArsenalItemXpTableUpdateCompanionBuilder,
    (XpItem, BaseReferences<_$ArsenalDatabase, $ArsenalItemXpTable, XpItem>),
    XpItem,
    PrefetchHooks Function()>;

class $ArsenalDatabaseManager {
  final _$ArsenalDatabase _db;
  $ArsenalDatabaseManager(this._db);
  $$ArsenalItemTableTableManager get arsenalItem =>
      $$ArsenalItemTableTableManager(_db, _db.arsenalItem);
  $$ArsenalManifestTableTableManager get arsenalManifest =>
      $$ArsenalManifestTableTableManager(_db, _db.arsenalManifest);
  $$ArsenalItemXpTableTableManager get arsenalItemXp =>
      $$ArsenalItemXpTableTableManager(_db, _db.arsenalItemXp);
}
