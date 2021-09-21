import 'package:flutter/material.dart';
import '../../../../../constants/default_durations.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';

class DailyReward extends StatelessWidget {
  const DailyReward({Key? key}) : super(key: key);

  DateTime get endOfDay {
    final now = DateTime.now().toUtc();

    return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999)
        .add(kDelayShort);
  }

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        title: Text(context.l10n.dailyRewardTitle),
        trailing: CountdownTimer(expiry: endOfDay),
      ),
    );
  }
}
