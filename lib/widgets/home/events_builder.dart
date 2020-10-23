import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/dialogs/base_dialog.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

import 'events_widget.dart';

class EventBuilder extends StatelessWidget {
  const EventBuilder({Key key}) : super(key: key);

  Future<void> _showEvent(BuildContext context, Event event) async {
    await showDialog(
      context: context,
      builder: (context) => BaseDialog(
        child: EventWidget(event: event),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: PageStorage(
        key: eventsKey,
        bucket: eventsBucket,
        child: BlocBuilder<WorldstateBloc, WorldStates>(
            buildWhen: (WorldStates previous, WorldStates current) {
          return compareIds(
            previous.worldstate?.events,
            current.worldstate?.events,
          );
        }, builder: (BuildContext context, WorldStates state) {
          final events = state.worldstate?.events ?? [];

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final event in events)
                ListTile(
                  title: Text(event.description),
                  subtitle: Text(event.tooltip),
                  trailing: CountdownBox(expiry: event.expiry),
                  onTap: () => _showEvent(context, event),
                )
            ],
          );
        }),
      ),
    );
  }
}
