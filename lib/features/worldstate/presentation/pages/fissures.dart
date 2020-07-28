import 'package:flutter/material.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/refresh_indicator_bloc_screen.dart';
import 'package:navis/features/worldstate/presentation/widgets/fissures/fissure_widget.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicatorBlocScreen(
      builder: (BuildContext context, SolsystemState state) {
        if (state is SolState) {
          final fissures = state.worldstate.fissures;
          final cacheExtent =
              (fissures.length - 3) * (FissureWidget.height * 2) / 2;

          return ListView.builder(
            itemCount: fissures.length,
            cacheExtent: cacheExtent,
            itemBuilder: (BuildContext context, int index) {
              return FissureWidget(fissure: fissures[index]);
            },
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
