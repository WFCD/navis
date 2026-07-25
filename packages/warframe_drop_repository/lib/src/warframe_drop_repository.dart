import 'dart:isolate';

import 'package:cache/cache.dart';
import 'package:collection/collection.dart';
import 'package:html/parser.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_common/warframe_common.dart';

const _cacheKey = 'drops';
const _dropDataRefresh = Duration(days: 30);

typedef _BountyLocation = (String location, String rotation);
typedef BountyRewardpool = ({List<String> rewards, List<BountyStage> rewardDrops});

/// {@template warframe_drop_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeDropRepository {
  /// {@macro warframe_drop_repository}
  WarframeDropRepository(this._api, this._cache);

  final CacheManager _cache;
  final WarframeApi _api;

  DropData _drops = const DropData();

  Future<void> buildDrops(String buildLabel) async {
    final key = '${_cacheKey}_$buildLabel';
    final cached = await _cache.get<Map<String, dynamic>>(key);
    if (cached != null) _drops = await Isolate.run(() => DropData.fromMap(cached));

    final page = await _api.fetchDropData();
    final data = await Isolate.run(() {
      final html = parse(page, encoding: 'utf-8');
      return buildDropData(html.body!);
    });

    await _cache.set(key, data.toMap(), ttl: _dropDataRefresh);

    _drops = data;
  }

  List<RegionRewardPool> findRegionRewardpools(String node, {bool isVoidStrom = false}) {
    final planet = RegExp(r'\(([^)]+)\)').firstMatch(node)?.group(1);
    if (planet == null) return throw FormatException('the give node is not valid: $node');
    final nodeName = node.split('(').first.trim();

    // Data does not include 'Proxima' in its naming scheme
    final p = _drops.missionRewards.firstWhereOrNull((p) => p.name.startsWith(planet));
    final rewardPools = p?.findRewardPools(nodeName).toList();

    // Void storms have end of mission reward bonus
    if (isVoidStrom) {
      final voidStormBonus = _drops.transientRewards.where(
        (r) => r.name.contains('Void Storm') && r.name.contains(planet),
      );

      rewardPools?.addAll(voidStormBonus);
    }

    return rewardPools ?? [];
  }

  BountyRewardpool findBountyRewards(SyndicateBounty syndicate) {
    final resource = syndicate.rewardPoolString;

    String level;
    String rotation;
    if (resource.endsWith('PlagueStarTableRewards')) {
      level = 'plague star';
      rotation = 'Earth/Cetus (Level 15 - 25 Plague Star), Rot A';
    } else {
      (level, rotation) = _determineLocation(syndicate);
    }

    final table = _drops.bountyRewardTables.firstWhereOrNull((t) => t.level == level);
    if (table == null) return (rewards: [], rewardDrops: []);

    final rewards = table.rewards.fetchRotation(rotation);
    if (rewards.isEmpty) return (rewards: [], rewardDrops: []);

    final rewardStrings = rewards.map((r) => r.item).toSet().toList();

    if (syndicate.isVault ?? false) {
      return (rewards: rewardStrings, rewardDrops: [(stage: 1, rewards: rewards.map(RewardDrop.fromDrop).toList())]);
    }

    final stages = <int, BountyStage>{};
    var currentStage = 0;
    for (final reward in rewards) {
      final drop = RewardDrop.fromDrop(reward);

      if (!reward.onFinalStage) {
        for (final stage in reward.stages) {
          if (currentStage < stage) currentStage = stage;
          stages.update(
            stage,
            (stage) => (stage: stage.stage, rewards: [...stage.rewards, drop]),
            ifAbsent: () => (stage: stage, rewards: [drop]),
          );
        }

        final stage = currentStage + 1;
        stages.update(
          stage,
          (stage) => (stage: stage.stage, rewards: [...stage.rewards, drop]),
          ifAbsent: () => (stage: stage, rewards: [drop]),
        );
      }
    }

    stages.removeWhere((key, value) => key > syndicate.standingPerStage.length);
    return (rewards: rewardStrings, rewardDrops: stages.entries.map((entry) => entry.value).toList());
  }

  _BountyLocation _determineLocation(SyndicateBounty syndicate) {
    final bountyRewardRegex = RegExp('(?:Tier([ABCDE])|Narmer)Table([ABC])Rewards');
    final ghoulRewardRegex = RegExp('GhoulBountyTable([AB])Rewards');

    final resource = syndicate.rewardPoolString;
    final table = resource.split('/').last;
    final bountyMatchs = bountyRewardRegex.firstMatch(table);
    final ghoulMatches = ghoulRewardRegex.firstMatch(table);

    // final isBounty = bountyMatchs != null;
    final isGhoul = ghoulMatches != null;
    final isCetus = resource.contains('EidolonJob');
    final isVallis = resource.contains('VenusJob');
    final isDeimos = resource.contains('DeimosMissionRewards');

    final rotation = bountyMatchs?.group(2) ?? 'A';
    final levelString = '${syndicate.minLevel} - ${syndicate.maxLevel}';

    late String levelClause;
    if (isCetus) {
      levelClause = 'Level $levelString ${isGhoul ? 'Ghoul Bounty' : 'Cetus Bounty'}';
    }

    if (isVallis) {
      levelClause = 'Level $levelString Orb Vallis Bounty';
    }

    if (isDeimos) {
      final variant = (syndicate.isVault ?? false) ? 'Isolation Vault' : 'Cambion Drift Bounty';
      levelClause = 'Level $levelString $variant';
    }

    return (levelClause, rotation);
  }
}
