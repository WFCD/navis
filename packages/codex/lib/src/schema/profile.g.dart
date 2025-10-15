// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayerProfileCollection on Isar {
  IsarCollection<PlayerProfile> get playerProfiles => this.collection();
}

const PlayerProfileSchema = CollectionSchema(
  name: r'PlayerProfile',
  id: -7715882953709164590,
  properties: {
    r'dailyStanding': PropertySchema(
      id: 0,
      name: r'dailyStanding',
      type: IsarType.object,

      target: r'ProfileDailyStanding',
    ),
    r'playerId': PropertySchema(
      id: 1,
      name: r'playerId',
      type: IsarType.string,
    ),
    r'rank': PropertySchema(id: 2, name: r'rank', type: IsarType.long),
    r'unlockedOperator': PropertySchema(
      id: 3,
      name: r'unlockedOperator',
      type: IsarType.bool,
    ),
    r'username': PropertySchema(
      id: 4,
      name: r'username',
      type: IsarType.string,
    ),
  },

  estimateSize: _playerProfileEstimateSize,
  serialize: _playerProfileSerialize,
  deserialize: _playerProfileDeserialize,
  deserializeProp: _playerProfileDeserializeProp,
  idName: r'id',
  indexes: {
    r'playerId': IndexSchema(
      id: 8338580293383144444,
      name: r'playerId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'playerId',
          type: IndexType.hash,
          caseSensitive: true,
        ),
      ],
    ),
  },
  links: {
    r'xpInfo': LinkSchema(
      id: 8694866685816258139,
      name: r'xpInfo',
      target: r'MasterableItem',
      single: false,
    ),
  },
  embeddedSchemas: {r'ProfileDailyStanding': ProfileDailyStandingSchema},

  getId: _playerProfileGetId,
  getLinks: _playerProfileGetLinks,
  attach: _playerProfileAttach,
  version: '3.3.0-dev.3',
);

int _playerProfileEstimateSize(
  PlayerProfile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount +=
      3 +
      ProfileDailyStandingSchema.estimateSize(
        object.dailyStanding,
        allOffsets[ProfileDailyStanding]!,
        allOffsets,
      );
  bytesCount += 3 + object.playerId.length * 3;
  bytesCount += 3 + object.username.length * 3;
  return bytesCount;
}

void _playerProfileSerialize(
  PlayerProfile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<ProfileDailyStanding>(
    offsets[0],
    allOffsets,
    ProfileDailyStandingSchema.serialize,
    object.dailyStanding,
  );
  writer.writeString(offsets[1], object.playerId);
  writer.writeLong(offsets[2], object.rank);
  writer.writeBool(offsets[3], object.unlockedOperator);
  writer.writeString(offsets[4], object.username);
}

PlayerProfile _playerProfileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PlayerProfile(
    dailyStanding:
        reader.readObjectOrNull<ProfileDailyStanding>(
          offsets[0],
          ProfileDailyStandingSchema.deserialize,
          allOffsets,
        ) ??
        ProfileDailyStanding(),
    playerId: reader.readString(offsets[1]),
    rank: reader.readLong(offsets[2]),
    unlockedOperator: reader.readBool(offsets[3]),
    username: reader.readString(offsets[4]),
  );
  return object;
}

