import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis/worldstate/utils/utils.dart';
import 'package:navis_ui/navis_ui.dart';

class DailyReward extends StatefulWidget {
  const DailyReward({super.key});

  @override
  State<DailyReward> createState() => _DailyRewardState();
}

class _DailyRewardState extends State<DailyReward> {
  late DateTime _daily;
  late DateTime _weekly;

  bool _buildWhen(WorldState previous, WorldState next) {
    if (next is! WorldstateSuccess) return false;
    final timestamp = next.seed.timestamp;

    return timestamp.isAfter(_daily) ||
        timestamp.isAtSameMomentAs(_daily) ||
        timestamp.isAfter(_weekly) ||
        timestamp.isAtSameMomentAs(_weekly);
  }

  @override
  void initState() {
    super.initState();
    _daily = dailyReset();
    _weekly = weeklyReset();
  }

  @override
  Widget build(BuildContext context) {
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
                trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(_daily), expiry: _daily),
              ),
              ListTile(
                title: Text(context.l10n.weeklyResetTitle),
                trailing: CountdownTimer(tooltip: context.l10n.countdownTooltip(_weekly), expiry: _weekly),
              ),
            ],
          );
        },
      ),
    );
  }
}
