import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/components/widgets/date.dart';
import 'package:worldstate_model/worldstate_model.dart';

import '../animations.dart';
import '../layout.dart';

class Cycle extends StatelessWidget {
  const Cycle({
    @required this.title,
    @required this.cycle,
  })  : assert(title != null),
        assert(cycle != null);

  final String title;
  final CycleObject cycle;

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
              color: cycle.getStateBool ? Colors.yellow[700] : Colors.blue,
              size: 20.0,
            ),
            padding,
            RowItem(
              text: 'Time until ${cycle.nextState}',
              child: CountdownBox(expiry: cycle.expiry),
            ),
            padding,
            RowItem(
                text: 'Time at ${cycle.nextState}',
                child: DateView(expiry: cycle.expiry)),
            padding
          ],
        ));
  }
}