P _playerProfileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<ProfileDailyStanding>(
                offset,
                ProfileDailyStandingSchema.deserialize,
                allOffsets,
              ) ??
              ProfileDailyStanding())
          as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playerProfileGetId(PlayerProfile object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _playerProfileGetLinks(PlayerProfile object) {
  return [object.xpInfo];
}

void _playerProfileAttach(
  IsarCollection<dynamic> col,
  Id id,
  PlayerProfile object,
) {
  object.xpInfo.attach(
    col,
    col.isar.collection<MasterableItem>(),
    r'xpInfo',
    id,
  );
}

extension PlayerProfileByIndex on IsarCollection<PlayerProfile> {
  Future<PlayerProfile?> getByPlayerId(String playerId) {
    return getByIndex(r'playerId', [playerId]);
  }

  PlayerProfile? getByPlayerIdSync(String playerId) {
    return getByIndexSync(r'playerId', [playerId]);
  }

  Future<bool> deleteByPlayerId(String playerId) {
    return deleteByIndex(r'playerId', [playerId]);
  }

  bool deleteByPlayerIdSync(String playerId) {
    return deleteByIndexSync(r'playerId', [playerId]);
  }

  Future<List<PlayerProfile?>> getAllByPlayerId(List<String> playerIdValues) {
    final values = playerIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'playerId', values);
  }

  List<PlayerProfile?> getAllByPlayerIdSync(List<String> playerIdValues) {
    final values = playerIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'playerId', values);
  }

  Future<int> deleteAllByPlayerId(List<String> playerIdValues) {
    final values = playerIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'playerId', values);
  }

  int deleteAllByPlayerIdSync(List<String> playerIdValues) {
    final values = playerIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'playerId', values);
  }

  Future<Id> putByPlayerId(PlayerProfile object) {
    return putByIndex(r'playerId', object);
  }

  Id putByPlayerIdSync(PlayerProfile object, {bool saveLinks = true}) {
    return putByIndexSync(r'playerId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByPlayerId(List<PlayerProfile> objects) {
    return putAllByIndex(r'playerId', objects);
  }

  List<Id> putAllByPlayerIdSync(
    List<PlayerProfile> objects, {
    bool saveLinks = true,
  }) {
    return putAllByIndexSync(r'playerId', objects, saveLinks: saveLinks);
  }
}

extension PlayerProfileQueryWhereSort
    on QueryBuilder<PlayerProfile, PlayerProfile, QWhere> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension PlayerProfileQueryWhere
    on QueryBuilder<PlayerProfile, PlayerProfile, QWhereClause> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> idEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(lower: id, upper: id));
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> idNotEqualTo(
    Id id,
  ) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> idGreaterThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> idLessThan(
    Id id, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.between(
          lower: lowerId,
          includeLower: includeLower,
          upper: upperId,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause> playerIdEqualTo(
    String playerId,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IndexWhereClause.equalTo(indexName: r'playerId', value: [playerId]),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterWhereClause>
  playerIdNotEqualTo(String playerId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'playerId',
                lower: [],
                upper: [playerId],
                includeUpper: false,
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'playerId',
                lower: [playerId],
                includeLower: false,
                upper: [],
              ),
            );
      } else {
        return query
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'playerId',
                lower: [playerId],
                includeLower: false,
                upper: [],
              ),
            )
            .addWhereClause(
              IndexWhereClause.between(
                indexName: r'playerId',
                lower: [],
                upper: [playerId],
                includeUpper: false,
              ),
            );
      }
    });
  }
}

extension PlayerProfileQueryFilter
    on QueryBuilder<PlayerProfile, PlayerProfile, QFilterCondition> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> idEqualTo(
    Id value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'id', value: value),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  idGreaterThan(Id value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'id',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'id',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'playerId',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'playerId',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'playerId',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'playerId', value: ''),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  playerIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'playerId', value: ''),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> rankEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'rank', value: value),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  rankGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'rank',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  rankLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'rank',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> rankBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'rank',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  unlockedOperatorEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'unlockedOperator', value: value),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameEqualTo(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'username',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameStartsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.startsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameEndsWith(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.endsWith(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.contains(
          property: r'username',
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.matches(
          property: r'username',
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'username', value: ''),
      );
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  usernameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(property: r'username', value: ''),
      );
    });
  }
}

extension PlayerProfileQueryObject
    on QueryBuilder<PlayerProfile, PlayerProfile, QFilterCondition> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  dailyStanding(FilterQuery<ProfileDailyStanding> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'dailyStanding');
    });
  }
}

