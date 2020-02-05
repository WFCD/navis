import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/fissures/fissure_widget.dart';

class FissuresPage extends StatelessWidget {
  const FissuresPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<SolsystemBloc>(context).update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            final worldstate = state.worldstate;

            return ListView.builder(
              itemCount: worldstate.fissures.length,
              cacheExtent: worldstate.fissures.length / 2,
              itemBuilder: (BuildContext context, int index) {
                return FissureWidget(fissure: worldstate.fissures[index]);
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
