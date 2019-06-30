import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout/cycles_base.dart';

const List<Widget> cycles = [CetusCycle(), EarthCycle(), OrbVallisCycle()];

class EarthCycle extends StatelessWidget {
  const EarthCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateEvent, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      condition: (WorldStates previous, WorldStates current) =>
          previous.earth.id != current.earth.id,
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
      condition: (WorldStates previous, WorldStates current) =>
          previous.cetus.id != current.cetus.id,
      builder: (BuildContext context, WorldStates state) {
        return Cycle(title: 'Cetus Day/Night Cycle', cycle: state.cetus);
      },
    );
  }
}

class OrbVallisCycle extends StatelessWidget {
  const OrbVallisCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateEvent, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      condition: (WorldStates previous, WorldStates current) =>
          previous.vallis.id != current.vallis.id,
      builder: (BuildContext context, WorldStates state) {
        return Cycle(title: 'Orb Vallis Warm/Cold Cycle', cycle: state.vallis);
      },
    );
  }
}
