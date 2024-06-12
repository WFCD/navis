import 'dart:math';

import 'package:collection/collection.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

int inventoryMastery(List<XpItem> inventory) {
  const defaultMaxRank = 30;
  const masteryPerRankWeapon = 100;
  const masteryPerRankWarframe = 200;
  const weapon = 500;
  const warframe = 1000;

  var mastery = 0;
  for (final item in inventory) {
    final i = item.item;
    if (i == null) {
      if (item.uniqueName.contains('Grim')) {
        mastery += min(defaultMaxRank, sqrt(item.xp / weapon).floor()) * 100;
      }

      if (item.uniqueName.contains('DefaultHarness')) {
        mastery += min(defaultMaxRank, sqrt(item.xp / warframe).floor()) * 200;
      }

      continue;
    }

    final isWeapon = i is Weapon;
    final maxLevel = isWeapon ? i.maxLevelCap : defaultMaxRank;
    final rank =
        min(maxLevel, sqrt(item.xp / (isWeapon ? weapon : warframe)).floor());

    mastery +=
        isWeapon ? rank * 100 : masteryPerRankWeapon * masteryPerRankWarframe;
  }

  return mastery;
}

int nodeMastery(List<ProfileMission> missions, List<NodeMastery> region) {
  var mastery = 0;
  for (final node in region) {
    // final normal = missions.firstWhereOrNull((n) =>
    // n.node.contains(node.name));
    final steelPath = missions
        .firstWhereOrNull((n) => n.node.contains(node.name) && n.tier == 1);

    // For anyone reading this line remember that Steel path nodes cannot exist
    // without completing the solsystem on normal first.
    if (steelPath == null) continue;

    var points = node.mastery;
    points = points;

    mastery += points;
  }

  final junctions = missions.where((n) => n.node.contains('Junction'));
  final junctionDone = <ProfileMission>[];
  for (final junction in junctions) {
    if (junction.completes == null) continue;

    var points = 1000;
    if (junction.tier == 1) {
      points = 1000;
      junctionDone.add(junction);
    }

    mastery += points;
  }

  return mastery;
}
