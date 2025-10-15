// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'codex_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetCodexItemCollection on Isar {
  IsarCollection<CodexItem> get codexItems => this.collection();
}

const CodexItemSchema = CollectionSchema(
  name: r'CodexItem',
  id: -2517223032965840712,
  properties: {
    r'category': PropertySchema(
      id: 0,
      name: r'category',
      type: IsarType.string,
    ),
    r'description': PropertySchema(
      id: 1,
      name: r'description',
      type: IsarType.string,
    ),
    r'hashCode': PropertySchema(id: 2, name: r'hashCode', type: IsarType.long),
    r'imageName': PropertySchema(
      id: 3,
      name: r'imageName',
      type: IsarType.string,
    ),
    r'masterable': PropertySchema(
      id: 4,
      name: r'masterable',
      type: IsarType.bool,
    ),
    r'maxLevelCap': PropertySchema(
      id: 5,
      name: r'maxLevelCap',
      type: IsarType.long,
    ),
    r'name': PropertySchema(id: 6, name: r'name', type: IsarType.string),
    r'type': PropertySchema(
      id: 7,
      name: r'type',
      type: IsarType.string,
      enumMap: _CodexItemtypeEnumValueMap,
    ),
    r'uniqueName': PropertySchema(
      id: 8,
      name: r'uniqueName',
      type: IsarType.string,
    ),
    r'vaulted': PropertySchema(id: 9, name: r'vaulted', type: IsarType.bool),
    r'wikiaThumbnail': PropertySchema(
      id: 10,
      name: r'wikiaThumbnail',
      type: IsarType.string,
    ),
    r'wikiaUrl': PropertySchema(
      id: 11,
      name: r'wikiaUrl',
      type: IsarType.string,
    ),
  },

  estimateSize: _codexItemEstimateSize,
  serialize: _codexItemSerialize,
  deserialize: _codexItemDeserialize,
  deserializeProp: _codexItemDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'uniqueName': IndexSchema(
      id: -3320518505807901263,
      name: r'uniqueName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uniqueName',
          type: IndexType.value,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'xpInfo': LinkSchema(
      id: -3820407482291262530,
      name: r'xpInfo',
      target: r'MasterableItem',
      single: true,
      linkName: r'item',
    ),
  },
  embeddedSchemas: {},

  getId: _codexItemGetId,
  getLinks: _codexItemGetLinks,
  attach: _codexItemAttach,
  version: '3.3.0-dev.3',
);

