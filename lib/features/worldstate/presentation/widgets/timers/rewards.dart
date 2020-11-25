import 'package:flutter/material.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:navis/core/widgets/countdown.dart';
import 'package:navis/core/widgets/custom_card.dart';

class DailyReward extends StatelessWidget {
  const DailyReward({Key key}) : super(key: key);

  DateTime get endOfDay {
    final now = DateTime.now().toUtc();

    return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999)
        .add(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        title: Text(context.locale.dailyRewardTitle),
        trailing: CountdownTimer(expiry: endOfDay),
      ),
    );
  }
}
