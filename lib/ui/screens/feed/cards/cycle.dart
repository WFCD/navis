import 'package:flutter/material.dart';

import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/animations.dart';
import 'package:navis/ui/widgets/layout.dart';

enum Cycle { cetus, earth }

class CetusCycle extends StatelessWidget {
  const CetusCycle({@required this.cycle});

  final Cycle cycle;

  String _cycle(Cycle cycle) {
    switch (cycle) {
      case Cycle.cetus:
        return 'Cetus Day/Night Cycle';
      default:
        return 'Earth Day/Night Cycle';
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
        title: _cycle(cycle),
        child: BlocBuilder(
            bloc: state,
            builder: (context, currentState) {
              if (currentState is WorldstateLoaded) {
                final Earth earth = cycle == Cycle.cetus
                    ? currentState.worldState.cetus
                    : currentState.worldState.earth;
                const padding = SizedBox(height: 4);

                return Column(
                  children: <Widget>[
                    RowItem.richText(
                      title: 'Currently it is',
                      richText: earth.isDay == true ? 'Day' : 'Night',
                      color: earth.isDay ? Colors.yellow[700] : Colors.blue,
                      size: 20.0,
                    ),
                    padding,
                    RowItem(
                      text: earth.isDay == true
                          ? 'Time until Night'
                          : 'Time until Day',
                      child: CountdownBox(expiry: earth.expiry),
                    ),
                    padding,
                    RowItem(
                      text:
                          earth.isDay == true ? 'Time at Night' : 'Time at Day',
                      child: StaticBox.text(
                        color: Colors.blueAccent[400],
                        text: '${state.expiration(earth.expiry)}',
                      ),
                    ),
                    padding
                  ],
                );
              }
            }));
  }
}