int _codexItemEstimateSize(
  CodexItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.category.length * 3;
  {
    final value = object.description;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.imageName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.type.name.length * 3;
  bytesCount += 3 + object.uniqueName.length * 3;
  {
    final value = object.wikiaThumbnail;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.wikiaUrl;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _codexItemSerialize(
  CodexItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.category);
  writer.writeString(offsets[1], object.description);
  writer.writeLong(offsets[2], object.hashCode);
  writer.writeString(offsets[3], object.imageName);
  writer.writeBool(offsets[4], object.masterable);
  writer.writeLong(offsets[5], object.maxLevelCap);
  writer.writeString(offsets[6], object.name);
  writer.writeString(offsets[7], object.type.name);
  writer.writeString(offsets[8], object.uniqueName);
  writer.writeBool(offsets[9], object.vaulted);
  writer.writeString(offsets[10], object.wikiaThumbnail);
  writer.writeString(offsets[11], object.wikiaUrl);
}

CodexItem _codexItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CodexItem(
    category: reader.readString(offsets[0]),
    description: reader.readStringOrNull(offsets[1]),
    imageName: reader.readStringOrNull(offsets[3]),
    masterable: reader.readBoolOrNull(offsets[4]) ?? false,
    maxLevelCap: reader.readLongOrNull(offsets[5]),
    name: reader.readString(offsets[6]),
    type:
        _CodexItemtypeValueEnumMap[reader.readStringOrNull(offsets[7])] ??
        ItemType.warframes,
    uniqueName: reader.readString(offsets[8]),
    vaulted: reader.readBoolOrNull(offsets[9]) ?? false,
    wikiaThumbnail: reader.readStringOrNull(offsets[10]),
    wikiaUrl: reader.readStringOrNull(offsets[11]),
  );
  return object;
}

P _codexItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readLongOrNull(offset)) as P;
    case 6:
      return (reader.readString(offset)) as P;
    case 7:
      return (_CodexItemtypeValueEnumMap[reader.readStringOrNull(offset)] ??
              ItemType.warframes)
          as P;
    case 8:
      return (reader.readString(offset)) as P;
    case 9:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 10:
      return (reader.readStringOrNull(offset)) as P;
    case 11:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _CodexItemtypeEnumValueMap = {
  r'warframes': r'warframes',
  r'melee': r'melee',
  r'archMelee': r'archMelee',
  r'archGun': r'archGun',
  r'resources': r'resources',
  r'skin': r'skin',
  r'gear': r'gear',
  r'arcanes': r'arcanes',
  r'archwing': r'archwing',
  r'fish': r'fish',
  r'glyph': r'glyph',
  r'misc': r'misc',
  r'node': r'node',
  r'quests': r'quests',
  r'relics': r'relics',
  r'petResource': r'petResource',
  r'sigils': r'sigils',
  r'pets': r'pets',
  r'sentinels': r'sentinels',
  r'necramechMod': r'necramechMod',
  r'primaryMod': r'primaryMod',
  r'secondaryMod': r'secondaryMod',
  r'warframeMod': r'warframeMod',
  r'shotGunMod': r'shotGunMod',
  r'companionMod': r'companionMod',
  r'archwingMod': r'archwingMod',
  r'archMeleeMod': r'archMeleeMod',
  r'archGunMod': r'archGunMod',
  r'stanceMod': r'stanceMod',
  r'parazonMod': r'parazonMod',
  r'kDriveMod': r'kDriveMod',
  r'meleeMod': r'meleeMod',
  r'peculiarMod': r'peculiarMod',
  r'companionWeaponRiven': r'companionWeaponRiven',
  r'archGunRiven': r'archGunRiven',
  r'rifleRiven': r'rifleRiven',
  r'pistolRiven': r'pistolRiven',
  r'shotgunRiven': r'shotgunRiven',
  r'meleeRiven': r'meleeRiven',
  r'kitgunRiven': r'kitgunRiven',
  r'zawRiven': r'zawRiven',
  r'rivenMod': r'rivenMod',
  r'shotgun': r'shotgun',
  r'rifle': r'rifle',
  r'pistol': r'pistol',
  r'companionWeapon': r'companionWeapon',
  r'dualPistols': r'dualPistols',
  r'throwing': r'throwing',
  r'amp': r'amp',
  r'kDriveComponent': r'kDriveComponent',
  r'zawComponent': r'zawComponent',
  r'kitGunComponent': r'kitGunComponent',
};
const _CodexItemtypeValueEnumMap = {
  r'warframes': ItemType.warframes,
  r'melee': ItemType.melee,
  r'archMelee': ItemType.archMelee,
  r'archGun': ItemType.archGun,
  r'resources': ItemType.resources,
  r'skin': ItemType.skin,
  r'gear': ItemType.gear,
  r'arcanes': ItemType.arcanes,
  r'archwing': ItemType.archwing,
  r'fish': ItemType.fish,
  r'glyph': ItemType.glyph,
  r'misc': ItemType.misc,
  r'node': ItemType.node,
  r'quests': ItemType.quests,
  r'relics': ItemType.relics,
  r'petResource': ItemType.petResource,
  r'sigils': ItemType.sigils,
  r'pets': ItemType.pets,
  r'sentinels': ItemType.sentinels,
  r'necramechMod': ItemType.necramechMod,
  r'primaryMod': ItemType.primaryMod,
  r'secondaryMod': ItemType.secondaryMod,
  r'warframeMod': ItemType.warframeMod,
  r'shotGunMod': ItemType.shotGunMod,
  r'companionMod': ItemType.companionMod,
  r'archwingMod': ItemType.archwingMod,
  r'archMeleeMod': ItemType.archMeleeMod,
  r'archGunMod': ItemType.archGunMod,
  r'stanceMod': ItemType.stanceMod,
  r'parazonMod': ItemType.parazonMod,
  r'kDriveMod': ItemType.kDriveMod,
  r'meleeMod': ItemType.meleeMod,
  r'peculiarMod': ItemType.peculiarMod,
  r'companionWeaponRiven': ItemType.companionWeaponRiven,
  r'archGunRiven': ItemType.archGunRiven,
  r'rifleRiven': ItemType.rifleRiven,
  r'pistolRiven': ItemType.pistolRiven,
  r'shotgunRiven': ItemType.shotgunRiven,
  r'meleeRiven': ItemType.meleeRiven,
  r'kitgunRiven': ItemType.kitgunRiven,
  r'zawRiven': ItemType.zawRiven,
  r'rivenMod': ItemType.rivenMod,
  r'shotgun': ItemType.shotgun,
  r'rifle': ItemType.rifle,
  r'pistol': ItemType.pistol,
  r'companionWeapon': ItemType.companionWeapon,
  r'dualPistols': ItemType.dualPistols,
  r'throwing': ItemType.throwing,
  r'amp': ItemType.amp,
  r'kDriveComponent': ItemType.kDriveComponent,
  r'zawComponent': ItemType.zawComponent,
  r'kitGunComponent': ItemType.kitGunComponent,
};

