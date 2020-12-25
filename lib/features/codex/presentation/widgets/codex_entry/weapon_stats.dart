import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import 'polarity.dart';
import 'stats.dart';

class GunStats extends StatelessWidget {
  const GunStats({Key key, @required this.projectileWeapon})
      : assert(projectileWeapon != null),
        super(key: key);

  final ProjectileWeapon projectileWeapon;

  double get totalDamage {
    return projectileWeapon.damageTypes.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
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
                text: Text(context.locale.masteryRequirementTitle),
                child: Text('${projectileWeapon.masteryReq}'),
              ),
              RowItem(
                text: Text(context.locale.weaponTypeTitle),
                child: Text(projectileWeapon.type),
              ),
              if (projectileWeapon.polarities.isNotEmpty)
                RowItem(
                  text: Text(context.locale.preinstalledPolarities),
                  child: PreinstalledPolarties(
                    polarities: projectileWeapon.polarities,
                  ),
                ),
              RowItem(
                text: Text(context.locale.accuracyTitle),
                child: Text('${roundDouble(projectileWeapon.accuracy, 1)}'),
              ),
              RowItem(
                text: Text(context.locale.cricticalChanceTitle),
                child: Text(
                    '${(projectileWeapon.criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: Text(context.locale.cricticalMultiplierTitle),
                child: Text('${projectileWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: Text(context.locale.fireRateTitle),
                child: Text('${projectileWeapon.fireRate.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(context.locale.magazineTitle),
                child: Text('${projectileWeapon.magazineSize}'),
              ),
              RowItem(
                text: Text(context.locale.multishotTitle),
                child: Text('${projectileWeapon.multishot}'),
              ),
              RowItem(
                text: Text(context.locale.noiseTitle),
                child: Text('${projectileWeapon.noise.toUpperCase()}'),
              ),
              RowItem(
                text: Text(context.locale.reloadTitle),
                child: Text('${roundDouble(projectileWeapon.reloadTime, 1)}'),
              ),
              RowItem(
                text: Text(context.locale.rivenDispositionTitle),
                child:
                    RivenDisposition(disposition: projectileWeapon.disposition),
              ),
              RowItem(
                text: Text(context.locale.statusChanceTitle),
                child: Text(
                    '${(projectileWeapon.statusChance * 100).roundToDouble()}%'),
              ),
              if (projectileWeapon.trigger != null)
                RowItem(
                  text: Text(context.locale.triggerTitle),
                  child: Text(projectileWeapon.trigger),
                )
            ],
          ),
          const SizedBox(height: 16.0),
          CategoryTitle(
            title: context.locale.damageTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: <RowItem>[
            for (final damageType in projectileWeapon.damageTypes.keys)
              RowItem(
                text: Text(toBeginningOfSentenceCase(damageType)),
                child: Text('${projectileWeapon.damageTypes[damageType]}'),
              ),
          ]),
          const SizedBox(height: 16.0),
          RowItem(
            text: Text(
              context.locale.totalDamageTitle,
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

class MeleeStats extends StatelessWidget {
  const MeleeStats({Key key, @required this.meleeWeapon}) : super(key: key);

  final MeleeWeapon meleeWeapon;

  double get totalDamage {
    return meleeWeapon.damageTypes.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
          Stats(
            stats: <RowItem>[
              RowItem(
                text: Text(context.locale.masteryRequirementTitle),
                child: Text('${meleeWeapon.masteryReq}'),
              ),
              RowItem(
                text: Text(context.locale.weaponTypeTitle),
                child: Text(meleeWeapon.type),
              ),
              RowItem(
                text: Text(context.locale.stancePolarityTitle),
                child: Polarity(polarity: meleeWeapon.stancePolarity),
              ),
              if (meleeWeapon.polarities.isNotEmpty)
                RowItem(
                  text: Text(context.locale.preinstalledPolarities),
                  child: PreinstalledPolarties(
                    polarities: meleeWeapon.polarities,
                  ),
                ),
              RowItem(
                text: Text(context.locale.attackSpeedTitle),
                child: Text('${meleeWeapon.attackSpeed.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(context.locale.cricticalChanceTitle),
                child: Text(
                    '${(meleeWeapon.criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: Text(context.locale.cricticalMultiplierTitle),
                child: Text('${meleeWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: Text(context.locale.followThroughTitle),
                child: Text('${meleeWeapon.followThrough.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(context.locale.rangeTitle),
                child: Text('${meleeWeapon.range.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(context.locale.slamAttackTitle),
                child: Text('${meleeWeapon.slamAttack}'),
              ),
              RowItem(
                text: Text(context.locale.slamRadialDamageTitle),
                child: Text('${meleeWeapon.slamRadialDamage}'),
              ),
              RowItem(
                text: Text(context.locale.slamRadiusTitle),
                child: Text('${meleeWeapon.slamRadius.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: Text(context.locale.slideAttackTitle),
                child: Text('${meleeWeapon.slideAttack}'),
              ),
              RowItem(
                text: Text(context.locale.rivenDispositionTitle),
                child: RivenDisposition(disposition: meleeWeapon.disposition),
              ),
              RowItem(
                text: Text(context.locale.statusChanceTitle),
                child: Text(
                    '${(meleeWeapon.statusChance * 100).roundToDouble()}%'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          CategoryTitle(
            title: context.locale.damageTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: <RowItem>[
            for (final damageType in meleeWeapon.damageTypes.keys)
              RowItem(
                text: Text(toBeginningOfSentenceCase(damageType)),
                child: Text('${meleeWeapon.damageTypes[damageType]}'),
              ),
          ]),
          const SizedBox(height: 16.0),
          RowItem(
            text: Text(
              context.locale.totalDamageTitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            child: Text(
              '${roundDouble(totalDamage, 1)}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          CategoryTitle(
            title: context.locale.heavyAttackTitle,
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: [
            RowItem(
              text: Text(context.locale.damageTitle),
              child: Text('${meleeWeapon.heavyAttackDamage}'),
            ),
            RowItem(
              text: Text(context.locale.heavySlamAttackTitle),
              child: Text('${meleeWeapon.heavySlamAttack}'),
            ),
            RowItem(
              text: Text(context.locale.heavySlamRadialDamageTitle),
              child: Text('${meleeWeapon.heavySlamRadialDamage}'),
            ),
            RowItem(
              text: Text(context.locale.heavySlamRadiusTitle),
              child: Text('${meleeWeapon.heavySlamRadius.toDouble()}'),
            ),
            RowItem(
              text: Text(context.locale.windUpTitle),
              child: Text('${meleeWeapon.windUp.toStringAsFixed(2)}'),
            ),
          ])
        ],
      ),
    );
  }
}

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({Key key, @required this.disposition})
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

    return Container(
      child: Row(
        children: [
          for (int i = 0; i < maxDisposition; i++)
            _buildDot(Theme.of(context).accentColor, i < disposition)
        ],
      ),
    );
  }
}
