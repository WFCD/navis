import 'package:codable/codable.dart';

class Alerts extends Coding {
  DateTime expiry;
  String activation, eta;
  bool active;
  _Mission mission;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    activation = object.decode('activation');
    expiry = DateTime.parse(object.decode('expiry'));
    eta = object.decode('eta');
    active = object.decode('active');
    mission = object.decodeObject('mission', () => _Mission());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('activation', activation);
    object.encode('expiry', expiry);
    object.encode('eta', eta);
    object.encode('active', active);
    object.encodeObject('mission', mission);
  }
}

class _Mission extends Coding {
  String node, type, faction;
  int minEnemyLevel, maxEnemyLevel, maxWaveNum;
  bool nightmare, archwingRequired;

  _AlertRewards reward;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    node = object.decode('node');
    type = object.decode('type');
    faction = object.decode('faction');
    minEnemyLevel = object.decode('minEnemyLevel');
    maxEnemyLevel = object.decode('maxEnemyLevel');
    nightmare = object.decode('nightmare');
    archwingRequired = object.decode('archwingRequired');
    reward = object.decodeObject('reward', () => _AlertRewards());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('node', node);
    object.encode('type', type);
    object.encode('faction', faction);
    object.encode('minEnemyLevel', minEnemyLevel);
    object.encode('maxEnemyLevel', maxEnemyLevel);
    object.encode('nightmare', nightmare);
    object.encode('archwingRequired', archwingRequired);
    object.encodeObject('reward', reward);
  }
}

class _AlertRewards extends Coding {
  String itemString, thumbnail, asString;
  int credits;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    itemString = object.decode('itemString');
    asString = object.decode('asString');
    credits = object.decode('credits');
    thumbnail = object.decode('thumbnail');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('itemString', itemString);
    object.encode('asString', asString);
    object.encode('credits', credits);
    object.encode('thumbnail', thumbnail);
  }
}
