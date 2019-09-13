import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_objects.dart';

class Cycles extends StatelessWidget {
  const Cycles();

  Widget _cycleRow(String title, CycleObject cycle, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: RowItem(
        text: Text(title,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 17)),
        child: Row(
          children: <Widget>[
            Text(
              toBeginningOfSentenceCase(cycle.state),
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: cycle.getStateBool ? Colors.yellow[700] : Colors.blue,
              ),
            ),
            const SizedBox(width: 8.0),
            CountdownBox(expiry: cycle.expiry),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tiles(
      title: 'Cycles',
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              _cycleRow('Cetus Cycle', state.worldstate?.cetusCycle, context),
              const Divider(),
              _cycleRow('Earth Cycle', state.worldstate?.earthCycle, context),
              const Divider(),
              _cycleRow(
                  'Orb Vallis Cycle', state.worldstate?.vallisCycle, context)
            ],
          );
        },
      ),
    );
  }
}
