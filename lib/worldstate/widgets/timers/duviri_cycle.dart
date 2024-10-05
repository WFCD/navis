import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:navis/worldstate/cubits/worldstate/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class DuviriCycle extends StatelessWidget {
  const DuviriCycle({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    if (previous is! WorldstateSuccess || next is! WorldstateSuccess) {
      return false;
    }

    final previousChoices = previous.worldstate.duviriCycle.choices;
    final nextChoices = next.worldstate.duviriCycle.choices;

    return previousChoices.equals(nextChoices);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final choices = switch (state) {
            WorldstateSuccess() => state.worldstate.duviriCycle.choices,
            _ => null
          };

          return Column(
            mainAxisSize: MainAxisSize.min,
            children:
                choices?.map((c) => DuviriChoiceTile(choice: c)).toList() ?? [],
          );
        },
      ),
    );
  }
}

class DuviriChoiceTile extends StatelessWidget {
  const DuviriChoiceTile({super.key, required this.choice});

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final category = toBeginningOfSentenceCase(choice.category);
    final secondaryContainer = Theme.of(context).colorScheme.secondaryContainer;

    return ListTile(
      title: Text('The Circuit - $category'),
      subtitle: Wrap(
        spacing: 4,
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
    );
  }
}
