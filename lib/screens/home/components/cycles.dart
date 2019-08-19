import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/components/animations.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/widgets/date.dart';
import 'package:worldstate_model/worldstate_models.dart';
import 'package:worldstate_model/worldstate_objects.dart';

class Cycles extends StatelessWidget {
  const Cycles({
    @required this.title,
    @required this.cycle,
  })  : assert(title != null),
        assert(cycle != null);

  factory Cycles.cetus(Cetus cetus) =>
      Cycles(title: 'Cetus Day/Night Cycle', cycle: cetus);

  factory Cycles.orbValis(Vallis orbVallis) =>
      Cycles(title: 'Orb Vallis Warm/Cold Cycle', cycle: orbVallis);

  factory Cycles.earth(Earth earth) =>
      Cycles(title: 'Earth Day/Night Cycle', cycle: earth);

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
              child: DateView(expiry: cycle.expiry),
            ),
            padding
          ],
        ));
  }
}
