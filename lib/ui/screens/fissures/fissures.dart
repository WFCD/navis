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

    return RefreshIndicator(
        onRefresh: () => state.update(),
        child: BlocBuilder(
          bloc: state,
          builder: (context, state) {
            if (state is WorldstateUninitialized)
              return const Center(child: CircularProgressIndicator());

            if (state is WorldstateLoaded) {
              final fissures = state.worldState.voidFissures;

              return ListView.builder(
                itemCount: fissures.length,
                itemBuilder: (context, index) =>
                    _BuildFissures(fissure: fissures[index]),
              );
            }
          },
        ));
  }
}

class _BuildFissures extends StatelessWidget {
  const _BuildFissures({this.fissure});

  final VoidFissures fissure;

  @override
  Widget build(BuildContext context) {
    final factionUtils = BlocProvider.of<WorldstateBloc>(context).factionUtils;

    return Tiles(
      child: ListTile(
        dense: true,
        leading: factionUtils.getTierIcon(fissure.tier, context),
        title: Text(
          '${fissure.node} | ${fissure.tier}',
          style: const TextStyle(fontSize: 15.0),
        ),
        subtitle: Text('Missions type: ${fissure.missionType}'),
        trailing: CountdownBox(expiry: fissure.expiry),
      ),
    );
  }
}
