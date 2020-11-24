import 'package:flutter/material.dart';
import 'package:navis/features/codex/presentation/widgets/codex_entry/polarity.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import 'stats.dart';

class FrameStats extends StatelessWidget {
  const FrameStats({Key key, @required this.powerSuit}) : super(key: key);

  final PowerSuit powerSuit;

  Widget _passive(BuildContext context) {
    final textTheme = Theme.of(context)?.textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: <Widget>[
          Text('Passive', style: textTheme?.subtitle1),
          const SizedBox(height: 8.0),
          Text(
            (powerSuit as Warframe).passiveDescription,
            style: textTheme?.caption?.copyWith(fontStyle: FontStyle.italic),
          ),
          const Divider()
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (powerSuit is Warframe) _passive(context),
          const SizedBox(height: 16.0),
          Stats(stats: <RowItem>[
            if (powerSuit is Warframe)
              RowItem(
                text: const Text('Aura'),
                child: Polarity(
                  polarity: (powerSuit as Warframe).aura,
                ),
              ),
            if (powerSuit.polarities.isNotEmpty)
              RowItem(
                text: const Text('Polarties'),
                child: PreinstalledPolarties(
                  polarities: powerSuit.polarities,
                ),
              ),
            RowItem(
              text: const Text('Shield'),
              child: Text('${powerSuit.shield}'),
            ),
            RowItem(
              text: const Text('Armor'),
              child: Text('${powerSuit.armor}'),
            ),
            RowItem(
              text: const Text('Health'),
              child: Text('${powerSuit.health}'),
            ),
            RowItem(
              text: const Text('Power'),
              child: Text('${powerSuit.power}'),
            ),
            if (powerSuit is PlayerUsuablePowerSuit)
              RowItem(
                text: const Text('Sprint Speed'),
                child: Text(
                    '${(powerSuit as PlayerUsuablePowerSuit).sprintSpeed}'),
              ),
          ]),
        ],
      ),
    );
  }
}
