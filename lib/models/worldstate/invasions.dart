import 'package:codable/codable.dart';

class Invasion extends Coding {
  String node, desc, attackingFaction, defendingFaction, activation, eta;
  bool vsInfestation, completed;
  num completion, count;

  _FactionReward attackerReward, defenderReward;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    node = object.decode('node');
    desc = object.decode('desc');
    attackingFaction = object.decode('attackingFaction');
    defendingFaction = object.decode('defendingFaction');
    activation = object.decode('activation');
    eta = object.decode('eta');

    attackerReward =
        object.decodeObject('attackerReward', () => _FactionReward());
    defenderReward =
        object.decodeObject('defenderReward', () => _FactionReward());

    vsInfestation = object.decode('vsInfestation');
    completed = object.decode('completed');

    completion = object.decode('completion');
    count = object.decode('count');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('node', node);
    object.encode('desc', desc);
    object.encode('attackingFaction', attackingFaction);
    object.encode('defendingFaction', defendingFaction);
    object.encode('activation', activation);
    object.encode('eta', eta);

    object.encodeObject('defenderReward', defenderReward);
    object.encodeObject('attackerReward', attackerReward);

    object.encode('vsInfestation', vsInfestation);
    object.encode('completed', completed);

    object.encode('completion', completion);
    object.encode('count', count);
  }
}

class _FactionReward extends Coding {
  String itemString, asString, thumbnail;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    itemString = object.decode('itemString');
    asString = object.decode('asString');
    thumbnail = object.decode('thumbnail');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('itemString', itemString);
    object.encode('asString', asString);
    object.encode('thumbnail', thumbnail);
  }
}
