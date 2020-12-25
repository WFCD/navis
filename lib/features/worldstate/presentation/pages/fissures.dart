import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../bloc/solsystem_bloc.dart';
import '../widgets/common/refresh_indicator_bloc_screen.dart';
import '../widgets/fissures/fissure_widget.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (BuildContext context, SolsystemState state) {
        if (state is SolState) {
          final fissures = state.worldstate?.fissures ?? <VoidFissure>[];

          return ScreenTypeLayout.builder(
            mobile: (context) => MobileFissures(fissures: fissures),
            tablet: (context) => TabletFissures(fissures: fissures),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
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
    return CustomScrollView(
      key: const PageStorageKey<String>('fissures_mobile'),
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return FissureWidget(fissure: fissures[index]);
          },
          childCount: fissures.length,
        ))
      ],
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
    return CustomScrollView(
      key: const PageStorageKey<String>('fissures_tablet'),
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return FissureWidget(fissure: fissures[index]);
            },
            childCount: fissures.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 6.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        )
      ],
    );
  }
}
