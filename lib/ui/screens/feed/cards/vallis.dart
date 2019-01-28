import 'package:flutter/material.dart';
import 'package:navis/blocs/provider.dart';
import 'package:navis/blocs/worldstate_bloc.dart';
import 'package:navis/models/export.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/countdown.dart';

class OrbVallis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final state = BlocProvider.of<WorldstateBloc>(context);
    final utils = state.stateUtils;

    return Tiles(
        title: 'Orb Vallis Cycle',
        child: StreamBuilder<WorldState>(
            initialData: WorldstateBloc.initworldstate,
            stream: state.worldstate,
            builder: (context, snapshot) {
              const padding = SizedBox(height: 4);

              return Column(children: <Widget>[
                RowItem.richText(
                  title: 'Current Temperature is ',
                  richText: snapshot.data.vallis.isWarm ? 'Warm' : 'Cold',
                  color: snapshot.data.vallis.isWarm ? Colors.red : Colors.blue,
                  size: 20.0,
                ),
                padding,
                RowItem(
                  text:
                      'Time till Temperature ${snapshot.data.vallis.isWarm ? 'Increases' : 'drops'} ',
                  child: CountdownBox(expiry: snapshot.data.vallis.expiry),
                ),
                padding,
                RowItem(
                  text: snapshot.data.vallis.isWarm
                      ? 'Winter is coming in '
                      : 'Warmer climate at ',
                  child: StaticBox(
                      color: Colors.blueAccent[400],
                      child: Text(
                          '${utils.expiration(snapshot.data.vallis.expiry)}',
                          style: const TextStyle(color: Colors.white))),
                ),
                padding
              ]);
            }));
  }
}
