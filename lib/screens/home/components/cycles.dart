import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/layout/cycles_base.dart';
import 'package:navis/utils/worldstate_utils.dart';

const List<Widget> cycles = [CetusCycle(), EarthCycle(), OrbVallisCycle()];

class EarthCycle extends StatelessWidget {
  const EarthCycle({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      condition: (WorldStates previous, WorldStates current) {
        return compareExpiry(
          previous.worldstate.earthCycle?.expiry,
          current.worldstate.earthCycle?.expiry,
        );
      },
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Earth Day/Night Cycle',
          cycle: state.worldstate?.earthCycle,
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
      condition: (WorldStates previous, WorldStates current) {
        return compareExpiry(
          previous.worldstate.cetusCycle?.expiry,
          current.worldstate.cetusCycle?.expiry,
        );
      },
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Cetus Day/Night Cycle',
          cycle: state.worldstate?.cetusCycle,
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
      condition: (WorldStates previous, WorldStates current) {
        return compareExpiry(
          previous.worldstate.vallisCycle?.expiry,
          current.worldstate.vallisCycle?.expiry,
        );
      },
      builder: (BuildContext context, WorldStates state) {
        return Cycle(
          title: 'Orb Vallis Warm/Cold Cycle',
          cycle: state.worldstate?.vallisCycle,
        );
      },
    );
  }
}
