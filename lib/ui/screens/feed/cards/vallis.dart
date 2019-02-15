import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'package:navis/ui/widgets/cards.dart';
import 'package:navis/ui/widgets/row_item.dart';
import 'package:navis/ui/widgets/static_box.dart';
import 'package:navis/ui/widgets/countdown.dart';

class OrbVallis extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
        title: 'Orb Vallis Cycle',
        child: BlocBuilder(
            bloc: wstate,
            builder: (context, state) {
              if (state is WorldstateLoaded) {
                final vallis = state.worldState.vallis;
                const padding = SizedBox(height: 4);

                return Column(children: <Widget>[
                  RowItem.richText(
                    title: 'Current Temperature is ',
                    richText: vallis.isWarm ? 'Warm' : 'Cold',
                    color: vallis.isWarm ? Colors.red : Colors.blue,
                    size: 20.0,
                  ),
                  padding,
                  RowItem(
                    text:
                        'Time till ${vallis.isWarm ? 'Cold Cycle' : 'Warm Cycle'} ',
                    child: CountdownBox(expiry: vallis.expiry),
                  ),
                  padding,
                  RowItem(
                    text: vallis.isWarm
                        ? 'Winter is coming in '
                        : 'Warmer climate at ',
                    child: StaticBox(
                        color: Colors.blueAccent[400],
                        child: Text('${wstate.expiration(vallis.expiry)}',
                            style: const TextStyle(color: Colors.white))),
                  ),
                  padding
                ]);
              }
            }));
  }
}