Id _codexItemGetId(CodexItem object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _codexItemGetLinks(CodexItem object) {
  return [object.xpInfo];
}

void _codexItemAttach(IsarCollection<dynamic> col, Id id, CodexItem object) {
  object.xpInfo.attach(
    col,
    col.isar.collection<MasterableItem>(),
    r'xpInfo',
    id,
  );
}

extension CodexItemByIndex on IsarCollection<CodexItem> {
  Future<CodexItem?> getByUniqueName(String uniqueName) {
    return getByIndex(r'uniqueName', [uniqueName]);
  }

  CodexItem? getByUniqueNameSync(String uniqueName) {
    return getByIndexSync(r'uniqueName', [uniqueName]);
  }

  Future<bool> deleteByUniqueName(String uniqueName) {
    return deleteByIndex(r'uniqueName', [uniqueName]);
  }

  bool deleteByUniqueNameSync(String uniqueName) {
    return deleteByIndexSync(r'uniqueName', [uniqueName]);
  }

  Future<List<CodexItem?>> getAllByUniqueName(List<String> uniqueNameValues) {
    final values = uniqueNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'uniqueName', values);
  }

  List<CodexItem?> getAllByUniqueNameSync(List<String> uniqueNameValues) {
    final values = uniqueNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uniqueName', values);
  }

  Future<int> deleteAllByUniqueName(List<String> uniqueNameValues) {
    final values = uniqueNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uniqueName', values);
  }

  int deleteAllByUniqueNameSync(List<String> uniqueNameValues) {
    final values = uniqueNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uniqueName', values);
  }

  Future<Id> putByUniqueName(CodexItem object) {
    return putByIndex(r'uniqueName', object);
  }

  Id putByUniqueNameSync(CodexItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'uniqueName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUniqueName(List<CodexItem> objects) {
    return putAllByIndex(r'uniqueName', objects);
  }

  List<Id> putAllByUniqueNameSync(
    List<CodexItem> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'uniqueName', objects, saveLinks: saveLinks);
  }
}

extension CodexItemQueryWhereSort
    on QueryBuilder<CodexItem, CodexItem, QWhere> {
  QueryBuilder<CodexItem, CodexItem, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhere> anyUniqueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'uniqueName'),
      );
    });
  }
}

