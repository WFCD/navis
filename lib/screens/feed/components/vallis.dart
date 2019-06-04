import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';

class OrbVallis extends StatelessWidget {
  const OrbVallis({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tiles(
        title: 'Orb Vallis Cycle',
        child: BlocBuilder(
            bloc: BlocProvider.of<WorldstateBloc>(context),
            builder: (context, state) {
              if (state is WorldstateLoaded) {
                final vallis = state.vallis;
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
                        'Time until ${vallis.isWarm ? 'Cold Cycle' : 'Warm Cycle'} starts',
                    child: CountdownBox(expiry: vallis.expiry),
                  ),
                  padding,
                  RowItem(
                    text: vallis.isWarm
                        ? 'Winter is coming in'
                        : 'Warmer climate starts on',
                    child: DateView(expiry: vallis.expiry),
                  ),
                  padding
                ]);
              }
            }));
  }
}
