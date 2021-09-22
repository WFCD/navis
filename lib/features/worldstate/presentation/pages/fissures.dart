import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:matomo/matomo.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/widgets/bloc_progress_loader.dart';
import '../bloc/solsystem_bloc.dart';
import '../widgets/fissures/fissure_widget.dart';

class FissuresPage extends TraceableStatelessWidget {
  const FissuresPage({Key? key}) : super(key: key);

  bool _buildWhen(SolsystemState p, SolsystemState n) {
    if (p is SolState && n is SolState) {
      return p.worldstate.fissures.length != n.worldstate.fissures.length;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilerProgressLoader<SolsystemBloc, SolsystemState>(
      buildWhen: _buildWhen,
      isLoaded: (state) => state is SolState,
      builder: (context, state) {
        final fissures = (state as SolState).worldstate.fissures;

        return ScreenTypeLayout.builder(
          mobile: (context) => MobileFissures(fissures: fissures),
          tablet: (context) => TabletFissures(fissures: fissures),
        );
      },
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
