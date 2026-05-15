import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:warframestat_client/warframestat_client.dart';

class FissureMissionRewards extends StatelessWidget {
  const FissureMissionRewards({
    super.key,
    required this.controller,
    required this.node,
    required this.header,
    required this.region,
  });

  final ScrollController controller;
  final String node;
  final Widget header;
  final List<RegionRewardPool> region;

  @override
  Widget build(BuildContext context) {
    final top = SkyboxCard(
      node: node,
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: header,
      ),
    );

    return ListView(
      controller: controller,
      children: [
        top,
        Gaps.gap8,
        if (region.length < 2)
          _FissureRewardPoolBody(rewardPool: region.first)
        else
          _MultipleRewardPools(regions: region),
      ],
    );
  }
}

class _MultipleRewardPools extends StatefulWidget {
  const _MultipleRewardPools({required this.regions});

  final List<RegionRewardPool> regions;

  @override
  State<_MultipleRewardPools> createState() => __MultipleRewardPoolsState();
}

class __MultipleRewardPoolsState extends State<_MultipleRewardPools> {
  final _panels = <bool>[];

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.regions.length; i++) {
      _panels.add(false);
    }
  }

  void _onExpand(int index, bool value) {
    if (!mounted) return;
    if (_panels[index] == value) return;

    setState(() => _panels[index] = value);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionPanelList(
      expansionCallback: _onExpand,
      children: widget.regions
          .mapIndexed(
            (index, r) => ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (_, _) => ListTile(title: Text(r.name)),
              body: _FissureRewardPoolBody(rewardPool: r),
              isExpanded: _panels[index],
            ),
          )
          .toList(),
    );
  }
}

class _FissureRewardPoolBody extends StatelessWidget {
  const _FissureRewardPoolBody({required this.rewardPool});

  final RegionRewardPool rewardPool;

  @override
  Widget build(BuildContext context) {
    if (rewardPool is MultiRewardPool) return _EndlessFissure(region: rewardPool as MultiRewardPool);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: (rewardPool as SingleRewardPool).rewards
          .map(
            (r) => RewardTile(
              reward: r.item,
              chance: r.chance,
              rarity: Rarity.values.byName(r.rarity.toLowerCase()),
            ),
          )
          .toList(),
    );
  }
}

class _EndlessFissure extends StatefulWidget {
  const _EndlessFissure({required this.region});

  final MultiRewardPool region;

  @override
  State<_EndlessFissure> createState() => _EndlessFissureState();
}

class _EndlessFissureState extends State<_EndlessFissure> {
  static const _rotations = ['A', 'B', 'C'];
  String _rotation = _rotations[0];

  @override
  Widget build(BuildContext context) {
    final rewards = widget.region.rewards.fetchRotation(_rotation);

    return Column(
      mainAxisSize: MainAxisSize.min,
      spacing: 4,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 6, bottom: rewards.isEmpty ? 64 : 6),
          child: SegmentedBar(
            children: _rotations.map((r) => (label: r, child: Text(r))).toList(),
            onChange: (index) => setState(() => _rotation = _rotations[index]),
          ),
        ),
        if (rewards.isEmpty) ...[
          const Icon(WarframeIcons.menuWoundedInfestedPredator, size: 128),
          Text('No rewards in rotation $_rotation'),
        ] else
          ...rewards.map(
            (r) => RewardTile(
              reward: r.item,
              chance: r.chance,
              rarity: Rarity.values.byName(r.rarity.toLowerCase()),
            ),
          ),
      ],
    );
  }
}
