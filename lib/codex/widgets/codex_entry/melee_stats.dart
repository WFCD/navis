import 'package:flutter/material.dart';
import 'package:navis/codex/utils/stats.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/preinstalled_polarities.dart';
import 'package:navis/codex/widgets/codex_entry/riven_disposition.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Polarity;

class MeleeStats extends StatelessWidget {
  const MeleeStats({super.key, required this.melee});

  final Melee melee;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.titleMedium;
    final totalDamage = statRoundDouble(melee.totalDamage.toDouble(), 1);

    return Column(
      children: [
        CategoryTitle(
          title: context.l10n.statsTitle,
          contentPadding: EdgeInsets.zero,
        ),
        Stats(
          stats: <RowItem>[
            if (melee.masteryReq != null)
              RowItem(
                text: Text(l10n.masteryRequirementTitle),
                child: Text('${melee.masteryReq}'),
              ),
            RowItem(
              text: Text(l10n.weaponTypeTitle),
              child: Text(melee.type.category),
            ),
            if (melee.stancePolarity != null)
              RowItem(
                text: Text(l10n.stancePolarityTitle),
                child: Polarity(polarity: melee.stancePolarity!),
              ),
            if (melee.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(
                  polarities: melee.polarities!,
                ),
              ),
            RowItem(
              text: Text(l10n.criticalChanceTitle),
              child: Text(
                '${(melee.criticalChance * 100).roundToDouble()}%',
              ),
            ),
            RowItem(
              text: Text(l10n.cricticalMultiplierTitle),
              child: Text('${melee.criticalMultiplier}x'),
            ),
            RowItem(
              text: Text(l10n.followThroughTitle),
              child: Text('${melee.followThrough?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.rangeTitle),
              child: Text('${melee.range?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.slamAttackTitle),
              child: Text('${melee.slamAttack}'),
            ),
            RowItem(
              text: Text(l10n.slamRadialDamageTitle),
              child: Text('${melee.slamRadialDamage}'),
            ),
            RowItem(
              text: Text(l10n.slamRadiusTitle),
              child: Text('${melee.slamRadius?.toStringAsFixed(2) ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.slideAttackTitle),
              child: Text('${melee.slideAttack}'),
            ),
            if (melee.disposition != null)
              RowItem(
                text: Text(l10n.rivenDispositionTitle),
                child: RivenDisposition(disposition: melee.disposition!),
              ),
            RowItem(
              text: Text(l10n.statusChanceTitle),
              child: Text('${(melee.procChance * 100).roundToDouble()}%'),
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
              child: Text('${melee.heavyAttackDamage}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamAttackTitle),
              child: Text('${melee.heavySlamAttack}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamRadialDamageTitle),
              child: Text('${melee.heavySlamRadialDamage}'),
            ),
            RowItem(
              text: Text(l10n.heavySlamRadiusTitle),
              child: Text('${melee.heavySlamRadius?.toDouble() ?? 0}'),
            ),
            RowItem(
              text: Text(l10n.windUpTitle),
              child: Text('${melee.windUp?.toStringAsFixed(2) ?? 0}'),
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
