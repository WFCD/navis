import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_objects.dart';

class CyclePanel extends StatelessWidget {
  const CyclePanel({Key key, @required this.cycles})
      : assert(cycles != null),
        super(key: key);

  final List<CycleEntry> cycles;

  @override
  Widget build(BuildContext context) {
    return Panel(
        child: Column(
      children: <Widget>[
        for (final cycle in cycles)
          CycleWidget(cycleName: cycle.name, cycle: cycle.cycle)
      ],
    ));
  }
}

class CycleEntry {
  final String name;
  final CycleObject cycle;

  const CycleEntry({@required this.name, @required this.cycle})
      : assert(name != null),
        assert(cycle != null);
}

class CycleWidget extends StatelessWidget {
  const CycleWidget({Key key, @required this.cycleName, @required this.cycle})
      : assert(cycleName != null),
        assert(cycle != null),
        super(key: key);

  final String cycleName;
  final CycleObject cycle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: RowItem(
        text: Text(cycleName),
        child: CountdownTimer(expiry: cycle.expiry),
      ),
    );
  }
}
