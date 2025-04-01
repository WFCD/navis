import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/routes.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocSelector<WorldstateBloc, WorldState, List<WorldEvent>>(
        selector:
            (s) => switch (s) {
              WorldstateSuccess() => s.seed.events,
              _ => <WorldEvent>[],
            },
        builder: (context, events) {
          return Column(
            children: <Widget>[
              for (final event in events)
                ListTile(
                  title: Text(event.description),
                  subtitle: Text(event.tooltip ?? '', maxLines: 1, overflow: TextOverflow.ellipsis),
                  trailing: TextButton(
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(Theme.of(context).textTheme.labelLarge?.color),
                    ),
                    onPressed: () => WorldEventPageRoute(event).push<void>(context),
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
