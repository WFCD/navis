import 'package:flutter/material.dart';
import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class DamageSection extends StatelessWidget {
  const DamageSection({super.key, required this.damage});

  final Damage damage;

  String _statRoundDouble(num stat) {
    return stat.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Column(
      children: [
        StatsColumn(
          stats: [
            Stat(
              name: Text(l10n.impactDamageTitle),
              value: Text(_statRoundDouble(damage.impact)),
              isVisible: damage.impact > 0,
            ),
            Stat(
              name: Text(l10n.punctureDamageTitle),
              value: Text(_statRoundDouble(damage.puncture)),
              isVisible: damage.puncture > 0,
            ),
            Stat(
              name: Text(l10n.slashDamageTitle),
              value: Text(_statRoundDouble(damage.slash)),
              isVisible: damage.slash > 0,
            ),
            Stat(
              name: Text(l10n.heatDamageTitle),
              value: Text(_statRoundDouble(damage.heat)),
              isVisible: damage.heat > 0,
            ),
            Stat(
              name: Text(l10n.coldDamageTitle),
              value: Text(_statRoundDouble(damage.cold)),
              isVisible: damage.cold > 0,
            ),
            Stat(
              name: Text(l10n.electricityDamageTitle),
              value: Text(_statRoundDouble(damage.electricity)),
              isVisible: damage.electricity > 0,
            ),
            Stat(
              name: Text(l10n.toxinDamageTitle),
              value: Text(_statRoundDouble(damage.toxin)),
              isVisible: damage.toxin > 0,
            ),
            Stat(
              name: Text(l10n.blastDamageTitle),
              value: Text(_statRoundDouble(damage.blast)),
              isVisible: damage.blast > 0,
            ),
            Stat(
              name: Text(l10n.radiationDamageTitle),
              value: Text(_statRoundDouble(damage.radiation)),
              isVisible: damage.radiation > 0,
            ),
            Stat(name: Text(l10n.gasDamageTitle), value: Text(_statRoundDouble(damage.gas)), isVisible: damage.gas > 0),
            Stat(
              name: Text(l10n.magneticDamageTitle),
              value: Text(_statRoundDouble(damage.magnetic)),
              isVisible: damage.magnetic > 0,
            ),
            Stat(
              name: Text(l10n.viralDamageTitle),
              value: Text(_statRoundDouble(damage.viral)),
              isVisible: damage.viral > 0,
            ),
            Stat(
              name: Text(l10n.corrosiveDamageTitle),
              value: Text(_statRoundDouble(damage.corrosive)),
              isVisible: damage.corrosive > 0,
            ),
            Stat(
              name: Text(l10n.voidDamageTitle),
              value: Text(_statRoundDouble(damage.voidDamage)),
              isVisible: damage.voidDamage > 0,
            ),
            Stat(name: Text(l10n.tauDamageTitle), value: Text(_statRoundDouble(damage.tau)), isVisible: damage.tau > 0),
            Stat(
              name: Text(l10n.cinematicDamageTitle),
              value: Text(_statRoundDouble(damage.cinematic)),
              isVisible: damage.cinematic > 0,
            ),
            Stat(
              name: Text(l10n.shieldDrainDamageTitle),
              value: Text(_statRoundDouble(damage.shieldDrain)),
              isVisible: damage.shieldDrain > 0,
            ),
            Stat(
              name: Text(l10n.healthDrainDamageTitle),
              value: Text(_statRoundDouble(damage.healthDrain)),
              isVisible: damage.healthDrain > 0,
            ),
            Stat(
              name: Text(l10n.physicalDamageTitle),
              value: Text(_statRoundDouble(damage.trueDamage)),
              isVisible: damage.trueDamage > 0,
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 16, bottom: 8),
          child: RowItem(
            text: Text(l10n.totalDamageTitle, style: textStyle),
            child: Text(_statRoundDouble(damage.total), style: textStyle),
          ),
        ),
      ],
    );
  }
}