extension PlayerProfileQueryLinks
    on QueryBuilder<PlayerProfile, PlayerProfile, QFilterCondition> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition> xpInfo(
    FilterQuery<MasterableItem> q,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.link(q, r'xpInfo');
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', length, true, length, true);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', 0, true, 0, true);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', 0, false, 999999, true);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoLengthLessThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', 0, true, length, include);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoLengthGreaterThan(int length, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(r'xpInfo', length, include, 999999, true);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterFilterCondition>
  xpInfoLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.linkLength(
        r'xpInfo',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension PlayerProfileQuerySortBy
    on QueryBuilder<PlayerProfile, PlayerProfile, QSortBy> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> sortByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  sortByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> sortByRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> sortByRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  sortByUnlockedOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedOperator', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  sortByUnlockedOperatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedOperator', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> sortByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  sortByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension PlayerProfileQuerySortThenBy
    on QueryBuilder<PlayerProfile, PlayerProfile, QSortThenBy> {
  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenByPlayerId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  thenByPlayerIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'playerId', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenByRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenByRankDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'rank', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  thenByUnlockedOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedOperator', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  thenByUnlockedOperatorDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'unlockedOperator', Sort.desc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy> thenByUsername() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.asc);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QAfterSortBy>
  thenByUsernameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'username', Sort.desc);
    });
  }
}

extension PlayerProfileQueryWhereDistinct
    on QueryBuilder<PlayerProfile, PlayerProfile, QDistinct> {
  QueryBuilder<PlayerProfile, PlayerProfile, QDistinct> distinctByPlayerId({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'playerId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QDistinct> distinctByRank() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'rank');
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QDistinct>
  distinctByUnlockedOperator() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'unlockedOperator');
    });
  }

  QueryBuilder<PlayerProfile, PlayerProfile, QDistinct> distinctByUsername({
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'username', caseSensitive: caseSensitive);
    });
  }
}

extension PlayerProfileQueryProperty
    on QueryBuilder<PlayerProfile, PlayerProfile, QQueryProperty> {
  QueryBuilder<PlayerProfile, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PlayerProfile, ProfileDailyStanding, QQueryOperations>
  dailyStandingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyStanding');
    });
  }

  QueryBuilder<PlayerProfile, String, QQueryOperations> playerIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'playerId');
    });
  }

  QueryBuilder<PlayerProfile, int, QQueryOperations> rankProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'rank');
    });
  }

  QueryBuilder<PlayerProfile, bool, QQueryOperations>
  unlockedOperatorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'unlockedOperator');
    });
  }

  QueryBuilder<PlayerProfile, String, QQueryOperations> usernameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'username');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ProfileDailyStandingSchema = Schema(
  name: r'ProfileDailyStanding',
  id: -846512497143385139,
  properties: {
    r'cavia': PropertySchema(id: 0, name: r'cavia', type: IsarType.long),
    r'conclave': PropertySchema(id: 1, name: r'conclave', type: IsarType.long),
    r'daily': PropertySchema(id: 2, name: r'daily', type: IsarType.long),
    r'entrati': PropertySchema(id: 3, name: r'entrati', type: IsarType.long),
    r'holdfasts': PropertySchema(
      id: 4,
      name: r'holdfasts',
      type: IsarType.long,
    ),
    r'kahl': PropertySchema(id: 5, name: r'kahl', type: IsarType.long),
    r'necraloid': PropertySchema(
      id: 6,
      name: r'necraloid',
      type: IsarType.long,
    ),
    r'ostron': PropertySchema(id: 7, name: r'ostron', type: IsarType.long),
    r'quills': PropertySchema(id: 8, name: r'quills', type: IsarType.long),
    r'simaris': PropertySchema(id: 9, name: r'simaris', type: IsarType.long),
    r'solaris': PropertySchema(id: 10, name: r'solaris', type: IsarType.long),
    r'ventKids': PropertySchema(id: 11, name: r'ventKids', type: IsarType.long),
    r'voxSolaris': PropertySchema(
      id: 12,
      name: r'voxSolaris',
      type: IsarType.long,
    ),
  },

  estimateSize: _profileDailyStandingEstimateSize,
  serialize: _profileDailyStandingSerialize,
  deserialize: _profileDailyStandingDeserialize,
  deserializeProp: _profileDailyStandingDeserializeProp,
);

