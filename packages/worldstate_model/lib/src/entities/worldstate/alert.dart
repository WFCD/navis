import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

import 'mission.dart';

class Alert extends WorldstateObject {
  const Alert({
    String id,
    DateTime activation,
    DateTime expiry,
    this.active,
    this.mission,
  }) : super(id: id, activation: activation, expiry: expiry);

  final bool active;
  final Mission mission;

  /// shorthand for [Mission.node]
  String get node => mission.node;

  /// shorthand for [Mission.type]
  String get type => mission.type;

  /// shorthand for [Mission.faction]
  String get faction => mission.faction;

  /// shorthand for [Mission.nightmare]
  bool get isNightmare => mission.nightmare;

  /// shorthand for [Mission.archwingRequired]
  bool get archwingRequired => mission.archwingRequired;

  /// shorthand for [Mission.reward.itemString]
  String get missionReward => mission.reward.itemString;

  @override
  List<Object> get props => super.props..addAll([active, mission]);
}
