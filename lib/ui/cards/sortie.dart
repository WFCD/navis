import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/worldstate_model/sortie.dart';
import 'package:navis/models/worldstate_model/worldstate.dart';

import '../../resources/factions.dart';
import '../animation/countdown.dart';
import '../widgets/cards.dart';

class SculptureMissions extends StatelessWidget {
  Widget _buildMissions(Variants variants, BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(bottom: 4.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 4.0, right: 4.0, left: 4.0),
          child: Column(children: <Widget>[
            Row(children: <Widget>[
              Text('${variants.missionType} - ${variants.node}',
                  style: TextStyle(fontSize: 15.0))
            ]),
            Row(children: <Widget>[
              Expanded(
                  child: Text(variants.modifierDescription,
                      style: TextStyle(
                          color: Theme
                              .of(context)
                              .textTheme
                              .caption
                              .color)))
            ]),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final factionSwitch = DynamicFaction();
    final sortie = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder<WorldState>(
      initialData: sortie.lastState,
      stream: sortie.worldstate,
      builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
        final title = ListTile(
          leading: DynamicFaction.factionIcon(snapshot.data.sortie.faction,
              size: 45.0),
          title: Text(snapshot.data.sortie.boss),
          subtitle: Text(snapshot.data.sortie.faction),
          trailing: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: factionSwitch.sortieColor(
                      DateTime.parse(snapshot.data.sortie.expiry)
                          .difference(DateTime.now())),
                  borderRadius: BorderRadius.circular(3.0)),
              child: StreamBuilder<Duration>(
                initialData: Duration(seconds: 60),
                stream: CounterScreenStream(
                    DateTime.parse(snapshot.data.sortie.expiry)
                        .difference(DateTime.now())),
                builder: (context, snapshot) {
                  Duration data = snapshot.data;

                  String hour = '${data.inHours}';
                  String minutes =
                  '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
                  String seconds =
                  '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

                  return Text('$hour:$minutes:$seconds',
                      style: TextStyle(color: Colors.white));
                },
              )),
        );

        List<Widget> missions = snapshot.data.sortie.variants
            .map((variant) => _buildMissions(variant, context))
            .toList()
          ..insert(0, title);

        return Tiles(child: Column(children: missions));
      },
    );
  }
}
