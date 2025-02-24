import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DamageSection extends StatelessWidget {
  const DamageSection({super.key, required this.damage});

  final Damage damage;

  String _statRoundDouble(num stat) {
    return '${statRoundDouble(stat.toDouble(), 1)}';
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textStyle = Theme.of(context).textTheme.titleMedium;

    return Column(
      children: [
        Stats(
          stats: [
            if (damage.impact > 0)
              RowItem(text: Text(l10n.impactDamageTitle), child: Text(_statRoundDouble(damage.impact))),
            if (damage.puncture > 0)
              RowItem(text: Text(l10n.punctureDamageTitle), child: Text(_statRoundDouble(damage.puncture))),
            if (damage.slash > 0)
              RowItem(text: Text(l10n.slashDamageTitle), child: Text(_statRoundDouble(damage.slash))),
            if (damage.heat > 0) RowItem(text: Text(l10n.heatDamageTitle), child: Text(_statRoundDouble(damage.heat))),
            if (damage.cold > 0) RowItem(text: Text(l10n.coldDamageTitle), child: Text(_statRoundDouble(damage.cold))),
            if (damage.electricity > 0)
              RowItem(text: Text(l10n.electricityDamageTitle), child: Text(_statRoundDouble(damage.electricity))),
            if (damage.toxin > 0)
              RowItem(text: Text(l10n.toxinDamageTitle), child: Text(_statRoundDouble(damage.toxin))),
            if (damage.blast > 0)
              RowItem(text: Text(l10n.blastDamageTitle), child: Text(_statRoundDouble(damage.blast))),
            if (damage.radiation > 0)
              RowItem(text: Text(l10n.radiationDamageTitle), child: Text(_statRoundDouble(damage.radiation))),
            if (damage.gas > 0) RowItem(text: Text(l10n.gasDamageTitle), child: Text(_statRoundDouble(damage.gas))),
            if (damage.magnetic > 0)
              RowItem(text: Text(l10n.magneticDamageTitle), child: Text(_statRoundDouble(damage.magnetic))),
            if (damage.viral > 0)
              RowItem(text: Text(l10n.viralDamageTitle), child: Text(_statRoundDouble(damage.viral))),
            if (damage.corrosive > 0)
              RowItem(text: Text(l10n.corrosiveDamageTitle), child: Text(_statRoundDouble(damage.corrosive))),
            if (damage.voidDamage > 0)
              RowItem(text: Text(l10n.voidDamageTitle), child: Text(_statRoundDouble(damage.voidDamage))),
            if (damage.tau > 0) RowItem(text: Text(l10n.tauDamageTitle), child: Text(_statRoundDouble(damage.tau))),
            if (damage.cinematic > 0)
              RowItem(text: Text(l10n.cinematicDamageTitle), child: Text(_statRoundDouble(damage.cinematic))),
            if (damage.shieldDrain > 0)
              RowItem(text: Text(l10n.shieldDrainDamageTitle), child: Text(_statRoundDouble(damage.shieldDrain))),
            if (damage.healthDrain > 0)
              RowItem(text: Text(l10n.healthDrainDamageTitle), child: Text(_statRoundDouble(damage.healthDrain))),
            if (damage.trueDamage > 0)
              RowItem(text: Text(l10n.physicalDamageTitle), child: Text(_statRoundDouble(damage.trueDamage))),
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
