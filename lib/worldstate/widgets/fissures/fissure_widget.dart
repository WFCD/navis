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
    final icon = () {
      switch (fissure.tier) {
        case 'Lith':
          return WarframeSymbols.fissures_lith;
        case 'Meso':
          return WarframeSymbols.fissures_meso;
        case 'Neo':
          return WarframeSymbols.fissures_neo;
        case 'Axi':
          return WarframeSymbols.fissures_axi;
        default:
          return WarframeSymbols.fissures_requiem;
      }
    }();

    return SkyboxCard(
      node: fissure.node,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 16),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Icon(icon, size: 40),
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (fissure.isStorm)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(WarframeSymbols.archwing, size: 20),
                  ),
                if (fissure.isHard)
                  const Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Icon(WarframeSymbols.arbitrations, size: 20),
                  ),
                Text(
                  '${fissure.missionType} | ${fissure.tier}',
                  style: _missionTypeStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