extension CodexItemQueryWhere
    on QueryBuilder<CodexItem, CodexItem, QWhereClause> {
  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> isarIdNotEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> isarIdGreaterThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> isarIdLessThan(
    Id isarId, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerIsarId,
          includeLower: includeLower,
          upper: upperIsarId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameEqualTo(
    String uniqueName,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uniqueName', value: [uniqueName]),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameNotEqualTo(
    String uniqueName,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqueName',
                lower: [],
                upper: [uniqueName],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqueName',
                lower: [uniqueName],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqueName',
                lower: [uniqueName],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'uniqueName',
                lower: [],
                upper: [uniqueName],
                includeUpper: false,
              ),
            );
      }
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameGreaterThan(
    String uniqueName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uniqueName',
          lower: [uniqueName],
          includeLower: include,
          upper: [],
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameLessThan(
    String uniqueName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uniqueName',
          lower: [],
          upper: [uniqueName],
          includeUpper: include,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameBetween(
    String lowerUniqueName,
    String upperUniqueName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uniqueName',
          lower: [lowerUniqueName],
          includeLower: includeLower,
          upper: [upperUniqueName],
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameStartsWith(
    String UniqueNamePrefix,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.between(
          indexName: r'uniqueName',
          lower: [UniqueNamePrefix],
          upper: ['$UniqueNamePrefix\u{FFFFF}'],
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uniqueName', value: ['']),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterWhereClause> uniqueNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'uniqueName', upper: ['']),
            )
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'uniqueName',
                lower: [''],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.greaterThan(
                indexName: r'uniqueName',
                lower: [''],
              ),
            )
            .addWhereClause(
              IndexWhereClause.lessThan(indexName: r'uniqueName', upper: ['']),
            );
      }
    });
  }
}

extension CodexItemQueryFilter
    on QueryBuilder<CodexItem, CodexItem, QFilterCondition> {
  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'category',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'category',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'category',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> categoryIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  categoryIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'category', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'description'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'description'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'description',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'description',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> descriptionMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'description',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'description', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> hashCodeEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'hashCode', value: value),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> hashCodeGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'hashCode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> hashCodeLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'hashCode',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> hashCodeBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'hashCode',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'imageName'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  imageNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'imageName'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  imageNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'imageName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'imageName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'imageName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> imageNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'imageName', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  imageNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'imageName', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> isarIdEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'isarId',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'isarId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> masterableEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'masterable', value: value),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  maxLevelCapIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'maxLevelCap'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  maxLevelCapIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'maxLevelCap'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> maxLevelCapEqualTo(
    int? value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'maxLevelCap', value: value),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  maxLevelCapGreaterThan(int? value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'maxLevelCap',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> maxLevelCapLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'maxLevelCap',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> maxLevelCapBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'maxLevelCap',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'name',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'name',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'name',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'name', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeEqualTo(
    ItemType value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeGreaterThan(
    ItemType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeLessThan(
    ItemType value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeBetween(
    ItemType lower,
    ItemType upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'type',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'type',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'type',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> typeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'type', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  uniqueNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'uniqueName',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  uniqueNameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'uniqueName',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> uniqueNameMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'uniqueName',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  uniqueNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uniqueName', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  uniqueNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uniqueName', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> vaultedEqualTo(
    bool value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'vaulted', value: value),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'wikiaThumbnail'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'wikiaThumbnail'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailEqualTo(String? value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'wikiaThumbnail',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'wikiaThumbnail',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'wikiaThumbnail',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'wikiaThumbnail', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaThumbnailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'wikiaThumbnail', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNull(property: r'wikiaUrl'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaUrlIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const FilterCondition.isNotNull(property: r'wikiaUrl'),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'wikiaUrl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlContains(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'wikiaUrl',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlMatches(
    String pattern, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'wikiaUrl',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> wikiaUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'wikiaUrl', value: ''),
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition>
  wikiaUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'wikiaUrl', value: ''),
      );
    });
  }
}

extension CodexItemQueryObject
    on QueryBuilder<CodexItem, CodexItem, QFilterCondition> {}

extension CodexItemQueryLinks
    on QueryBuilder<CodexItem, CodexItem, QFilterCondition> {
  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> xpInfo(
    FilterQuery<MasterableItem> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'xpInfo');
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterFilterCondition> xpInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', 0, true, 0, true);
    });
  }
}

extension CodexItemQuerySortBy on QueryBuilder<CodexItem, CodexItem, QSortBy> {
  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByMasterable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masterable', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByMasterableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masterable', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByMaxLevelCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLevelCap', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByMaxLevelCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLevelCap', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByUniqueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByUniqueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByVaulted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaulted', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByVaultedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaulted', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByWikiaThumbnail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaThumbnail', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByWikiaThumbnailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaThumbnail', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByWikiaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaUrl', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> sortByWikiaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaUrl', Sort.desc);
    });
  }
}

