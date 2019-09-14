import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_objects.dart';

class Cycles extends StatelessWidget {
  const Cycles();

  Widget _cycleRow(String title, CycleObject cycle, BuildContext context) {
    final storage = RepositoryProvider.of<Repository>(context).storage;
    final state = toBeginningOfSentenceCase(cycle.state);
    final nextState = toBeginningOfSentenceCase(cycle.nextState);
    final dateFormat = enumToDateformat(storage.dateformat);

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subhead.copyWith(fontSize: 17),
          ),
          const Spacer(),
          Text(
            state,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
              color: cycle.getStateBool ? Colors.yellow[700] : Colors.blue,
            ),
          ),
          const SizedBox(width: 8.0),
          Tooltip(
            message:
                '$nextState at ${expiration(cycle.expiry, format: dateFormat)}',
            showDuration: const Duration(seconds: 2, milliseconds: 500),
            child: CountdownBox(expiry: cycle.expiry),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Tiles(
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              _cycleRow(
                'Cetus Cycle',
                state.worldstate?.cetusCycle,
                context,
              ),
              const Divider(),
              _cycleRow(
                'Earth Cycle',
                state.worldstate?.earthCycle,
                context,
              ),
              const Divider(),
              _cycleRow(
                'Orb Vallis Cycle',
                state.worldstate?.vallisCycle,
                context,
              )
            ],
          );
        },
      ),
    );
  }
}
