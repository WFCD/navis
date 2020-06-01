import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/widgets.dart';

import 'alert_widget.dart';

class AlertTile extends StatelessWidget {
  const AlertTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        condition: (WorldStates previous, WorldStates current) {
          final previousAlerts = previous.worldstate?.alerts ?? [];
          final currentAlerts = current.worldstate?.alerts ?? [];

          return listEquals(previousAlerts, currentAlerts);
        },
        builder: (context, state) {
          final alerts = state.worldstate?.alerts ?? [];

          return Column(children: <Widget>[
            ...alerts.map((alert) => AlertWidget(alert: alert))
          ]);
        },
      ),
    );
  }
}
