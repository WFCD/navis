import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

import 'mission.dart';

class SentientOutpost extends WorldstateObject {
  const SentientOutpost({
    String id,
    DateTime activation,
    DateTime expiry,
    this.mission,
    this.active,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
        );

  final Mission mission;
  final bool active;

  /// Shorthand for [Mission.node]
  String get node => mission.node;

  /// Shorthand for [Mission.type]
  String get type => mission.type;

  /// Shorthand for [Mission.faction]
  String get faction => mission.faction;

  @override
  List<Object> get props => super.props..addAll([mission, active]);
}
