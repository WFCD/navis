import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';

import 'components/mission_style.dart';

class SortieScreen extends StatelessWidget {
  const SortieScreen({Key key}) : super(key: key);

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
                  final variants = sortie.variants;
                  final faction = sortie.faction;

                  final light = 'assets/factions/$faction/light.webp';
                  final medium = 'assets/factions/$faction/medium.webp';
                  final heavy = 'assets/factions/$faction/heavy.webp';

                  return ListView(children: <Widget>[
                    Card(
                        color: Theme.of(context).primaryColor,
                        child: ListTile(
                          title: const Text('Sortie will reset in: ',
                              style: TextStyle(color: Colors.white)),
                          trailing: CountdownBox(
                              color: Colors.transparent,
                              expiry: sortie.expiry,
                              size: 16),
                        )),
                    BuildMission(variant: variants[0], index: 0, asset: light),
                    BuildMission(variant: variants[1], index: 1, asset: medium),
                    BuildMission(
                        variant: variants[2],
                        index: 2,
                        asset: heavy,
                        boss: sortie.boss,
                        faction: sortie.faction)
                  ]);
                }
              }

              return Container();
            }));
  }
}
