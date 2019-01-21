import 'package:flutter/material.dart';

import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/timer.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/cards.dart';

enum Cycle { cetus, earth }

class CetusCycle extends StatelessWidget {
  final Cycle cycle;

  CetusCycle({@required this.cycle});

  _cycle(Cycle cycle) {
    switch (cycle) {
      case Cycle.cetus:
        return 'Cetus Day/Night Cycle';
      case Cycle.earth:
        return 'Earth Day/Night Cycle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final utils = state.stateUtils;

    final style = Theme.of(context).textTheme.subhead;

    return Tiles(
        title: _cycle(cycle),
        child: StreamBuilder(
            initialData: WorldstateBloc.initworldstate,
            stream: state.worldstate,
            builder:
                (BuildContext context, AsyncSnapshot<WorldState> snapshot) {
              final earth = snapshot.data.earth;
              final cetus = snapshot.data.cetus;
              final dynamic orbit = cycle == Cycle.cetus ? cetus : earth;
              final padding = SizedBox(height: 8);

              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('Currently it is', style: style),
                      orbit.isDay == true
                          ? RichText(
                              text: TextSpan(
                                  text: 'Day',
                                  style: TextStyle(
                                      color: Colors.yellow[700],
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold)))
                          : Text('Night',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold))
                    ],
                  ),
                  padding,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      orbit.isDay == true
                          ? Text('Time until Night', style: style)
                          : Text('Time until Day', style: style),
                      Timer(
                          expiry: cycle == Cycle.cetus
                              ? cetus.expiry
                              : earth.expiry)
                    ],
                  ),
                  padding,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      orbit.isDay == true
                          ? Text('Time at Night', style: style)
                          : Text('Time at Day', style: style),
                      StaticBox(
                          color: Colors.blueAccent[400],
                          child: Text(
                              cycle == Cycle.cetus
                                  ? '${utils.expiration(snapshot.data.cetus.expiry)}'
                                  : '${utils.expiration(snapshot.data.cetus.expiry)}',
                              style: TextStyle(color: Colors.white))),
                    ],
                  ),
                  padding
                ],
              );
            }));
  }
}
