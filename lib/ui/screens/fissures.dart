import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/void.dart';
import 'package:navis/models/worldstate.dart';

import '../../resources/assets.dart';
import '../../resources/factions.dart';
import '../animation/countdown.dart';
import '../widgets/cards.dart';

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
  final switcher = DynamicFaction();
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
        '${fissure.node} | ${fissure.missionType} | ${fissure.tier}',
        style: TextStyle(fontSize: 15.0),
      ),
      trailing: StreamBuilder<Duration>(
          initialData: Duration(seconds: 60),
          stream: CounterScreenStream(timeLeft),
          builder: (context, snapshot) {
            Duration data = snapshot.data;

            String hour = '${data.inHours}';
            String minutes = '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
            String seconds = '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

            return AnimatedContainer(
                duration: Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(
                    color: switcher.alertColor(data),
                    borderRadius: BorderRadius.circular(3.0)),
                child: Text('$hour:$minutes:$seconds',
                    style: TextStyle(color: Colors.white)));
          }),
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
