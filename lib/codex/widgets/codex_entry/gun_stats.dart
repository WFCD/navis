// This is what just worked for the style.
// ignore_for_file: no-magic-number
// Already being checked for null.
// ignore_for_file: avoid-non-null-assertion
import 'package:flutter/material.dart';
import 'package:navis/codex/utils/stats.dart';
import 'package:navis/codex/widgets/codex_entry/preinstalled_polarities.dart';
import 'package:navis/codex/widgets/codex_entry/riven_disposition.dart';
import 'package:navis/codex/widgets/codex_widgets.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class GunStats extends StatelessWidget {
  const GunStats({super.key, required this.projectileWeapon});

  final ProjectileWeapon projectileWeapon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.subtitle1;

    return Column(
      children: [
        const CategoryTitle(
          title: 'Stats',
          contentPadding: EdgeInsets.zero,
        ),
        SizedBoxSpacer.spacerHeight8,
        Stats(
          stats: <RowItem>[
            RowItem(
              text: Text(l10n.masteryRequirementTitle),
              child: Text('${projectileWeapon.masteryReq}'),
            ),
            RowItem(
              text: Text(l10n.weaponTypeTitle),
              child: Text(projectileWeapon.type),
            ),
            if (projectileWeapon.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(
                  polarities: projectileWeapon.polarities ?? <String>[],
                ),
              ),
            if (projectileWeapon.accuracy != null)
              RowItem(
                text: Text(l10n.accuracyTitle),
                child:
                    Text('${statRoundDouble(projectileWeapon.accuracy!, 1)}'),
              ),
            RowItem(
              text: Text(l10n.criticalChanceTitle),
              child: Text(
                '${(projectileWeapon.criticalChance * 100).roundToDouble()}%',
              ),
            ),
            RowItem(
              text: Text(l10n.cricticalMultiplierTitle),
              child: Text('${projectileWeapon.criticalMultiplier}x'),
            ),
            RowItem(
              text: Text(l10n.fireRateTitle),
              child: Text(projectileWeapon.fireRate.toStringAsFixed(2)),
            ),
            RowItem(
              text: Text(l10n.magazineTitle),
              child: Text('${projectileWeapon.magazineSize}'),
            ),
            RowItem(
              text: Text(l10n.multishotTitle),
              child: Text('${projectileWeapon.multishot}'),
            ),
            if (projectileWeapon.noise != null)
              RowItem(
                text: Text(l10n.noiseTitle),
                child: Text(projectileWeapon.noise!.toUpperCase()),
              ),
            if (projectileWeapon.reloadTime != null)
              RowItem(
                text: Text(l10n.reloadTitle),
                child:
                    Text('${statRoundDouble(projectileWeapon.reloadTime!, 1)}'),
              ),
            RowItem(
              text: Text(l10n.rivenDispositionTitle),
              child: RivenDisposition(
                disposition: projectileWeapon.disposition ?? 0,
              ),
            ),
            RowItem(
              text: Text(l10n.statusChanceTitle),
              child: Text(
                '${(projectileWeapon.statusChance * 100).roundToDouble()}%',
              ),
            ),
            if (projectileWeapon.trigger != null)
              RowItem(
                text: Text(l10n.triggerTitle),
                child: Text(projectileWeapon.trigger!),
              ),
          ],
        ),
        SizedBoxSpacer.spacerHeight16,
        CategoryTitle(
          title: l10n.damageTitle,
          contentPadding: EdgeInsets.zero,
        ),
        SizedBoxSpacer.spacerHeight16,
        RowItem(
          text: Text(
            l10n.totalDamageTitle,
            style: textStyle,
          ),
          child: Text(
            '${statRoundDouble(projectileWeapon.totalDamage, 1)}',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
