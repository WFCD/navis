import 'package:flutter/material.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis_ui/navis_ui.dart';

class DailyReward extends StatelessWidget {
  const DailyReward({Key? key}) : super(key: key);

  DateTime get endOfDay {
    final now = DateTime.now().toUtc();

    return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999)
        .add(kDelayShort);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        title: Text(context.l10n.dailyRewardTitle),
        trailing: CountdownTimer(
          tooltip: context.l10n.countdownTooltip(endOfDay),
          expiry: endOfDay,
        ),
      ),
    );
  }
}
