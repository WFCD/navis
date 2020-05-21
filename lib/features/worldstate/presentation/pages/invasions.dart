import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/widgets/invasions/invasion_widget.dart';

class InvasionsPage extends StatelessWidget {
  const InvasionsPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<SolsystemBloc>(context).update,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            final invasions = state.worldstate.invasions;
            final cacheExtent =
                (invasions.length - 2) * (InvasionWidget.height * 2) / 2;

            return ListView.builder(
              itemCount: invasions.length,
              cacheExtent: cacheExtent,
              itemBuilder: (BuildContext context, int index) {
                return InvasionWidget(invasion: invasions[index]);
              },
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
