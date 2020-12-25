import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';
import 'polarity.dart';
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
          Text(context.locale.warframePassiveTitle,
              style: textTheme?.subtitle1),
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
                text: Text(context.locale.auraTitle),
                child: Polarity(
                  polarity: (powerSuit as Warframe).aura,
                ),
              ),
            if (powerSuit.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(context.locale.preinstalledPolarities),
                child: PreinstalledPolarties(
                  polarities: powerSuit.polarities,
                ),
              ),
            RowItem(
              text: Text(context.locale.shieldTitle),
              child: Text('${powerSuit.shield}'),
            ),
            RowItem(
              text: Text(context.locale.armorTitle),
              child: Text('${powerSuit.armor}'),
            ),
            RowItem(
              text: Text(context.locale.healthTitle),
              child: Text('${powerSuit.health}'),
            ),
            RowItem(
              text: Text(context.locale.powerTitle),
              child: Text('${powerSuit.power}'),
            ),
            if (powerSuit is PlayerUsuablePowerSuit)
              RowItem(
                text: Text(context.locale.sprintSpeedTitle),
                child: Text(
                    '${(powerSuit as PlayerUsuablePowerSuit).sprintSpeed}'),
              ),
          ]),
          const SizedBox(height: 16.0),
          if (powerSuit is PlayerUsuablePowerSuit) ...{
            CategoryTitle(
                title: context.locale.abilitiesTitle,
                contentPadding: EdgeInsets.zero),
            for (final ability
                in (powerSuit as PlayerUsuablePowerSuit).abilities)
              ListTile(
                title: Text(ability.name),
                subtitle: Text(ability.description),
                dense: true,
                isThreeLine: true,
                contentPadding: EdgeInsets.zero,
              )
          }
        ],
      ),
    );
  }
}
