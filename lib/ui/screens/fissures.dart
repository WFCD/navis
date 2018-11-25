import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

    return RefreshIndicator(
        onRefresh: () => state.update(),
        child: StreamBuilder(
            initialData: state.lastState,
            stream: state.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              if (!snapshot.hasData)
                return Center(child: CircularProgressIndicator());

              return ListView.builder(
                itemCount: snapshot.data.voidFissures.length,
                itemBuilder: (context, index) =>
                    _buildFissures(snapshot.data.voidFissures[index], context),
              );
            }));
  }
}

Widget _buildFissures(VoidFissures fissure, BuildContext context) {
  final now = DateTime.now();
  Duration timeLeft = DateTime.parse(fissure.expiry).difference(now);

  return Tiles(
    child: ListTile(
      dense: true,
      leading: _getTier(fissure.tier, context),
      title: Text(
        '${fissure.node} | ${fissure.tier}',
        style: TextStyle(fontSize: 15.0),
      ),
      subtitle: Text('Missions type: ${fissure.missionType}'),
      trailing: Timer(duration: timeLeft),
    ),
  );
}

SvgPicture _getTier(String tier, BuildContext context) {
  final color = Theme.of(context).iconTheme.color;
  final size = 50.0;

  switch (tier) {
    case 'Lith':
      return SvgPicture.asset('assets/relics/Lith.svg',
          height: size, width: size, color: color);
      break;
    case 'Meso':
      return SvgPicture.asset('assets/relics/Meso.svg',
          height: size, width: size, color: color);
      break;
    case 'Neo':
      return SvgPicture.asset('assets/relics/Neo.svg',
          height: size, width: size, color: color);
      break;
    default:
      return SvgPicture.asset('assets/relics/Axi.svg',
          height: size, width: size, color: color);
  }
}
