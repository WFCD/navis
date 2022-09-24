import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/views/event.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:wfcd_client/entities.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key});

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is SolState && n is SolState) {
      return p.worldstate.events.equals(n.worldstate.events);
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: BlocBuilder<SolsystemCubit, SolsystemState>(
        buildWhen: _buildWhen,
        builder: (context, state) {
          final events =
              state is SolState ? state.worldstate.events : <Event>[];

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
                        Theme.of(context).textTheme.button?.color,
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
