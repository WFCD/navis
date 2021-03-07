import 'package:flutter/material.dart';
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/fissures/fissure_widget.dart';

class FissuresPage extends TraceableStatelessWidget {
  const FissuresPage({Key key, @required this.state})
      : assert(state != null),
        super(key: key);

  final SolState state;

  @override
  Widget build(BuildContext context) {
    final fissures = state.worldstate.fissures ?? <VoidFissure>[];

    return ScreenTypeLayout.builder(
      mobile: (context) => MobileFissures(fissures: fissures),
      tablet: (context) => TabletFissures(fissures: fissures),
    );
  }
}

class MobileFissures extends StatelessWidget {
  const MobileFissures({Key key, @required this.fissures})
      : assert(fissures != null),
        super(key: key);

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: 200,
      itemCount: fissures.length,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(fissure: fissures[index]);
      },
    );
  }
}

class TabletFissures extends StatelessWidget {
  const TabletFissures({Key key, @required this.fissures})
      : assert(fissures != null),
        super(key: key);

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 2.0,
      ),
      itemCount: fissures.length,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(fissure: fissures[index]);
      },
    );
  }
}
