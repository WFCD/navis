import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/models/worldstate/earth.dart';

class EarthCycle extends StatelessWidget {
  const EarthCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateEvent, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return Cycle(title: 'Earth Day/Night Cycle', cycle: state.earth);
      },
    );
  }
}

class CetusCycle extends StatelessWidget {
  const CetusCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateEvent, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return Cycle(title: 'Cetus Day/Night Cycle', cycle: state.cetus);
      },
    );
  }
}

class Cycle extends StatelessWidget {
  const Cycle({@required this.title, @required this.cycle});

  final String title;
  final Earth cycle;

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(height: 8.0);

    return Tiles(
        title: title,
        child: Column(
          children: <Widget>[
            RowItem.richText(
              title: 'Currently it is',
              richText: cycle.isDay == true ? 'Day' : 'Night',
              color: cycle.isDay ? Colors.yellow[700] : Colors.blue,
              size: 20.0,
            ),
            padding,
            RowItem(
              text: cycle.isDay == true ? 'Time until Night' : 'Time until Day',
              child: CountdownBox(expiry: cycle.expiry),
            ),
            padding,
            RowItem(
                text: cycle.isDay == true ? 'Time at Night' : 'Time at Day',
                child: DateView(expiry: cycle.expiry)),
            padding
          ],
        ));
  }
}
