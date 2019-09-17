import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/screen_widgets/home/cycle_widget.dart';
import 'package:navis/widgets/widgets.dart';

class Cycles extends StatelessWidget {
  const Cycles();

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              CycleWidget(
                title: 'Cetus Cycle',
                cycle: state.worldstate?.cetusCycle,
              ),
              const Divider(),
              CycleWidget(
                title: 'Earth Cycle',
                cycle: state.worldstate?.earthCycle,
              ),
              const Divider(),
              CycleWidget(
                title: 'Orb Vallis Cycle',
                cycle: state.worldstate?.vallisCycle,
              )
            ],
          );
        },
      ),
    );
  }
}
