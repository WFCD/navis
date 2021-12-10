import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/widgets/fissure_widgets.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:nil/nil.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

class FissuresPage extends TraceableStatelessWidget {
  const FissuresPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<SolsystemCubit>().state;
    final fissures =
        state is SolState ? state.worldstate.fissures : <VoidFissure>[];

    return ViewLoading(
      isLoading: state is! SolState,
      child: state is! SolState
          ? nil
          : ScreenTypeLayout.builder(
              mobile: (context) => MobileFissures(fissures: fissures),
              tablet: (context) => TabletFissures(fissures: fissures),
            ),
    );
  }
}

class MobileFissures extends StatelessWidget {
  const MobileFissures({Key? key, required this.fissures}) : super(key: key);

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    final height = (MediaQuery.of(context).size.height / 100) * 15;

    return ListView.builder(
      cacheExtent: height * 5,
      itemExtent: height,
      itemCount: fissures.length,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(
          key: ValueKey(fissures[index].id),
          fissure: fissures[index],
        );
      },
    );
  }
}

class TabletFissures extends StatelessWidget {
  const TabletFissures({Key? key, required this.fissures}) : super(key: key);

  final List<VoidFissure> fissures;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 2,
      ),
      itemCount: fissures.length,
      itemBuilder: (BuildContext context, int index) {
        return FissureWidget(fissure: fissures[index]);
      },
    );
  }
}
