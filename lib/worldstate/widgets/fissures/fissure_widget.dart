import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/widgets/fissures/fissure_mission_rewards.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:worldstate_models/worldstate_models.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({super.key, required this.fissure});

  final VoidFissure fissure;

  void _openMissionRewardModal(BuildContext context, Widget header) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          maxChildSize: .9,
          initialChildSize: .9,
          expand: false,
          builder: (context, scrollController) => FissureMissionRewards(
            controller: scrollController,
            node: fissure.node,
            header: header,
            region: fissure.rewardPools,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fissureInfo = ListTile(
      textColor: Colors.white,
      iconColor: Colors.white,
      contentPadding: EdgeInsets.zero,
      leading: fissure.tier == .omnia
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
            ),
      title: Text(fissure.node),
      subtitle: Text('${toBeginningOfSentenceCase(fissure.tier.name)} | ${fissure.missionType}'),
      trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(fissure.expiry), expiry: fissure.expiry),
    );

    return SkyboxCard(
      node: fissure.node,
      child: InkWell(
        onTap: () => fissure.rewardPools.isNotEmpty ? _openMissionRewardModal(context, fissureInfo) : null,
        child: Stack(
          alignment: AlignmentGeometry.center,
          children: [
            Center(child: fissureInfo),
            if (fissure.rewardPools.isNotEmpty)
              const Align(alignment: Alignment.bottomRight, child: Icon(Icons.arrow_drop_down_outlined)),
          ],
        ),
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
  late final Random rand;

  @override
  void initState() {
    super.initState();

    rand = Random();
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
