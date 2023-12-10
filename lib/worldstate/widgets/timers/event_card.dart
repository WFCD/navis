import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/views/event.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  bool _buildWhen(SolsystemState previous, SolsystemState next) {
    final previousWorldEvents = switch (previous) {
      SolState() => previous.worldstate.events,
      _ => <WorldEvent>[],
    };

    final nextWorldEvents = switch (next) {
      SolState() => next.worldstate.events,
      _ => <WorldEvent>[],
    };

    return !previousWorldEvents.equals(nextWorldEvents);
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final events = switch (state) {
            SolState() => state.worldstate.events,
            _ => <WorldEvent>[],
          };
          ;

          return Column(
            children: <Widget>[
              for (final event in events)
                ListTile(
                  title: Text(event.description),
                  subtitle:
                      event.tooltip != null ? Text(event.tooltip ?? '') : null,
                  trailing: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.labelLarge?.color,
                      ),
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(EventInformation.route, arguments: event),
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
