import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';
import 'package:navis/models/worldstate/reward.dart';

import 'syndicate.dart';

class Event extends WorldstateObject {
  String faction,
      description,
      affiliatedWith,
      victimNode,
      health,
      node,
      tooltip;
  num currentScore, maximumScore;
  List<Reward> rewards;
  List<Jobs> jobs;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    faction = object.decode('faction');
    description = object.decode('description');
    affiliatedWith = object.decode('affiliatedWith');
    victimNode = object.decode('victimNode');
    health = object.decode('health');
    currentScore = object.decode('currentScore');
    maximumScore = object.decode('maximumScore');
    node = object.decode('node');
    tooltip = object.decode('tooltip');
    rewards = object.decodeObjects('rewards', () => Reward());
    jobs = object.decodeObjects('jobs', () => Jobs());
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('faction', faction);
    object.encode('description', description);
    object.encode('victimNode', victimNode);
    object.encode('health', health);
    object.encode('node', node);
    object.encode('tooltip', tooltip);
    object.encodeObjects('rewards', rewards);
    object.encodeObjects('jobs', jobs);
  }

  @override
  List get props => super.props
    ..addAll([
      faction,
      description,
      victimNode,
      health,
      node,
      tooltip,
      rewards,
      jobs
    ]);
}
