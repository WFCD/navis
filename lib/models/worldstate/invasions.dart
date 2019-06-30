import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';
import 'package:navis/models/worldstate/reward.dart';

class Invasion extends WorldstateObject {
  String node, desc, attackingFaction, defendingFaction, eta;
  bool vsInfestation, completed;
  num completion, count;

  Reward attackerReward, defenderReward;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    node = object.decode('node');
    desc = object.decode('desc');
    attackingFaction = object.decode('attackingFaction');
    defendingFaction = object.decode('defendingFaction');
    activation = object.decode('activation');
    eta = object.decode('eta');

    attackerReward = object.decodeObject('attackerReward', () => Reward());
    defenderReward = object.decodeObject('defenderReward', () => Reward());

    vsInfestation = object.decode('vsInfestation');
    completed = object.decode('completed');

    completion = object.decode('completion');
    count = object.decode('count');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
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
