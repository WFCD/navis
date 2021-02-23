import 'package:flutter/material.dart';
import 'package:wfcd_client/objects.dart';

import '../../../../../core/widgets/widgets.dart';

class CycleCard extends StatelessWidget {
  const CycleCard({Key key, @required this.cycles})
      : assert(cycles != null),
        super(key: key);

  final List<CycleEntry> cycles;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
        child: Column(
      children: <Widget>[
        for (final cycle in cycles)
          CycleWidget(
            stateOne: cycle.states[0],
            stateTwo: cycle.states[1],
            cycleName: cycle.name,
            cycle: cycle.cycle,
          )
      ],
    ));
  }
}

class CycleEntry {
  const CycleEntry({
    @required this.states,
    @required this.name,
    @required this.cycle,
  })  : assert(states != null),
        assert(name != null),
        assert(cycle != null);

  final List<Widget> states;
  final String name;
  final CycleObject cycle;
}

class CycleWidget extends StatelessWidget {
  const CycleWidget({
    Key key,
    @required this.stateOne,
    @required this.stateTwo,
    @required this.cycleName,
    @required this.cycle,
  })  : assert(stateOne != null),
        assert(stateTwo != null),
        assert(cycleName != null),
        assert(cycle != null),
        super(key: key);

  final Widget stateOne, stateTwo;
  final String cycleName;
  final CycleObject cycle;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return ListTile(
      title: Text(
        cycleName,
        style: textTheme.subtitle1.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          if (cycle.getStateBool) stateOne else stateTwo,
          const SizedBox(width: 6.0),
          CountdownTimer(expiry: cycle.expiry),
        ],
      ),
    );
  }
}
