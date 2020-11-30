import 'package:flutter/material.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/refresh_indicator_bloc_screen.dart';
import 'package:navis/features/worldstate/presentation/widgets/invasions/invasion_widget.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:warframestat_api_models/entities.dart';

class InvasionsPage extends StatelessWidget {
  const InvasionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (BuildContext context, SolsystemState state) {
        if (state is SolState) {
          final invasions = state.worldstate?.invasions ?? <Invasion>[];

          return ScreenTypeLayout.builder(
            mobile: (context) => MobileInvasions(invasions: invasions),
            tablet: (context) => TabletInvasions(invasions: invasions),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
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
    return CustomScrollView(
      key: const PageStorageKey<String>('invasions'),
      slivers: <Widget>[
        SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
          handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InvasionWidget(invasion: invasions[index]);
            },
            childCount: invasions.length,
          ),
        )
      ],
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
              return InvasionWidget(invasion: invasions[index]);
            },
            childCount: invasions.length,
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4.0,
            mainAxisSpacing: 8.0,
            crossAxisSpacing: 8.0,
          ),
        )
      ],
    );
  }
}
