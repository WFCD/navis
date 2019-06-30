import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/abstract_classes.dart';
import 'package:navis/models/worldstate/reward.dart';

class Alert extends WorldstateObject {
  bool active;
  _Mission mission;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    active = object.decode('active');
    mission = object.decodeObject('mission', () => _Mission());
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('active', active);
    object.encodeObject('mission', mission);
  }

  @override
  List get props => super.props..addAll([active, mission]);
}

class _Mission extends Coding with EquatableMixinBase, EquatableMixin {
  String node, type, faction;
  int minEnemyLevel, maxEnemyLevel, maxWaveNum;
  bool nightmare, archwingRequired;

  Reward reward;

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
    reward = object.decodeObject('reward', () => Reward());
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

  @override
  List get props => [
        node,
        type,
        faction,
        minEnemyLevel,
        maxEnemyLevel,
        nightmare,
        archwingRequired,
        reward
      ];
}
