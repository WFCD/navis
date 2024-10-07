import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/worldstate/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DuviriCycle extends StatelessWidget {
  const DuviriCycle({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState current) {
    if (previous is! WorldstateSuccess || current is! WorldstateSuccess) {
      return false;
    }

    final previousCycle = previous.worldstate.duviriCycle;
    final nextCycle = current.worldstate.duviriCycle;

    return previousCycle.id != nextCycle.id;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final cycle = switch (state) {
            WorldstateSuccess() => state.worldstate.duviriCycle,
            _ => null
          };

          final choices =
              cycle?.choices.map((c) => DuviriChoiceTile(choice: c));

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DuviriResetTimer(expiry: cycle?.expiry ?? DateTime.now()),
              ...?choices,
            ],
          );
        },
      ),
    );
  }
}

class DuviriResetTimer extends StatelessWidget {
  const DuviriResetTimer({super.key, required this.expiry});

  final DateTime expiry;

  DateTime _getNextMonday() {
    final now = DateTime.timestamp();

    var daysUntilNextMonday = (DateTime.monday - now.weekday + 7) % 7;
    daysUntilNextMonday = daysUntilNextMonday == 0 ? 7 : daysUntilNextMonday;

    final nextMondayMidnight = DateTime.utc(
      now.year,
      now.month,
      now.day + daysUntilNextMonday,
    );

    return nextMondayMidnight;
  }

  @override
  Widget build(BuildContext context) {
    final date = MaterialLocalizations.of(context).formatFullDate(expiry);

    return ListTile(
      title: Text(context.l10n.circuitResetTitle),
      trailing: CountdownTimer(tooltip: date, expiry: _getNextMonday()),
    );
  }
}

class DuviriChoiceTile extends StatelessWidget {
  const DuviriChoiceTile({super.key, required this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final secondaryContainer = Theme.of(context).colorScheme.secondaryContainer;

    var category = toBeginningOfSentenceCase(choice.category);
    if (category == 'Hard') category = context.l10n.steelPathTitle;

    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(category),
          ),
          Wrap(
            spacing: 8,
            alignment: WrapAlignment.center,
            children: choice.choices
                .map(
                  (c) => Chip(
                    label: Text(c),
                    side: BorderSide(color: secondaryContainer),
                    backgroundColor: secondaryContainer,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