int _profileDailyStandingEstimateSize(
  ProfileDailyStanding object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _profileDailyStandingSerialize(
  ProfileDailyStanding object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.cavia);
  writer.writeLong(offsets[1], object.conclave);
  writer.writeLong(offsets[2], object.daily);
  writer.writeLong(offsets[3], object.entrati);
  writer.writeLong(offsets[4], object.holdfasts);
  writer.writeLong(offsets[5], object.kahl);
  writer.writeLong(offsets[6], object.necraloid);
  writer.writeLong(offsets[7], object.ostron);
  writer.writeLong(offsets[8], object.quills);
  writer.writeLong(offsets[9], object.simaris);
  writer.writeLong(offsets[10], object.solaris);
  writer.writeLong(offsets[11], object.ventKids);
  writer.writeLong(offsets[12], object.voxSolaris);
}

ProfileDailyStanding _profileDailyStandingDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ProfileDailyStanding();
  object.cavia = reader.readLong(offsets[0]);
  object.conclave = reader.readLong(offsets[1]);
  object.daily = reader.readLong(offsets[2]);
  object.entrati = reader.readLong(offsets[3]);
  object.holdfasts = reader.readLong(offsets[4]);
  object.kahl = reader.readLong(offsets[5]);
  object.necraloid = reader.readLong(offsets[6]);
  object.ostron = reader.readLong(offsets[7]);
  object.quills = reader.readLong(offsets[8]);
  object.simaris = reader.readLong(offsets[9]);
  object.solaris = reader.readLong(offsets[10]);
  object.ventKids = reader.readLong(offsets[11]);
  object.voxSolaris = reader.readLong(offsets[12]);
  return object;
}

P _profileDailyStandingDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLong(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    case 4:
      return (reader.readLong(offset)) as P;
    case 5:
      return (reader.readLong(offset)) as P;
    case 6:
      return (reader.readLong(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readLong(offset)) as P;
    case 9:
      return (reader.readLong(offset)) as P;
    case 10:
      return (reader.readLong(offset)) as P;
    case 11:
      return (reader.readLong(offset)) as P;
    case 12:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ProfileDailyStandingQueryFilter
    on
        QueryBuilder<
          ProfileDailyStanding,
          ProfileDailyStanding,
          QFilterCondition
        > {
  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  caviaEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'cavia', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  caviaGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'cavia',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  caviaLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'cavia',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  caviaBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'cavia',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  conclaveEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'conclave', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  conclaveGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'conclave',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  conclaveLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'conclave',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  conclaveBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'conclave',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  dailyEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'daily', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  dailyGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'daily',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  dailyLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'daily',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  dailyBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'daily',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  entratiEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'entrati', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  entratiGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'entrati',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  entratiLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'entrati',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  entratiBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'entrati',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  holdfastsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'holdfasts', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  holdfastsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'holdfasts',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  holdfastsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'holdfasts',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  holdfastsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'holdfasts',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  kahlEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'kahl', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  kahlGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'kahl',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  kahlLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'kahl',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  kahlBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'kahl',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  necraloidEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'necraloid', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  necraloidGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'necraloid',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  necraloidLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'necraloid',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  necraloidBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'necraloid',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ostronEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ostron', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ostronGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ostron',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ostronLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ostron',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ostronBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ostron',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  quillsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'quills', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  quillsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'quills',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  quillsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'quills',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  quillsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'quills',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  simarisEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'simaris', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  simarisGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'simaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  simarisLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'simaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  simarisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'simaris',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  solarisEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'solaris', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  solarisGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'solaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  solarisLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'solaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  solarisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'solaris',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ventKidsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'ventKids', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ventKidsGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'ventKids',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ventKidsLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'ventKids',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  ventKidsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'ventKids',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  voxSolarisEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.equalTo(property: r'voxSolaris', value: value),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  voxSolarisGreaterThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.greaterThan(
          include: include,
          property: r'voxSolaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  voxSolarisLessThan(int value, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.lessThan(
          include: include,
          property: r'voxSolaris',
          value: value,
        ),
      );
    });
  }

  QueryBuilder<
    ProfileDailyStanding,
    ProfileDailyStanding,
    QAfterFilterCondition
  >
  voxSolarisBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        FilterCondition.between(
          property: r'voxSolaris',
          lower: lower,
          includeLower: includeLower,
          upper: upper,
          includeUpper: includeUpper,
        ),
      );
    });
  }
}

extension ProfileDailyStandingQueryObject
    on
        QueryBuilder<
          ProfileDailyStanding,
          ProfileDailyStanding,
          QFilterCondition
        > {}
