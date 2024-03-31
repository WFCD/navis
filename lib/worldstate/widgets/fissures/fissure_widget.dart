import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({super.key, required this.fissure});

  final Fissure fissure;

  static const shadow = Shadow(offset: Offset(1, 0), blurRadius: 3);

  static const _nodeStyle = TextStyle(
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    fontSize: 18,
    shadows: <Shadow>[shadow],
  );

  static const _missionTypeStyle = TextStyle(
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    fontSize: 14,
    shadows: <Shadow>[shadow],
  );

  @override
  Widget build(BuildContext context) {
    const iconSize = 100.0;
    const opacity = .30;

    final icon = () {
      switch (fissure.tierNum) {
        case 1:
          return WarframeSymbols.fissures_lith;
        case 2:
          return WarframeSymbols.fissures_meso;
        case 3:
          return WarframeSymbols.fissures_neo;
        case 4:
          return WarframeSymbols.fissures_axi;
        case 5:
          return WarframeSymbols.fissures_requiem;
      }
    }();

    return SkyboxCard(
      node: fissure.node,
      enableGlitch: fissure.tierNum == 6,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Stack(
        children: [
          if (fissure.isStorm)
            const Center(
              child: Opacity(
                opacity: opacity,
                child: AppIcon(WarframeSymbols.archwing, size: iconSize),
              ),
            ),
          if (fissure.isHard)
            const Center(
              child: Opacity(
                opacity: opacity,
                child: AppIcon(WarframeSymbols.sp_logo, size: iconSize),
              ),
            ),
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: fissure.tierNum == 6
                    ? const OmniaFissureWidget()
                    : Icon(icon, size: 40),
              ),
              Expanded(
                child: _FissureInfo(
                  fissure: fissure,
                  nodeStyle: _nodeStyle,
                  missionTypeStyle: _missionTypeStyle,
                ),
              ),
              CountdownTimer(
                tooltip: context.l10n.countdownTooltip(fissure.expiry),
                expiry: fissure.expiry,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FissureInfo extends StatelessWidget {
  const _FissureInfo({
    required this.fissure,
    required TextStyle nodeStyle,
    required TextStyle missionTypeStyle,
  })  : _nodeStyle = nodeStyle,
        _missionTypeStyle = missionTypeStyle;

  final Fissure fissure;
  final TextStyle _nodeStyle;
  final TextStyle _missionTypeStyle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(fissure.node, style: _nodeStyle),
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              '${fissure.missionType} | ${fissure.tier}',
              style: _missionTypeStyle,
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
  static const _icons = [
    WarframeSymbols.fissures_lith,
    WarframeSymbols.fissures_meso,
    WarframeSymbols.fissures_neo,
    WarframeSymbols.fissures_axi,
    WarframeSymbols.fissures_requiem,
  ];

  late final Timer timer;
  late final Random rand;

  @override
  void initState() {
    super.initState();

    rand = Random();
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 1500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      child: Icon(_icons[rand.nextInt(5)], size: 40),
    );
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
}
