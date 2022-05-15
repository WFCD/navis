import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class FrameStats extends StatelessWidget {
  const FrameStats({super.key, required this.powerSuit});

  final PowerSuit powerSuit;

  Widget _passive(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(context.l10n.warframePassiveTitle, style: textTheme.subtitle1),
          SizedBoxSpacer.spacerHeight8,
          Text(
            (powerSuit as Warframe).passiveDescription,
            style: textTheme.caption?.copyWith(fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CategoryTitle(title: 'Stats', contentPadding: EdgeInsets.zero),
        if (powerSuit is Warframe) _passive(context),
        SizedBoxSpacer.spacerHeight16,
        Stats(
          stats: <RowItem>[
            if (powerSuit is Warframe && (powerSuit as Warframe).aura != null)
              RowItem(
                text: Text(l10n.auraTitle),
                child: Polarity(polarity: (powerSuit as Warframe).aura!),
              ),
            if (powerSuit.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(polarities: powerSuit.polarities!),
              ),
            RowItem(
              text: Text(l10n.shieldTitle),
              child: Text('${powerSuit.shield}'),
            ),
            RowItem(
              text: Text(l10n.armorTitle),
              child: Text('${powerSuit.armor}'),
            ),
            RowItem(
              text: Text(l10n.healthTitle),
              child: Text('${powerSuit.health}'),
            ),
            RowItem(
              text: Text(l10n.powerTitle),
              child: Text('${powerSuit.power}'),
            ),
            if (powerSuit is PlayerUsuablePowerSuit)
              RowItem(
                text: Text(l10n.sprintSpeedTitle),
                child: Text(
                  '${(powerSuit as PlayerUsuablePowerSuit).sprintSpeed}',
                ),
              ),
          ],
        ),
        SizedBoxSpacer.spacerHeight16,
        if (powerSuit is PlayerUsuablePowerSuit) ...{
          CategoryTitle(
            title: l10n.abilitiesTitle,
            contentPadding: EdgeInsets.zero,
          ),
          for (final ability in (powerSuit as PlayerUsuablePowerSuit).abilities)
            ListTile(
              title: Text(ability.name),
              subtitle: Text(ability.description),
              dense: true,
              isThreeLine: true,
              contentPadding: EdgeInsets.zero,
            )
        }
      ],
    );
  }
}
