// This is what just worked for the style.
// ignore_for_file: no-magic-number
// Already being checked for null.
// ignore_for_file: avoid-non-null-assertion
import 'package:flutter/material.dart';
import 'package:navis/codex/utils/stats.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/preinstalled_polarities.dart';
import 'package:navis/codex/widgets/codex_entry/riven_disposition.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class MeleeStats extends StatelessWidget {
  const MeleeStats({super.key, required this.meleeWeapon});

  final MeleeWeapon meleeWeapon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.subtitle1;
    final totalDamage = statRoundDouble(meleeWeapon.totalDamage, 1);

    return Column(
      children: [
        const CategoryTitle(
          title: 'Stats',
          contentPadding: EdgeInsets.zero,
        ),
        Stats(
          stats: <RowItem>[
            RowItem(
              text: Text(l10n.masteryRequirementTitle),
              child: Text('${meleeWeapon.masteryReq}'),
            ),
            RowItem(
              text: Text(l10n.weaponTypeTitle),
              child: Text(meleeWeapon.type),
            ),
            if (meleeWeapon.stancePolarity != null)
              RowItem(
                text: Text(l10n.stancePolarityTitle),
                child: Polarity(polarity: meleeWeapon.stancePolarity!),
              ),
            if (meleeWeapon.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(
                  polarities: meleeWeapon.polarities!,
                ),
              ),
            RowItem(
              text: Text(l10n.attackSpeedTitle),
              child: Text(meleeWeapon.attackSpeed.toStringAsFixed(2)),
            ),
            RowItem(
              text: Text(l10n.criticalChanceTitle),
              child: Text(
                '${(meleeWeapon.criticalChance * 100).roundToDouble()}%',
              ),
            ),
            RowItem(
              text: Text(l10n.cricticalMultiplierTitle),
              child: Text('${meleeWeapon.criticalMultiplier}x'),
            ),
            RowItem(
              text: Text(l10n.followThroughTitle),
              child:
                  Text('${meleeWeapon.followThrough?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.rangeTitle),
              child: Text('${meleeWeapon.range?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.slamAttackTitle),
              child: Text('${meleeWeapon.slamAttack}'),
            ),
            RowItem(
              text: Text(l10n.slamRadialDamageTitle),
              child: Text('${meleeWeapon.slamRadialDamage}'),
            ),
            RowItem(
              text: Text(l10n.slamRadiusTitle),
              child: Text('${meleeWeapon.slamRadius?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.slideAttackTitle),
              child: Text('${meleeWeapon.slideAttack}'),
            ),
            RowItem(
              text: Text(l10n.rivenDispositionTitle),
              child:
                  RivenDisposition(disposition: meleeWeapon.disposition ?? 0),
            ),
            RowItem(
              text: Text(l10n.statusChanceTitle),
              child:
                  Text('${(meleeWeapon.statusChance * 100).roundToDouble()}%'),
            ),
          ],
        ),
        SizedBoxSpacer.spacerHeight16,
        CategoryTitle(
          title: l10n.heavyAttackTitle,
          contentPadding: EdgeInsets.zero,
        ),
        Stats(
          stats: [
            RowItem(
              text: Text(l10n.damageTitle),
              child: Text('${meleeWeapon.heavyAttackDamage}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamAttackTitle),
              child: Text('${meleeWeapon.heavySlamAttack}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamRadialDamageTitle),
              child: Text('${meleeWeapon.heavySlamRadialDamage}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamRadiusTitle),
              child: Text('${meleeWeapon.heavySlamRadius?.toDouble() ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.windUpTitle),
              child: Text('${meleeWeapon.windUp?.toStringAsFixed(2) ?? 0}'),
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
            '$totalDamage',
            style: textStyle,
          ),
        ),
      ],
    );
  }
}