extension CodexItemQuerySortThenBy
    on QueryBuilder<CodexItem, CodexItem, QSortThenBy> {
  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByCategory() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByCategoryDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'category', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByHashCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hashCode', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByImageName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByImageNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imageName', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByMasterable() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masterable', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByMasterableDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'masterable', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByMaxLevelCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLevelCap', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByMaxLevelCapDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxLevelCap', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'type', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByUniqueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByUniqueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByVaulted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaulted', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByVaultedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'vaulted', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByWikiaThumbnail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaThumbnail', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByWikiaThumbnailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaThumbnail', Sort.desc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByWikiaUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaUrl', Sort.asc);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QAfterSortBy> thenByWikiaUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'wikiaUrl', Sort.desc);
    });
  }
}

extension CodexItemQueryWhereDistinct
    on QueryBuilder<CodexItem, CodexItem, QDistinct> {
  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByCategory({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'category', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByDescription({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByHashCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hashCode');
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByImageName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imageName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByMasterable() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'masterable');
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByMaxLevelCap() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxLevelCap');
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByType({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'type', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByUniqueName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uniqueName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByVaulted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'vaulted');
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByWikiaThumbnail({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(
        r'wikiaThumbnail',
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<CodexItem, CodexItem, QDistinct> distinctByWikiaUrl({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'wikiaUrl', caseSensitive: caseSensitive);
    });
  }
}

extension CodexItemQueryProperty
    on QueryBuilder<CodexItem, CodexItem, QQueryProperty> {
  QueryBuilder<CodexItem, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<CodexItem, String, QQueryOperations> categoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'category');
    });
  }

  QueryBuilder<CodexItem, String?, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<CodexItem, int, QQueryOperations> hashCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hashCode');
    });
  }

  QueryBuilder<CodexItem, String?, QQueryOperations> imageNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imageName');
    });
  }

  QueryBuilder<CodexItem, bool, QQueryOperations> masterableProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'masterable');
    });
  }

  QueryBuilder<CodexItem, int?, QQueryOperations> maxLevelCapProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxLevelCap');
    });
  }

  QueryBuilder<CodexItem, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<CodexItem, ItemType, QQueryOperations> typeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'type');
    });
  }

  QueryBuilder<CodexItem, String, QQueryOperations> uniqueNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uniqueName');
    });
  }

  QueryBuilder<CodexItem, bool, QQueryOperations> vaultedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'vaulted');
    });
  }

  QueryBuilder<CodexItem, String?, QQueryOperations> wikiaThumbnailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wikiaThumbnail');
    });
  }

  QueryBuilder<CodexItem, String?, QQueryOperations> wikiaUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'wikiaUrl');
    });
  }
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CodexItem _$CodexItemFromJson(Map<String, dynamic> json) => CodexItem(
  uniqueName: json['uniqueName'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  imageName: json['imageName'] as String?,
  category: json['category'] as String,
  type: const ItemTypeConverter().fromJson(json['type'] as String),
  vaulted: json['vaulted'] as bool? ?? false,
  masterable: json['masterable'] as bool? ?? false,
  maxLevelCap: (json['maxLevelCap'] as num?)?.toInt(),
  wikiaUrl: json['wikiaUrl'] as String?,
  wikiaThumbnail: json['wikiaThumbnail'] as String?,
);

Map<String, dynamic> _$CodexItemToJson(CodexItem instance) => <String, dynamic>{
  'uniqueName': instance.uniqueName,
  'name': instance.name,
  'description': instance.description,
  'imageName': instance.imageName,
  'category': instance.category,
  'vaulted': instance.vaulted,
  'masterable': instance.masterable,
  'maxLevelCap': instance.maxLevelCap,
  'wikiaUrl': instance.wikiaUrl,
  'wikiaThumbnail': instance.wikiaThumbnail,
  'type': const ItemTypeConverter().toJson(instance.type),
};
