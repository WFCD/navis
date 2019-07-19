import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/components/widgets/date.dart';
import 'package:navis/models/abstract_classes.dart';

import '../animations.dart';
import '../layout.dart';

enum PlanetCycle { earth, venus }

class Cycle extends StatelessWidget {
  const Cycle({
    @required this.title,
    @required this.cycle,
    @required this.planetCycle,
  });

  final String title;
  final CycleModel cycle;
  final PlanetCycle planetCycle;

  String stateString() {
    switch (planetCycle) {
      case PlanetCycle.venus:
        return !cycle.stateBool ? 'Warm' : 'Cold';
      default:
        return !cycle.stateBool ? 'Day' : 'Night';
    }
  }

  @override
  Widget build(BuildContext context) {
    const padding = SizedBox(height: 8.0);

    return Tiles(
        title: title,
        child: Column(
          children: <Widget>[
            RowItem.richText(
              title: 'Currently it is',
              richText: toBeginningOfSentenceCase(cycle.state),
              color: cycle.stateBool ? Colors.yellow[700] : Colors.blue,
              size: 20.0,
            ),
            padding,
            RowItem(
              text: 'Time until ${stateString()}',
              child: CountdownBox(expiry: cycle.expiry),
            ),
            padding,
            RowItem(
                text: 'Time at ${stateString()}',
                child: DateView(expiry: cycle.expiry)),
            padding
          ],
        ));
  }
}
