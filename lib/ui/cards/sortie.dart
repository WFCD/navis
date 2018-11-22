import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import '../../resources/factions.dart';
import '../widgets/cards.dart';
import '../widgets/timer.dart';

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
                          color: Theme.of(context).textTheme.caption.color)))
            ]),
          ]),
        ));
  }

  @override
  Widget build(BuildContext context) {
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
              child: Timer(
                  duration: DateTime.parse(snapshot.data.sortie.expiry)
                      .difference(DateTime.now()))),
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
