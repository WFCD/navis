// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'masterable_item.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetMasterableItemCollection on Isar {
  IsarCollection<MasterableItem> get masterableItems => this.collection();
}

const MasterableItemSchema = CollectionSchema(
  name: r'MasterableItem',
  id: -8075861551510048597,
  properties: {
    r'uniqueName': PropertySchema(
      id: 0,
      name: r'uniqueName',
      type: IsarType.string,
    ),
    r'xp': PropertySchema(id: 1, name: r'xp', type: IsarType.long),
  },

  estimateSize: _masterableItemEstimateSize,
  serialize: _masterableItemSerialize,
  deserialize: _masterableItemDeserialize,
  deserializeProp: _masterableItemDeserializeProp,
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
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'item': LinkSchema(
      id: -5632504519407698145,
      name: r'item',
      target: r'CodexItem',
      single: true,
    ),
  },
  embeddedSchemas: {},

  getId: _masterableItemGetId,
  getLinks: _masterableItemGetLinks,
  attach: _masterableItemAttach,
  version: '3.3.0',
);

int _masterableItemEstimateSize(
  MasterableItem object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.uniqueName.length * 3;
  return bytesCount;
}

void _masterableItemSerialize(
  MasterableItem object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.uniqueName);
  writer.writeLong(offsets[1], object.xp);
}

MasterableItem _masterableItemDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MasterableItem(
    uniqueName: reader.readString(offsets[0]),
    xp: reader.readLong(offsets[1]),
  );
  return object;
}

P _masterableItemDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _masterableItemGetId(MasterableItem object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _masterableItemGetLinks(MasterableItem object) {
  return [object.item];
}

void _masterableItemAttach(
  IsarCollection<dynamic> col,
  Id id,
  MasterableItem object,
) {
  object.item.attach(col, col.isar.collection<CodexItem>(), r'item', id);
}

extension MasterableItemByIndex on IsarCollection<MasterableItem> {
  Future<MasterableItem?> getByUniqueName(String uniqueName) {
    return getByIndex(r'uniqueName', [uniqueName]);
  }

  MasterableItem? getByUniqueNameSync(String uniqueName) {
    return getByIndexSync(r'uniqueName', [uniqueName]);
  }

  Future<bool> deleteByUniqueName(String uniqueName) {
    return deleteByIndex(r'uniqueName', [uniqueName]);
  }

  bool deleteByUniqueNameSync(String uniqueName) {
    return deleteByIndexSync(r'uniqueName', [uniqueName]);
  }

  Future<List<MasterableItem?>> getAllByUniqueName(
    List<String> uniqueNameValues,
  ) {
    final values = uniqueNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'uniqueName', values);
  }

  List<MasterableItem?> getAllByUniqueNameSync(List<String> uniqueNameValues) {
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

  Future<Id> putByUniqueName(MasterableItem object) {
    return putByIndex(r'uniqueName', object);
  }

  Id putByUniqueNameSync(MasterableItem object, {bool saveLinks = true}) {
    return putByIndexSync(r'uniqueName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUniqueName(List<MasterableItem> objects) {
    return putAllByIndex(r'uniqueName', objects);
  }

  List<Id> putAllByUniqueNameSync(
    List<MasterableItem> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'uniqueName', objects, saveLinks: saveLinks);
  }
}

extension MasterableItemQueryWhereSort
    on QueryBuilder<MasterableItem, MasterableItem, QWhere> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension MasterableItemQueryWhere
    on QueryBuilder<MasterableItem, MasterableItem, QWhereClause> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause> isarIdEqualTo(
    Id isarId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(lower: isarId, upper: isarId),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause>
  isarIdNotEqualTo(Id isarId) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause>
  isarIdGreaterThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause>
  isarIdLessThan(Id isarId, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause> isarIdBetween(
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause>
  uniqueNameEqualTo(String uniqueName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'uniqueName', value: [uniqueName]),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterWhereClause>
  uniqueNameNotEqualTo(String uniqueName) {
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
}

extension MasterableItemQueryFilter
    on QueryBuilder<MasterableItem, MasterableItem, QFilterCondition> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'isarId', value: value),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  isarIdGreaterThan(Id value, {bool include = false}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  isarIdLessThan(Id value, {bool include = false}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  isarIdBetween(
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameEqualTo(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameLessThan(
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameBetween(
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameEndsWith(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'uniqueName', value: ''),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  uniqueNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'uniqueName', value: ''),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition> xpEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'xp', value: value),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  xpGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'xp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  xpLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'xp',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition> xpBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'xp',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension MasterableItemQueryObject
    on QueryBuilder<MasterableItem, MasterableItem, QFilterCondition> {}

extension MasterableItemQueryLinks
    on QueryBuilder<MasterableItem, MasterableItem, QFilterCondition> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition> item(
    FilterQuery<CodexItem> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'item');
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterFilterCondition>
  itemIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'item', 0, true, 0, true);
    });
  }
}

extension MasterableItemQuerySortBy
    on QueryBuilder<MasterableItem, MasterableItem, QSortBy> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy>
  sortByUniqueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.asc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy>
  sortByUniqueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.desc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy> sortByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy> sortByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }
}

extension MasterableItemQuerySortThenBy
    on QueryBuilder<MasterableItem, MasterableItem, QSortThenBy> {
  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy>
  thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy>
  thenByUniqueName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.asc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy>
  thenByUniqueNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uniqueName', Sort.desc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy> thenByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QAfterSortBy> thenByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }
}

extension MasterableItemQueryWhereDistinct
    on QueryBuilder<MasterableItem, MasterableItem, QDistinct> {
  QueryBuilder<MasterableItem, MasterableItem, QDistinct> distinctByUniqueName({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uniqueName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<MasterableItem, MasterableItem, QDistinct> distinctByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xp');
    });
  }
}

extension MasterableItemQueryProperty
    on QueryBuilder<MasterableItem, MasterableItem, QQueryProperty> {
  QueryBuilder<MasterableItem, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<MasterableItem, String, QQueryOperations> uniqueNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uniqueName');
    });
  }

  QueryBuilder<MasterableItem, int, QQueryOperations> xpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xp');
    });
  }
}
