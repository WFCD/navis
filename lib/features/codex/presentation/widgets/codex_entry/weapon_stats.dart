import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import 'polarity.dart';
import 'stats.dart';

class GunStats extends StatelessWidget {
  const GunStats({Key? key, required this.projectileWeapon}) : super(key: key);

  final ProjectileWeapon projectileWeapon;

  double get totalDamage {
    return projectileWeapon.damageTypes!.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
          CategoryTitle(
            title: projectileWeapon.category,
            contentPadding: EdgeInsets.zero,
          ),
          const SizedBox(height: 8.0),
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
              RowItem(
                text: Text(l10n.accuracyTitle),
                child: Text('${roundDouble(projectileWeapon.accuracy, 1)}'),
              ),
              RowItem(
                text: Text(l10n.cricticalChanceTitle),
                child: Text('''
${(projectileWeapon.criticalChance * 100).roundToDouble()}%'''),
              ),
              RowItem(
                text: Text(l10n.cricticalMultiplierTitle),
                child: Text('${projectileWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: Text(l10n.fireRateTitle),
                child: Text('${projectileWeapon.fireRate.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(l10n.magazineTitle),
                child: Text('${projectileWeapon.magazineSize}'),
              ),
              RowItem(
                text: Text(l10n.multishotTitle),
                child: Text('${projectileWeapon.multishot}'),
              ),
              RowItem(
                text: Text(l10n.noiseTitle),
                child: Text('${projectileWeapon.noise.toUpperCase()}'),
              ),
              RowItem(
                text: Text(l10n.reloadTitle),
                child: Text('${roundDouble(projectileWeapon.reloadTime, 1)}'),
              ),
              RowItem(
                text: Text(l10n.rivenDispositionTitle),
                child: RivenDisposition(
                  disposition: projectileWeapon.disposition ?? 0,
                ),
              ),
              RowItem(
                text: Text(l10n.statusChanceTitle),
                child: Text('''
${(projectileWeapon.statusChance * 100).roundToDouble()}%'''),
              ),
              RowItem(
                text: Text(l10n.triggerTitle),
                child: Text(projectileWeapon.trigger),
              )
            ],
          ),
          const SizedBox(height: 16.0),
          CategoryTitle(
            title: l10n.damageTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: <RowItem>[
            for (final damageType in projectileWeapon.damageTypes!.keys)
              RowItem(
                text: Text(toBeginningOfSentenceCase(damageType)!),
                child: Text('${projectileWeapon.damageTypes![damageType]}'),
              ),
          ]),
          const SizedBox(height: 16.0),
          RowItem(
            text: Text(
              l10n.totalDamageTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            child: Text(
              '${roundDouble(totalDamage, 1)}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          )
        ],
      ),
    );
  }
}

double? totalDamageCalc(Map<String, num>? damageTypes) {
  return damageTypes?.values.fold(0.0, (previous, next) => previous! + next);
}

class MeleeStats extends StatelessWidget {
  const MeleeStats({Key? key, required this.meleeWeapon}) : super(key: key);

  final MeleeWeapon meleeWeapon;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final totalDamage =
        roundDouble(totalDamageCalc(meleeWeapon.damageTypes) ?? 0, 1);

    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
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
                child: Text('${meleeWeapon.attackSpeed.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(l10n.cricticalChanceTitle),
                child: Text(
                    '${(meleeWeapon.criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: Text(l10n.cricticalMultiplierTitle),
                child: Text('${meleeWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: Text(l10n.followThroughTitle),
                child: Text(
                    '${meleeWeapon.followThrough?.toStringAsFixed(2) ?? 0}'),
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
                child:
                    Text('${meleeWeapon.slamRadius?.toStringAsFixed(2) ?? 0}'),
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
                child: Text(
                    '${(meleeWeapon.statusChance * 100).roundToDouble()}%'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CategoryTitle(
            title: l10n.damageTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: <RowItem>[
            for (final damageType
                in meleeWeapon.damageTypes?.keys ?? <String>[])
              RowItem(
                text: Text(toBeginningOfSentenceCase(damageType)!),
                child: Text('${meleeWeapon.damageTypes?[damageType]}'),
              ),
          ]),
          const SizedBox(height: 16.0),
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
          CategoryTitle(
            title: l10n.heavyAttackTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: [
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
          ])
        ],
      ),
    );
  }
}

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({Key? key, required this.disposition})
      : super(key: key);

  final int disposition;

  Widget _buildDot(Color color, bool enable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        constraints: const BoxConstraints.expand(width: 15.0, height: 15.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color),
            color: enable ? color : Colors.transparent),
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
          _buildDot(Theme.of(context).accentColor, i < disposition)
      ],
    );
  }
}
