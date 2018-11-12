import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/void.dart';
import 'package:navis/models/worldstate.dart';

import '../../resources/assets.dart';
import '../widgets/cards.dart';
import '../widgets/timer.dart';

class Fissure extends StatefulWidget {
  Fissure({Key key}) : super(key: key);

  _Fissure createState() => _Fissure();
}

class _Fissure extends State<Fissure> {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return StreamBuilder(
        initialData: state.lastState,
        stream: state.worldstate,
        builder: (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          return RefreshIndicator(
            onRefresh: () => state.update(),
            child: ListView.builder(
              itemCount: snapshot.data.voidFissures.length,
              itemBuilder: (context, index) =>
                  _buildFissures(snapshot.data.voidFissures[index], context),
            ),
          );
        });
  }
}

Widget _buildFissures(VoidFissures fissure, BuildContext context) {
  final now = DateTime.now();
  Duration timeLeft = DateTime.parse(fissure.expiry).difference(now);

  return Tiles(
    child: ListTile(
      leading: Icon(
        _getTier(fissure),
        size: 45.0,
        color: Theme
            .of(context)
            .iconTheme
            .color,
      ),
      title: Text(
        '${fissure.node} | ${fissure.tier}',
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text('Missions type: ${fissure.missionType}'),
      trailing: Timer(duration: timeLeft, isMore1H: true),
    ),
  );
}

_getTier(fissure) {
  switch (fissure.tier) {
    case 'Lith':
      return ImageAssets.lith;
      break;
    case 'Meso':
      return ImageAssets.meso;
      break;
    case 'Neo':
      return ImageAssets.neo;
      break;
    default:
      return ImageAssets.axi;
  }
}
