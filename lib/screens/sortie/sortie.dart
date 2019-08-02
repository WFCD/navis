import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';

import 'components/mission_style.dart';

class SortieScreen extends StatelessWidget {
  const SortieScreen({Key key}) : super(key: key);

  Widget _header(BuildContext context, DateTime expiry) {
    return Card(
        color: Theme.of(context).primaryColor,
        child: ListTile(
          title: const Text(
            'Sortie will reset in: ',
            style: TextStyle(color: Colors.white),
          ),
          trailing: CountdownBox(
            color: Colors.transparent,
            expiry: expiry,
            size: 16,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder(
            bloc: BlocProvider.of<WorldstateBloc>(context),
            condition: (WorldStates previous, WorldStates current) =>
                previous.worldstate?.sortie != current.worldstate?.sortie,
            builder: (BuildContext context, WorldStates state) {
              if (state is WorldstateLoaded) {
                final sortie = state.worldstate?.sortie;

                if (sortie.variants?.isNotEmpty ?? false) {
                  return ListView(children: <Widget>[
                    _header(context, sortie.expiry),
                    BuildMissions(
                      variants: sortie.variants,
                      faction: sortie.faction,
                      boss: sortie.boss,
                    )
                  ]);
                }
              }

              return Container();
            }));
  }
}
