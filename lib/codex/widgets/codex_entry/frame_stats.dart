// ignore_for_file: prefer-moving-to-variable
import 'package:flutter/material.dart';
import 'package:navis/codex/utils/stats.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/preinstalled_polarities.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class FrameStats extends StatelessWidget {
  const FrameStats({super.key, required this.powerSuit});

  final PowerSuit powerSuit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const CategoryTitle(title: 'Stats', contentPadding: EdgeInsets.zero),
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
            if (powerSuit is Warframe)
              RowItem(
                text: Text(l10n.sprintSpeedTitle),
                child: Text(
                  '${statRoundDouble((powerSuit as Warframe).sprintSpeed, 2)}',
                ),
              ),
          ],
        ),
        SizedBoxSpacer.spacerHeight16,
        CategoryTitle(
          title: l10n.abilitiesTitle,
          contentPadding: EdgeInsets.zero,
        ),
        if (powerSuit is Warframe &&
            (powerSuit as Warframe).passiveDescription != null)
          ListTile(
            title: Text(context.l10n.warframePassiveTitle),
            subtitle: Text((powerSuit as Warframe).passiveDescription!),
            dense: true,
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          ),
        for (final ability in powerSuit.abilities)
          ListTile(
            title: Text(ability.name),
            subtitle: Text(ability.description),
            dense: true,
            isThreeLine: true,
            contentPadding: EdgeInsets.zero,
          ),
      ],
    );
  }
}
