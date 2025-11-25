import 'dart:async';
import 'dart:math';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_icons/warframe_icons.dart';
import 'package:worldstate_models/worldstate_models.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({super.key, required this.fissure});

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    const iconSize = 100.0;
    const opacity = .30;

    final icon = () {
      switch (fissure.tierNum) {
        case 1:
          return WarframeIcons.fissuresLith;
        case 2:
          return WarframeIcons.fissuresMeso;
        case 3:
          return WarframeIcons.fissuresNeo;
        case 4:
          return WarframeIcons.fissuresAxi;
        case 5:
          return WarframeIcons.fissuresRequiem;
      }
    }();

    final child = _FissureContent(fissure: fissure, opacity: opacity, iconSize: iconSize, icon: icon);

    if (fissure.tierNum == 6) {
      return GlitchySkyCard(node: fissure.node, child: child);
    }

    return SkyboxCard(node: fissure.node, child: child);
  }
}

class _FissureContent extends StatelessWidget {
  const _FissureContent({required this.fissure, required this.opacity, required this.iconSize, required this.icon});

  final VoidFissure fissure;
  final double opacity;
  final double iconSize;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        if (fissure.isStorm)
          Center(
            child: Opacity(
              opacity: opacity,
              child: AppIcon(WarframeIcons.archwing, size: iconSize),
            ),
          ),
        if (fissure.isSteelpath)
          Center(
            child: Opacity(
              opacity: opacity,
              child: AppIcon(WarframeIcons.spLogo, size: iconSize),
            ),
          ),
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: fissure.tierNum == 6 ? const OmniaFissureWidget() : Icon(icon, size: 40),
            ),
            Expanded(child: _FissureInfo(fissure: fissure)),
            CountdownTimer(tooltip: context.l10n.countdownTooltip(fissure.expiry), expiry: fissure.expiry),
          ],
        ),
      ],
    );
  }
}

class _FissureInfo extends StatelessWidget {
  const _FissureInfo({required this.fissure});

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fissure.node, style: context.theme.textTheme.titleMedium),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${fissure.tier} | ${fissure.missionType}',
              style: context.theme.textTheme.bodyMedium?.copyWith(color: context.theme.textTheme.bodySmall!.color),
            ),
          ),
        ],
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
    timer = Timer.periodic(glitchFrequency + const Duration(milliseconds: 3000), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Durations.short4,
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: Icon(_icons[rand.nextInt(_icons.length)], size: 40),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
