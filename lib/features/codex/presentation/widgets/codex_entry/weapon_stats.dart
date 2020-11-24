import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warframestat_api_models/entities.dart';

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
                text: const Text('Mastery Requirement'),
                child: Text('${projectileWeapon.masteryReq}'),
              ),
              RowItem(
                text: const Text('Type'),
                child: Text(projectileWeapon.type),
              ),
              if (projectileWeapon.polarities.isNotEmpty)
                RowItem(
                  text: const Text('Polarities'),
                  child: PreinstalledPolarties(
                    polarities: projectileWeapon.polarities,
                  ),
                ),
              RowItem(
                text: const Text('Accuracy'),
                child: Text('${roundDouble(projectileWeapon.accuracy, 1)}'),
              ),
              RowItem(
                text: const Text('Critical Chance'),
                child: Text(
                    '${(projectileWeapon.criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: const Text('Critical Multiplier'),
                child: Text('${projectileWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: const Text('Fire Rate'),
                child: Text('${projectileWeapon.fireRate.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Magazine'),
                child: Text('${projectileWeapon.magazineSize}'),
              ),
              RowItem(
                text: const Text('Multishot'),
                child: Text('${projectileWeapon.multishot}'),
              ),
              RowItem(
                text: const Text('Noise'),
                child: Text('${projectileWeapon.noise.toUpperCase()}'),
              ),
              RowItem(
                text: const Text('Reload'),
                child: Text('${roundDouble(projectileWeapon.reloadTime, 1)}'),
              ),
              RowItem(
                text: const Text('Riven Disposition'),
                child:
                    RivenDisposition(disposition: projectileWeapon.disposition),
              ),
              RowItem(
                text: const Text('Status Chance'),
                child: Text(
                    '${(projectileWeapon.statusChance * 100).roundToDouble()}%'),
              ),
              if (projectileWeapon.trigger != null)
                RowItem(
                  text: const Text('Trigger'),
                  child: Text(projectileWeapon.trigger),
                )
            ],
          ),
          const SizedBox(height: 16.0),
          const CategoryTitle(
            title: 'Damage',
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
              'Total',
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
                text: const Text('Mastery Requirement'),
                child: Text('${meleeWeapon.masteryReq}'),
              ),
              RowItem(
                text: const Text('Type'),
                child: Text(meleeWeapon.type),
              ),
              RowItem(
                text: const Text('Stance Polarity'),
                child: Polarity(polarity: meleeWeapon.stancePolarity),
              ),
              if (meleeWeapon.polarities.isNotEmpty)
                RowItem(
                  text: const Text('Polarities'),
                  child: PreinstalledPolarties(
                    polarities: meleeWeapon.polarities,
                  ),
                ),
              RowItem(
                text: const Text('Attack Speed'),
                child: Text('${meleeWeapon.attackSpeed.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Critical Chance'),
                child: Text(
                    '${(meleeWeapon.criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: const Text('Critical Multiplier'),
                child: Text('${meleeWeapon.criticalMultiplier}x'),
              ),
              RowItem(
                text: const Text('Follow Through'),
                child: Text('${meleeWeapon.followThrough.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Range'),
                child: Text('${meleeWeapon.range.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Slam Attack'),
                child: Text('${meleeWeapon.slamAttack}'),
              ),
              RowItem(
                text: const Text('Slam Radial Damage'),
                child: Text('${meleeWeapon.slamRadialDamage}'),
              ),
              RowItem(
                text: const Text('Slam Radius'),
                child: Text('${meleeWeapon.slamRadius.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Slide Attack'),
                child: Text('${meleeWeapon.slideAttack}'),
              ),
              RowItem(
                text: const Text('Riven Disposition'),
                child: RivenDisposition(disposition: meleeWeapon.disposition),
              ),
              RowItem(
                text: const Text('Status Chance'),
                child: Text(
                    '${(meleeWeapon.statusChance * 100).roundToDouble()}%'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const CategoryTitle(
            title: 'Damage',
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
              'Total',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            child: Text(
              '${roundDouble(totalDamage, 1)}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          const CategoryTitle(
            title: 'Heavy Attack',
            contentPadding: EdgeInsets.zero,
          ),
          Stats(stats: [
            RowItem(
              text: const Text('Damage'),
              child: Text('${meleeWeapon.heavyAttackDamage}'),
            ),
            RowItem(
              text: const Text('Slam Attack'),
              child: Text('${meleeWeapon.heavySlamAttack}'),
            ),
            RowItem(
              text: const Text('Slam Radial Damage'),
              child: Text('${meleeWeapon.heavySlamRadialDamage}'),
            ),
            RowItem(
              text: const Text('Slam Radius'),
              child: Text('${meleeWeapon.heavySlamRadius.toDouble()}'),
            ),
            RowItem(
              text: const Text('Wind Up'),
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
