import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';

class DailyReward extends StatelessWidget {
  const DailyReward({super.key});

  DateTime get _endOfDay {
    final now = DateTime.timestamp();

    return DateTime.utc(now.year, now.month, now.day, 23, 59, 59, 999).add(const Duration(seconds: 60));
  }

  bool _buildWhen(WorldState previous, WorldState next) {
    if (next is! WorldstateSuccess) return false;
    final timestamp = next.seed.timestamp;

    return timestamp.isAfter(_endOfDay) || timestamp.isAtSameMomentAs(_endOfDay);
  }

  @override
  Widget build(BuildContext context) {
    // If we don't tie it to something it would require rebuilding the widget to refresh. So use the worldstate as a
    // way to rebuild it at the end of the day
    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          return ListTile(
            title: Text(context.l10n.dailyRewardTitle),
            trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(_endOfDay), expiry: _endOfDay),
          );
        },
      ),
    );
  }
}
