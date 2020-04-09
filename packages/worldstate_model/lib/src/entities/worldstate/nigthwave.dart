import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class Nightwave extends WorldstateObject {
  const Nightwave({
    String id,
    DateTime activation,
    DateTime expiry,
    this.startString,
    this.tag,
    this.active,
    this.season,
    this.phase,
    this.possibleChallenges,
    this.activeChallenges,
    this.rewardTypes,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String startString, tag;
  final bool active;
  final num season, phase;

  final List<Challenge> possibleChallenges, activeChallenges;
  final List<String> rewardTypes;

  /// Filters [activeChallenges] and exports only daily challenges
  List<Challenge> get daily {
    return activeChallenges.where((c) => c.isDaily ?? false).toList()
      ..sort((a, b) => a.expiry.compareTo(b.expiry));
  }

  /// Filters [activeChallenges] and exports only weekly challenges
  List<Challenge> get weekly {
    return activeChallenges.where((c) => c.isDaily == null).toList()
      ..sort((a, b) {
        if (a.isElite ?? false) {
          return 0;
        } else {
          return 1;
        }
      });
  }

  @override
  List<Object> get props {
    return super.props
      ..addAll([
        startString,
        tag,
        active,
        season,
        phase,
        possibleChallenges,
        activeChallenges,
        rewardTypes,
      ]);
  }
}

class Challenge extends WorldstateObject {
  const Challenge({
    String id,
    DateTime activation,
    DateTime expiry,
    this.title,
    this.desc,
    this.active,
    this.isDaily,
    this.isElite,
    this.reputation,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String title, desc;
  final bool active, isDaily, isElite;
  final int reputation;

  @override
  List<Object> get props {
    return super.props
      ..addAll([title, desc, active, isDaily, isElite, reputation]);
  }
}
