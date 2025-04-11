import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';

class DailyReward extends StatelessWidget {
  const DailyReward({super.key});

  bool _buildWhen(WorldState previous, WorldState next) {
    if (next is! WorldstateSuccess) return false;
    final timestamp = next.seed.timestamp;
    final daily = dailyReset();
    final weekly = weeklReset();

    return timestamp.isAfter(daily) ||
        timestamp.isAtSameMomentAs(daily) ||
        timestamp.isAfter(weekly) ||
        timestamp.isAtSameMomentAs(weekly);
  }

  @override
  Widget build(BuildContext context) {
    final daily = dailyReset();
    final weekly = weeklReset();

    // If we don't tie it to something it would require rebuilding the widget to refresh. So use the worldstate as a
    // way to rebuild it at the end of the day
    return AppCard(
      child: BlocBuilder<WorldstateBloc, WorldState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                title: Text(context.l10n.dailyResetTitle),
                trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(daily), expiry: daily),
              ),
              ListTile(
                title: Text(context.l10n.weeklyResetTitle),
                trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(weekly), expiry: weekly),
              ),
            ],
          );
        },
      ),
    );
  }
}
