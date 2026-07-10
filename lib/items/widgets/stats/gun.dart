import 'package:flutter/material.dart';

import 'package:navis/items/items.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class GunStats extends StatelessWidget {
  const GunStats({super.key, required this.gun});

  final Gun gun;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final multishot = gun.multishot;
    final masteryReq = switch (gun) {
      BuildableItem(:final masteryReq) => masteryReq,
      _ => null,
    };

    return Column(
      children: [
        CategoryTitle(title: context.l10n.statsTitle, contentPadding: EdgeInsets.zero),
        Gaps.gap8,
        StatsColumn(
          stats: [
            Stat(
              name: Text(l10n.masteryRequirementTitle),
              value: Text(masteryReq.toString()),
              isVisible: masteryReq != null,
            ),
            Stat(name: Text(l10n.weaponTypeTitle), value: Text(gun.type.type)),
            Stat(
              name: Text(l10n.preinstalledPolarities),
              value: PreinstalledPolarties(polarities: gun.polarities ?? <String>[]),
              isVisible: gun.polarities?.isNotEmpty ?? false,
            ),
            Stat(
              name: Text(l10n.accuracyTitle),
              value: Text(gun.accuracy!.toStringAsFixed(2)),
              isVisible: gun.accuracy != null,
            ),
            Stat(
              name: Text(l10n.criticalChanceTitle),
              value: Text('${(gun.criticalChance * 100).toStringAsFixed(2)}%'),
            ),
            Stat(name: Text(l10n.cricticalMultiplierTitle), value: Text('${gun.criticalMultiplier}x')),
            Stat(name: Text(l10n.fireRateTitle), value: Text(gun.fireRate.toStringAsFixed(2))),
            Stat(name: Text(l10n.magazineTitle), value: Text('${gun.magazineSize}')),
            Stat(
              name: Text(l10n.multishotTitle),
              value: Text('${gun.multishot!.toStringAsFixed(2)}%'),
              isVisible: multishot != null && multishot > 0,
            ),
            Stat(name: Text(l10n.noiseTitle), value: Text(gun.noise!.toUpperCase()), isVisible: gun.noise != null),
            Stat(
              name: Text(l10n.reloadTitle),
              value: Text(gun.reloadTime!.toStringAsFixed(2)),
              isVisible: gun.reloadTime != null,
            ),
            Stat(
              name: Text(l10n.rivenDispositionTitle),
              value: RivenDisposition(disposition: gun.disposition!),
              isVisible: gun.disposition != null,
            ),
            Stat(name: Text(l10n.statusChanceTitle), value: Text('${(gun.procChance * 100).roundToDouble()}%')),
            Stat(name: Text(l10n.triggerTitle), value: Text(gun.trigger!), isVisible: gun.trigger != null),
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
