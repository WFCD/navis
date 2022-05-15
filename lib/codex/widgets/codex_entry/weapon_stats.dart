import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:navis/codex/widgets/codex_entry/polarity.dart';
import 'package:navis/codex/widgets/codex_entry/stats.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

double _roundDouble(double value, int places) {
  final mod = math.pow(10.0, places);

  return (value * mod).roundToDouble() / mod;
}

class GunStats extends StatelessWidget {
  const GunStats({super.key, required this.projectileWeapon});

  final ProjectileWeapon projectileWeapon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
                child: Text('${_roundDouble(projectileWeapon.accuracy!, 1)}'),
              ),
            RowItem(
              text: Text(l10n.cricticalChanceTitle),
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
                child: Text('${_roundDouble(projectileWeapon.reloadTime!, 1)}'),
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
              )
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
            style: Theme.of(context).textTheme.subtitle1,
          ),
          child: Text(
            '${_roundDouble(projectileWeapon.totalDamage, 1)}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        )
      ],
    );
  }
}

class MeleeStats extends StatelessWidget {
  const MeleeStats({super.key, required this.meleeWeapon});

  final MeleeWeapon meleeWeapon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final totalDamage = _roundDouble(meleeWeapon.totalDamage, 1);

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
              text: Text(l10n.cricticalChanceTitle),
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
            style: Theme.of(context).textTheme.subtitle1,
          ),
          child: Text(
            '$totalDamage',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
      ],
    );
  }
}

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({super.key, required this.disposition});

  final int disposition;

  Widget _buildDot(Color color, bool enable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        constraints: const BoxConstraints.expand(width: 15, height: 15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: color),
          color: enable ? color : Colors.transparent,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const maxDisposition = 5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (int i = 0; i < maxDisposition; i++)
          _buildDot(Theme.of(context).colorScheme.secondary, i < disposition)
      ],
    );
  }
}
