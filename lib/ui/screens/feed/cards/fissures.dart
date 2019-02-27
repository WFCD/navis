import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/countdown.dart';

class Fissure extends StatefulWidget {
  const Fissure({Key key}) : super(key: key);

  @override
  _Fissure createState() => _Fissure();
}

class _Fissure extends State<Fissure> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
        title: 'Fissures',
        child: BlocBuilder(
          bloc: state,
          builder: (context, state) {
            if (state is WorldstateUninitialized)
              return const Center(child: CircularProgressIndicator());

            if (state is WorldstateLoaded) {
              final fissures = state.worldState.voidFissures;

              return Column(children: fissures.map(_buildFissures).toList());
            }
          },
        ));
  }
}

Widget _buildFissures(VoidFissures fissure) {
  return ListTile(
    dense: true,
    title: Text(
      '${fissure.node} | ${fissure.tier}',
      style: const TextStyle(fontSize: 15.0),
    ),
    subtitle: Text('Missions type: ${fissure.missionType}'),
    trailing: CountdownBox(expiry: fissure.expiry),
  );
}
