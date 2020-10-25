import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';
import 'stats.dart';

class GunStats extends StatelessWidget {
  const GunStats({
    Key key,
    @required this.masteryReq,
    @required this.category,
    @required this.type,
    @required this.accuracy,
    @required this.criticalChance,
    @required this.criticalMultiplier,
    @required this.fireRate,
    @required this.magazineSize,
    @required this.multishot,
    @required this.noise,
    @required this.reload,
    @required this.disposition,
    @required this.procChance,
    @required this.trigger,
    @required this.damageTypes,
  }) : super(key: key);

  final int masteryReq;
  final String category, type;
  final double accuracy, criticalChance, criticalMultiplier;
  final double fireRate;
  final int magazineSize;
  final double multishot;
  final String noise;
  final double reload;
  final int disposition;
  final double procChance;
  final String trigger;
  final Map<String, double> damageTypes;

  double get totalDamage {
    return damageTypes.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
          CategoryTitle(title: category, addPadding: false),
          const SizedBox(height: 8.0),
          Stats(
            stats: <RowItem>[
              RowItem(
                text: const Text('Mastery Requirement'),
                child: Text('$masteryReq'),
              ),
              RowItem(
                text: const Text('Type'),
                child: Text(type),
              ),
              RowItem(
                text: const Text('Accuracy'),
                child: Text('${roundDouble(accuracy, 1)}'),
              ),
              RowItem(
                text: const Text('Critical Chance'),
                child: Text('${(criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: const Text('Critical Multiplier'),
                child: Text('${criticalMultiplier}x'),
              ),
              RowItem(
                text: const Text('Fire Rate'),
                child: Text('${fireRate.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Magazine'),
                child: Text('$magazineSize'),
              ),
              RowItem(
                text: const Text('Multishot'),
                child: Text('$multishot'),
              ),
              RowItem(
                text: const Text('Noise'),
                child: Text('${noise.toUpperCase()}'),
              ),
              RowItem(
                text: const Text('Reload'),
                child: Text('${roundDouble(reload, 1)}'),
              ),
              RowItem(
                text: const Text('Riven Disposition'),
                child: RivenDisposition(disposition: disposition),
              ),
              RowItem(
                text: const Text('Status Chance'),
                child: Text('${(procChance * 100).roundToDouble()}%'),
              ),
              if (trigger != null)
                RowItem(
                  text: const Text('Trigger'),
                  child: Text(trigger),
                )
            ],
          ),
          const SizedBox(height: 16.0),
          const CategoryTitle(title: 'Damage', addPadding: false),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 34.0),
            child: Stats(stats: <RowItem>[
              for (final damageType in damageTypes.keys)
                RowItem(
                  text: Text(toBeginningOfSentenceCase(damageType)),
                  child: Text('${damageTypes[damageType]}'),
                ),
            ]),
          ),
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
  const MeleeStats({
    Key key,
    @required this.masteryReq,
    @required this.category,
    @required this.type,
    @required this.criticalChance,
    @required this.criticalMultiplier,
    @required this.attackSpeed,
    @required this.disposition,
    @required this.procChance,
    @required this.damageTypes,
  }) : super(key: key);

  final int masteryReq;
  final String category, type;
  final double criticalChance, criticalMultiplier;
  final double attackSpeed;
  final int disposition;
  final double procChance;
  final Map<String, double> damageTypes;

  double get totalDamage {
    return damageTypes.values
        .fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      child: Column(
        children: [
          CategoryTitle(title: category, addPadding: false),
          const SizedBox(height: 8.0),
          Stats(
            stats: <RowItem>[
              RowItem(
                text: const Text('Mastery Requirement'),
                child: Text('$masteryReq'),
              ),
              RowItem(
                text: const Text('Type'),
                child: Text(type),
              ),
              RowItem(
                text: const Text('Critical Chance'),
                child: Text('${(criticalChance * 100).roundToDouble()}%'),
              ),
              RowItem(
                text: const Text('Critical Multiplier'),
                child: Text('${criticalMultiplier}x'),
              ),
              RowItem(
                text: const Text('Attack Speed'),
                child: Text('${attackSpeed.toStringAsFixed(2)}'),
              ),
              RowItem(
                text: const Text('Riven Disposition'),
                child: RivenDisposition(disposition: disposition),
              ),
              RowItem(
                text: const Text('Status Chance'),
                child: Text('${(procChance * 100).roundToDouble()}%'),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          const CategoryTitle(title: 'Damage', addPadding: false),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 34.0),
            child: Stats(stats: <RowItem>[
              for (final damageType in damageTypes.keys)
                RowItem(
                  text: Text(toBeginningOfSentenceCase(damageType)),
                  child: Text('${damageTypes[damageType]}'),
                ),
            ]),
          ),
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

class RivenDisposition extends StatelessWidget {
  const RivenDisposition({Key key, @required this.disposition})
      : super(key: key);

  final int disposition;

  Widget _buildDot(BuildContext context, bool enable) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        constraints: const BoxConstraints.expand(width: 15.0, height: 15.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Theme.of(context).accentColor),
            color: enable ? Theme.of(context).accentColor : Colors.transparent),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          for (int i = 0; i < 5; i++) _buildDot(context, i < disposition)
        ],
      ),
    );
  }
}
