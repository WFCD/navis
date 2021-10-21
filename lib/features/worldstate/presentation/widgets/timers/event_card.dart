import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../bloc/solsystem_bloc.dart';
import '../../pages/event.dart';

class EventCard extends StatelessWidget {
  const EventCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        buildWhen: (p, n) {
          if (p is SolState && n is SolState) {
            return p.worldstate.events.equals(n.worldstate.events);
          }
          return false;
        },
        builder: (context, state) {
          final events = (state as SolState).worldstate.events;

          return Column(
            children: <Widget>[
              for (final event in events)
                ListTile(
                  title: Text(event.description),
                  subtitle: event.tooltip != null ? Text(event.tooltip!) : null,
                  trailing: TextButton(
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all(
                        Theme.of(context).textTheme.button?.color,
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(EventInformation.route, arguments: event);
                    },
                    child: Text(context.l10n.seeDetails),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
