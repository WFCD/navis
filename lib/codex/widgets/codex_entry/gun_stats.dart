import 'package:flutter/material.dart';
import 'package:navis/codex/utils/stats.dart';
import 'package:navis/codex/widgets/codex_widgets.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class GunStats extends StatelessWidget {
  const GunStats({super.key, required this.gun});

  final Gun gun;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Column(
      children: [
        const CategoryTitle(
          title: 'Stats',
          contentPadding: EdgeInsets.zero,
        ),
        SizedBoxSpacer.spacerHeight8,
        Stats(
          stats: <RowItem>[
            if (gun.masterReq != null)
              RowItem(
                text: Text(l10n.masteryRequirementTitle),
                child: Text('${gun.masterReq}'),
              ),
            RowItem(
              text: Text(l10n.weaponTypeTitle),
              child: Text(gun.type),
            ),
            if (gun.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(
                  polarities: gun.polarities ?? <String>[],
                ),
              ),
            if (gun.accuracy != null)
              RowItem(
                text: Text(l10n.accuracyTitle),
                child: Text('${statRoundDouble(gun.accuracy!, 2)}'),
              ),
            RowItem(
              text: Text(l10n.criticalChanceTitle),
              child: Text(
                '${statRoundDouble(gun.criticalChance * 100, 2)}%',
              ),
            ),
            RowItem(
              text: Text(l10n.cricticalMultiplierTitle),
              child: Text('${gun.criticalMultiplier}x'),
            ),
            RowItem(
              text: Text(l10n.fireRateTitle),
              child: Text(gun.fireRate.toStringAsFixed(2)),
            ),
            RowItem(
              text: Text(l10n.magazineTitle),
              child: Text('${gun.magazineSize}'),
            ),
            if (gun.multishot != null && gun.multishot! > 1.0)
              RowItem(
                text: Text(l10n.multishotTitle),
                child: Text('${statRoundDouble(gun.multishot!, 2)}%'),
              ),
            if (gun.noise != null)
              RowItem(
                text: Text(l10n.noiseTitle),
                child: Text(gun.noise!.toUpperCase()),
              ),
            if (gun.reloadTime != null)
              RowItem(
                text: Text(l10n.reloadTitle),
                child: Text(gun.reloadTime!.toStringAsFixed(2)),
              ),
            RowItem(
              text: Text(l10n.rivenDispositionTitle),
              child: RivenDisposition(
                disposition: gun.disposition,
              ),
            ),
            RowItem(
              text: Text(l10n.statusChanceTitle),
              child: Text(
                '${(gun.procChance * 100).roundToDouble()}%',
              ),
            ),
            if (gun.trigger != null)
              RowItem(
                text: Text(l10n.triggerTitle),
                child: Text(gun.trigger!),
              ),
          ],
        ),
        SizedBoxSpacer.spacerHeight16,
        CategoryTitle(
          title: l10n.damageTitle,
          contentPadding: EdgeInsets.zero,
        ),
        RowItem(
          text: Text(
            l10n.totalDamageTitle,
            style: textStyle,
          ),
          child: Text(
            '${statRoundDouble(gun.totalDamage.toDouble(), 1)}',
            style: textStyle,
          ),
        ),
        SizedBoxSpacer.spacerHeight16,
      ],
    );
  }
}
