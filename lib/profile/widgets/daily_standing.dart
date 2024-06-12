import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DailyStandingCard extends StatelessWidget {
  const DailyStandingCard({
    super.key,
    required this.rank,
    required this.dailyStanding,
  });

  final int rank;
  final DailyStanding dailyStanding;

  @override
  Widget build(BuildContext context) {
    final standingCap = 16000 + (rank * 500);
    final numberFormat = NumberFormat();

    return AppCard(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListTile(
        title: const Text('Syndicates'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text('Max Standing', style: context.textTheme.bodySmall),
            Text(
              numberFormat.format(standingCap),
              style: context.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class StandingContent extends StatelessWidget {
  const StandingContent({
    super.key,
    required this.title,
    required this.max,
    required this.standing,
    this.color,
  });

  final String title;
  final int max;
  final int standing;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final titleStyle = context.textTheme.titleMedium;
    final numberFormat = NumberFormat();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: titleStyle),
              Text(numberFormat.format(standing), style: titleStyle),
            ],
          ),
          const Gap(6),
          LinearProgressIndicator(value: standing / max, color: color),
        ],
      ),
    );
  }
}
