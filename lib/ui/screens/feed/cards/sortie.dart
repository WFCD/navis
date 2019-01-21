import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/timer.dart';

class SculptureMissions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final factionutils = state.factionUtils;

    return Tiles(
        child: StreamBuilder(
            initialData: WorldstateBloc.initworldstate,
            stream: state.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              final title = ListTile(
                leading: factionutils.factionIcon(snapshot.data.sortie.faction,
                    size: 45),
                title: Text(snapshot.data.sortie.boss),
                subtitle: Text(snapshot.data.sortie.faction),
                trailing: Container(
                    padding: EdgeInsets.all(4.0),
                    child: Timer(expiry: snapshot.data.sortie.expiry)),
              );

              List<Widget> missions = snapshot.data.sortie.variants
                  .map((variant) => _buildMissions(variant, context))
                  .toList()
                    ..insert(0, title);

              return missions.isEmpty
                  ? Center(child: Text('Loading current sorite...'))
                  : Column(children: missions);
            }));
  }
}

Widget _buildMissions(Variants variants, BuildContext context) {
  final info = Theme.of(context).textTheme.subhead;
  final description =
      Theme.of(context).textTheme.caption.copyWith(fontSize: 13);

  return Padding(
      padding: EdgeInsets.only(bottom: 4.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 4.0, right: 4.0, left: 4.0),
        child: Column(children: <Widget>[
          Row(children: <Widget>[
            Text('${variants.missionType} - ${variants.node}', style: info)
          ]),
          Row(children: <Widget>[
            Expanded(
                child: Text(variants.modifierDescription, style: description))
          ]),
        ]),
      ));
}
