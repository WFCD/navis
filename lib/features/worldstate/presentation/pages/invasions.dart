import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/invasions/invasion_widget.dart';

class InvasionsPage extends StatelessWidget {
  const InvasionsPage({Key key, @required this.state})
      : assert(state != null),
        super(key: key);

  final SolState state;

  @override
  Widget build(BuildContext context) {
    final invasions = state.worldstate?.invasions ?? <Invasion>[];

    return ScreenTypeLayout.builder(
      mobile: (context) => MobileInvasions(invasions: invasions),
      tablet: (context) => TabletInvasions(invasions: invasions),
    );
  }
}

class MobileInvasions extends StatelessWidget {
  const MobileInvasions({Key key, @required this.invasions})
      : assert(invasions != null),
        super(key: key);

  final List<Invasion> invasions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 250,
      itemCount: invasions.length,
      itemBuilder: (BuildContext context, int index) {
        return InvasionWidget(invasion: invasions[index]);
      },
    );
  }
}

class TabletInvasions extends StatelessWidget {
  const TabletInvasions({Key key, @required this.invasions})
      : assert(invasions != null),
        super(key: key);

  final List<Invasion> invasions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4.0,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InvasionWidget(invasion: invasions[index]);
      },
    );
  }
}
