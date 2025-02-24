import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/codex/widgets/codex_entry/damage.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class GunStats extends StatelessWidget {
  const GunStats({super.key, required this.gun});

  final Gun gun;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final isBuildable = gun is BuildableItem;

    return Column(
      children: [
        CategoryTitle(title: context.l10n.statsTitle, contentPadding: EdgeInsets.zero),
        Gaps.gap8,
        Stats(
          stats: <RowItem>[
            if (isBuildable && (gun as BuildableItem).masteryReq != null)
              RowItem(text: Text(l10n.masteryRequirementTitle), child: Text('${(gun as BuildableItem).masteryReq}')),
            RowItem(text: Text(l10n.weaponTypeTitle), child: Text(gun.type.type)),
            if (gun.polarities?.isNotEmpty ?? false)
              RowItem(
                text: Text(l10n.preinstalledPolarities),
                child: PreinstalledPolarties(polarities: gun.polarities ?? <String>[]),
              ),
            if (gun.accuracy != null)
              RowItem(text: Text(l10n.accuracyTitle), child: Text('${statRoundDouble(gun.accuracy!, 2)}')),
            RowItem(
              text: Text(l10n.criticalChanceTitle),
              child: Text('${statRoundDouble(gun.criticalChance * 100, 2)}%'),
            ),
            RowItem(text: Text(l10n.cricticalMultiplierTitle), child: Text('${gun.criticalMultiplier}x')),
            RowItem(text: Text(l10n.fireRateTitle), child: Text(gun.fireRate.toStringAsFixed(2))),
            RowItem(text: Text(l10n.magazineTitle), child: Text('${gun.magazineSize}')),
            if (gun.multishot != null && gun.multishot! > 1.0)
              RowItem(text: Text(l10n.multishotTitle), child: Text('${statRoundDouble(gun.multishot!, 2)}%')),
            if (gun.noise != null) RowItem(text: Text(l10n.noiseTitle), child: Text(gun.noise!.toUpperCase())),
            if (gun.reloadTime != null)
              RowItem(text: Text(l10n.reloadTitle), child: Text(gun.reloadTime!.toStringAsFixed(2))),
            if (gun.disposition != null)
              RowItem(text: Text(l10n.rivenDispositionTitle), child: RivenDisposition(disposition: gun.disposition!)),
            RowItem(text: Text(l10n.statusChanceTitle), child: Text('${(gun.procChance * 100).roundToDouble()}%')),
            if (gun.trigger != null) RowItem(text: Text(l10n.triggerTitle), child: Text(gun.trigger!)),
          ],
        ),
        Gaps.gap16,
        CategoryTitle(title: l10n.damageTitle, contentPadding: EdgeInsets.zero),
        if (gun.damage != null) DamageSection(damage: gun.damage!),
        Gaps.gap16,
      ],
    );
  }
}
