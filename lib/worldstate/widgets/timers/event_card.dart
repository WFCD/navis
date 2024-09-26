import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/cubits/worldstate_cubit.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final previousWorldEvents = switch (previous) {
      WorldstateSuccess() => previous.worldstate.events,
      _ => <WorldEvent>[],
    };

    final nextWorldEvents = switch (next) {
      WorldstateSuccess() => next.worldstate.events,
      _ => <WorldEvent>[],
    };

    return !previousWorldEvents.equals(nextWorldEvents);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<WorldstateCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final events = switch (state) {
            WorldstateSuccess() => state.worldstate.events,
            _ => <WorldEvent>[],
          };

          return Column(
            children: <Widget>[
              for (final event in events)
                ListTile(
                  title: Text(event.description),
                  subtitle: Text(
                    event.tooltip ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(
                        Theme.of(context).textTheme.labelLarge?.color,
                      ),
                    ),
                    onPressed: () =>
                        WorldEventPageRoute(event).push<void>(context),
                    child: Text(context.l10n.seeDetails),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
