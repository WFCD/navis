import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class InvasionsPage extends TraceableStatelessWidget {
  const InvasionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SolsystemCubit>().state;
    final invasions =
        state is SolState ? state.worldstate.invasions : <Invasion>[];

    return ViewLoading(
      isLoading: state is! SolState,
      child: state is! SolState
          ? nil
          : ScreenTypeLayout.builder(
              mobile: (context) => _MobileInvasions(invasions: invasions),
              tablet: (context) => _TabletInvasions(invasions: invasions),
            ),
    );
  }
}

class _MobileInvasions extends StatelessWidget {
  const _MobileInvasions({required this.invasions});

  final List<Invasion> invasions;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: ConstructionProgressCard()),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => InvasionWidget(invasion: invasions[index]),
            childCount: invasions.length,
          ),
        ),
      ],
    );
  }
}

class _TabletInvasions extends StatelessWidget {
  const _TabletInvasions({required this.invasions});

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
