import 'dart:async';
import 'dart:math' as math;

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/drops/drops.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({super.key, required this.fissure});

  final VoidFissure fissure;

  void _openMissionRewardModal(BuildContext context, Widget header, List<RegionRewardPool> rewardpools) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          maxChildSize: .9,
          initialChildSize: .9,
          expand: false,
          builder: (context, scrollController) => MissionRewardsView(
            controller: scrollController,
            node: fissure.node,
            header: header,
            region: rewardpools,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tierIcon = fissure.tier == .omnia
        ? const OmniaFissureWidget()
        : Icon(
            switch (fissure.tier) {
              .lith => WarframeIcons.fissuresLith,
              .meso => WarframeIcons.fissuresMeso,
              .neo => WarframeIcons.fissuresNeo,
              .axi => WarframeIcons.fissuresAxi,
              .requiem => WarframeIcons.fissuresRequiem,
              _ => WarframeIcons.nightmare,
            },
            size: 40,
          );

    final fissureInfo = ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      leading: tierIcon,
      title: Text(fissure.node),
      subtitle: Text('${toBeginningOfSentenceCase(fissure.tier.name)} | ${fissure.missionType}'),
      trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(fissure.expiry), expiry: fissure.expiry),
    );

    return SkyboxCard(
      node: fissure.node,
      child: BlocBuilder<DropsCubit, DropsState>(
        builder: (context, state) {
          final rewards = switch (state) {
            RegionDrops(:final rewards) => rewards,
            _ => <RegionRewardPool>[],
          };

          return InkWell(
            onTap: () => rewards.isNotEmpty ? _openMissionRewardModal(context, fissureInfo, rewards) : null,
            child: Stack(
              alignment: AlignmentGeometry.center,
              children: [
                Center(child: fissureInfo),
                if (rewards.isNotEmpty)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Transform.rotate(
                        angle: -math.pi / 4.0,
                        child: Icon(
                          Icons.square,
                          size: 12,
                          color: context.theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OmniaFissureWidget extends StatefulWidget {
  const OmniaFissureWidget({super.key});

  @override
  State<OmniaFissureWidget> createState() => _OmniaFissureWidgetState();
}

class _OmniaFissureWidgetState extends State<OmniaFissureWidget> {
  static const List<IconData> _icons = [
    WarframeIcons.fissuresLith,
    WarframeIcons.fissuresMeso,
    WarframeIcons.fissuresNeo,
    WarframeIcons.fissuresAxi,
  ];

  late final Timer timer;
  late final math.Random rand;

  @override
  void initState() {
    super.initState();

    rand = math.Random();
    timer = Timer.periodic(GlitchyWidget.glitchFrequency, (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 40,
      child: AnimatedSwitcher(
        duration: Durations.short4,
        switchInCurve: Curves.easeInOut,
        switchOutCurve: Curves.easeInOut,
        child: GlitchyWidget(child: Icon(_icons[rand.nextInt(_icons.length)], size: 40)),
      ),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
