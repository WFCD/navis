import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/expandedCard.dart';
import 'package:navis/ui/widgets/countdown.dart';

class Fissure extends StatelessWidget {
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

              return ExpandedInfo(
                header: Column(
                    children: fissures
                        .take(3)
                        .map((f) => _BuildFissures(f))
                        .toList()),
                body: Column(
                    children: fissures
                        .skip(3)
                        .map((f) => _BuildFissures(f))
                        .toList()),
                condition: fissures.length < 3,
                padding: EdgeInsets.zero,
              );
            }
          },
        ));
  }
}

class _BuildFissures extends StatelessWidget {
  const _BuildFissures(this.fissure);

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        '${fissure.node} | ${fissure.tier}',
        style: const TextStyle(fontSize: 15.0),
      ),
      subtitle: Text('Missions type: ${fissure.missionType}'),
      trailing: CountdownBox(expiry: fissure.expiry),
    );
  }
}
