import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/drops/cubit/drops_cubit.dart';
import 'package:navis/drops/widgets/bounty_stage.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' as common;
import 'package:warframe_drop_repository/warframe_drop_repository.dart';

class BountyRewardsView extends StatelessWidget {
  const BountyRewardsView({super.key, this.controller, required this.bounty, required this.color});

  final ScrollController? controller;
  final common.SyndicateBounty bounty;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DropsCubit(context.read<WarframeDropRepository>())..findBountyRewards(bounty),
      child: _BountRewardsList(controller: controller, color: color),
    );
  }
}

class _BountRewardsList extends StatelessWidget {
  const _BountRewardsList({this.controller, required this.color});

  final ScrollController? controller;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<DropsCubit>().state;
    if (state is DropsLoading) return const Center(child: WarframeSpinner());

    final rewards = switch (state) {
      BountyDrops(:final rewards) => rewards,
      _ => (rewards: <String>[], rewardDrops: <common.BountyStage>[]),
    };

    if (rewards.rewards.length < 2) return Center(child: Text(rewards.rewards[0]));

    return ListView(
      controller: controller,
      children: rewards.rewardDrops
          .map(
            (bounty) => BountyStage(
              stage: bounty.stage,
              maxStage: rewards.rewardDrops.length,
              rewards: bounty.rewards,
              color: color,
            ),
          )
          .toList(),
    );
  }
}
