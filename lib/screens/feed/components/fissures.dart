import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/components/layout.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/utils/factionutils.dart';

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
                        .take(5)
                        .map((f) => _BuildFissures(f))
                        .toList()),
                body: Column(
                    children: fissures
                        .skip(5)
                        .map((f) => _BuildFissures(f))
                        .toList()),
                condition: fissures.length <= 5,
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
    return Row(children: <Widget>[
      GetTierIcon(fissure.tier),
      const SizedBox(width: 8.0),
      Expanded(
          child: Container(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: Text(
                  '${fissure.node} | ${fissure.tier} | ${fissure.missionType}',
                  style: Theme.of(context)
                      .textTheme
                      .subhead
                      .copyWith(fontSize: 15)))),
      CountdownBox(expiry: fissure.expiry)
    ]);
  }
}
