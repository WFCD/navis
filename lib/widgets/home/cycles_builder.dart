import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/widgets.dart';

import 'cycle_widget.dart';

class Cycles extends StatelessWidget {
  const Cycles();

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        builder: (context, state) {
          final worldstate = (state as WorldstateLoadSuccess).worldstate;

          return Column(
            children: <Widget>[
              CycleWidget(
                title: 'Cetus Cycle',
                cycle: worldstate?.cetusCycle,
              ),
              const Divider(),
              CycleWidget(
                title: 'Earth Cycle',
                cycle: worldstate?.earthCycle,
              ),
              const Divider(),
              CycleWidget(
                title: 'Orb Vallis Cycle',
                cycle: worldstate?.vallisCycle,
              )
            ],
          );
        },
      ),
    );
  }
}
