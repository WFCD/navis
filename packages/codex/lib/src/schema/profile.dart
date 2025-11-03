import 'package:codex/src/schema/masterable_item.dart';
import 'package:isar_community/isar.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'profile.g.dart';

const profileDefaultId = 1;

@Collection()
class PlayerProfile {
  PlayerProfile({
    required this.playerId,
    required this.username,
    required this.rank,
    required this.dailyStanding,
    required this.unlockedOperator,
  });

  final Id id = profileDefaultId;

  @Index(unique: true, replace: true)
  final String playerId;

  final String username;

  final int rank;

  final ProfileDailyStanding dailyStanding;

  final bool unlockedOperator;

  final xpInfo = IsarLinks<MasterableItem>();
}

@embedded
class ProfileDailyStanding {
  // ignore: prefer_constructors_over_static_methods Isar doesn't allow required parameters for embeds
  static ProfileDailyStanding fromRecord(DailyStanding standing) {
    return ProfileDailyStanding()
      ..cavia = standing.cavia
      ..conclave = standing.conclave
      ..daily = standing.daily
      ..entrati = standing.entrati
      ..holdfasts = standing.holdfasts
      ..kahl = standing.kahl
      ..necraloid = standing.necraloid
      ..ostron = standing.ostron
      ..quills = standing.quills
      ..simaris = standing.simaris
      ..solaris = standing.solaris
      ..ventKids = standing.ventKids
      ..voxSolaris = standing.voxSolaris;
  }

  late final int cavia;
  late final int conclave;
  late final int daily;
  late final int entrati;
  late final int holdfasts;
  late final int kahl;
  late final int necraloid;
  late final int ostron;
  late final int quills;
  late final int simaris;
  late final int solaris;
  late final int ventKids;
  late final int voxSolaris;
}
