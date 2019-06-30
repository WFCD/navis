import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/components/layout.dart';
import 'package:navis/components/animations.dart';

class AlertTile extends StatelessWidget {
  const AlertTile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
        title: 'Alerts',
        child: BlocBuilder(
            bloc: state,
            condition: (WorldStates previous, WorldStates current) =>
                listEquals(previous.alerts, current.alerts),
            builder: (context, state) {
              if (state is WorldstateLoaded) {
                return Column(children: <Widget>[
                  ...state.alerts.map((alert) => _BuildAlerts(alert: alert))
                ]);
              }
            }));
  }
}

final _nightmareIcon = SvgPicture.asset('assets/general/nightmare.svg',
    color: Colors.red, height: 25, width: 25);

final _archwingIcon = SvgPicture.asset('assets/general/archwing.svg',
    color: Colors.blue, height: 25, width: 25);

class _BuildAlerts extends StatelessWidget {
  const _BuildAlerts({@required this.alert});

  final Alert alert;

  @override
  Widget build(BuildContext context) {
    final archwing = alert.mission.archwingRequired;
    final nightmare = alert.mission.nightmare;

    return Container(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RowItem(
              icons: <Widget>[
                if (archwing) _archwingIcon,
                if (nightmare) _nightmareIcon
              ],
              text: alert.mission.node,
              child: alert.mission.reward.itemString.isEmpty
                  ? Container()
                  : StaticBox(
                      color: Colors.blueAccent[400],
                      child: Text(
                        alert.mission.reward.itemString,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white),
                      )),
            ),
            RowItem(
                text:
                    '${alert.mission.type} (${alert.mission.faction}) | Level: ${alert.mission.minEnemyLevel} - ${alert.mission.maxEnemyLevel} | ${alert.mission.reward.credits}cr',
                caption: true,
                child: CountdownBox(expiry: alert.expiry)),
          ]),
    );
  }
}
