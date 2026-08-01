import 'package:flutter/material.dart';
import 'package:navis/items/widgets/stats/damage.dart';
import 'package:navis/items/widgets/stats/polarity.dart';
import 'package:navis/items/widgets/stats/preinstalled_polarities.dart';
import 'package:navis/items/widgets/stats/riven_disposition.dart';
import 'package:navis/items/widgets/stats/stats_column.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart' hide Polarity;

class MeleeStats extends StatelessWidget {
  const MeleeStats({super.key, required this.melee});

  final Melee melee;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final masteryReq = switch (melee) {
      BuildableItem(:final masteryReq) => masteryReq,
      _ => null,
    };

    return Column(
      children: [
        CategoryTitle(title: context.l10n.statsTitle, contentPadding: EdgeInsets.zero),
        StatsColumn(
          stats: [
            Stat(
              name: Text(l10n.masteryRequirementTitle),
              value: Text(masteryReq.toString()),
              isVisible: masteryReq != null,
            ),
            Stat(name: Text(l10n.weaponTypeTitle), value: Text(melee.type.type)),
            Stat(
              name: Text(l10n.stancePolarityTitle),
              value: Polarity(polarity: melee.stancePolarity ?? ''),
              isVisible: melee.stancePolarity != null,
            ),
            Stat(
              name: Text(l10n.preinstalledPolarities),
              value: PreinstalledPolarties(polarities: melee.polarities ?? []),
              isVisible: melee.polarities?.isNotEmpty ?? false,
            ),
            Stat(
              name: Text(l10n.criticalChanceTitle),
              value: Text('${(melee.criticalChance * 100).roundToDouble()}%'),
            ),
            Stat(
              name: Text(l10n.cricticalMultiplierTitle),
              value: Text('${melee.criticalMultiplier.toStringAsFixed(2)}x'),
            ),
            Stat(
              name: Text(l10n.followThroughTitle),
              value: Text('${melee.followThrough?.toStringAsFixed(2) ?? 0}'),
            ),
            Stat(name: Text(l10n.rangeTitle), value: Text('${melee.range?.toStringAsFixed(2) ?? 0}')),
            Stat(name: Text(l10n.slamAttackTitle), value: Text('${melee.slamAttack}')),
            Stat(name: Text(l10n.slamRadialDamageTitle), value: Text('${melee.slamRadialDamage}')),
            Stat(name: Text(l10n.slamRadiusTitle), value: Text('${melee.slamRadius?.toStringAsFixed(2) ?? 0}')),
            Stat(name: Text(l10n.slideAttackTitle), value: Text('${melee.slideAttack}')),
            Stat(
              name: Text(l10n.rivenDispositionTitle),
              value: RivenDisposition(disposition: melee.omegaAttenuation),
            ),
            Stat(name: Text(l10n.statusChanceTitle), value: Text('${(melee.procChance * 100).roundToDouble()}%')),
          ],
        ),
        Gaps.gap16,
        CategoryTitle(title: l10n.heavyAttackTitle, contentPadding: EdgeInsets.zero),
        StatsColumn(
          stats: [
            Stat(name: Text(l10n.damageTitle), value: Text('${melee.heavyAttackDamage}')),
            Stat(name: Text(l10n.heavySlamAttackTitle), value: Text('${melee.heavySlamAttack}')),
            Stat(name: Text(l10n.heavySlamRadialDamageTitle), value: Text('${melee.heavySlamRadialDamage}')),
            Stat(name: Text(l10n.heavySlamRadiusTitle), value: Text('${melee.heavySlamRadius?.toDouble() ?? 0}')),
            Stat(name: Text(l10n.windUpTitle), value: Text('${melee.windUp?.toStringAsFixed(2) ?? 0}')),
          ],
        ),
        Gaps.gap16,
        CategoryTitle(title: l10n.damageTitle, contentPadding: EdgeInsets.zero),
        if (melee.damage != null) DamageSection(damage: melee.damage!),
      ],
    );
  }
}
