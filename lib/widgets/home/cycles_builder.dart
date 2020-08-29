import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/widgets/widgets.dart';

import 'cycle_widget.dart';

class Cycles extends StatelessWidget {
  const Cycles();

  @override
  Widget build(BuildContext context) {
    final localizations = NavisLocalizations.of(context);

    return Tiles(
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              CycleWidget(
                title: localizations.cetusCycleTitle,
                cycle: state.worldstate?.cetusCycle,
              ),
              const Divider(),
              CycleWidget(
                title: localizations.earthCycleTitle,
                cycle: state.worldstate?.earthCycle,
              ),
              const Divider(),
              CycleWidget(
                title: localizations.vallisCycleTitle,
                cycle: state.worldstate?.vallisCycle,
              ),
              const Divider(),
              CycleWidget(
                title: localizations.cambionCycleTitle,
                customState: state.worldstate.cetusCycle?.isDay ?? false
                    ? 'Fass'
                    : 'Vome',
                cycle: state.worldstate?.cetusCycle,
              ),
            ],
          );
        },
      ),
    );
  }
}
