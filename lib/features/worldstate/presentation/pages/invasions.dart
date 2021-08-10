import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/invasions/invasion_widget.dart';

class InvasionsPage extends TraceableStatelessWidget {
  const InvasionsPage({Key? key, required this.state}) : super(key: key);

  final SolState state;

  @override
  Widget build(BuildContext context) {
    final invasions = state.worldstate.invasions;

    return ScreenTypeLayout.builder(
      mobile: (context) => MobileInvasions(invasions: invasions),
      tablet: (context) => TabletInvasions(invasions: invasions),
    );
  }
}

class MobileInvasions extends StatelessWidget {
  const MobileInvasions({Key? key, required this.invasions}) : super(key: key);

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
  const TabletInvasions({Key? key, required this.invasions}) : super(key: key);

  final List<Invasion> invasions;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2.5,
        mainAxisSpacing: 4,
        crossAxisSpacing: 2,
      ),
      itemCount: invasions.length,
      itemBuilder: (BuildContext context, int index) {
        return InvasionWidget(invasion: invasions[index]);
      },
    );
  }
}
