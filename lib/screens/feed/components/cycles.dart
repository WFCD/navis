import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout/cycles_base.dart';

const List<Widget> cycles = [CetusCycle(), EarthCycle(), OrbVallisCycle()];

class EarthCycle extends StatelessWidget {
  const EarthCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Earth Day/Night Cycle',
          cycle: state.earth,
          planetCycle: PlanetCycle.earth,
        );
      },
    );
  }
}

class CetusCycle extends StatelessWidget {
  const CetusCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Cetus Day/Night Cycle',
          cycle: state.cetus,
          planetCycle: PlanetCycle.earth,
        );
      },
    );
  }
}

class OrbVallisCycle extends StatelessWidget {
  const OrbVallisCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Orb Vallis Warm/Cold Cycle',
          cycle: state.vallis,
          planetCycle: PlanetCycle.venus,
        );
      },
    );
  }
}
