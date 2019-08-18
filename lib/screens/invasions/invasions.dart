import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/invasions_style.dart';

class InvasionsList extends StatelessWidget {
  const InvasionsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ws = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: ws.update,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
        child: BlocBuilder(
          bloc: ws,
          builder: (BuildContext context, WorldStates state) {
            if (state is WorldstateLoaded) {
              final invasions = state.worldstate?.invasions ?? [];

              if (invasions.isNotEmpty) {
                return ListView.builder(
                  itemCount: invasions.length,
                  itemBuilder: (BuildContext context, int index) =>
                      InvasionsStyle(invasion: invasions[index]),
                );
              }

              return const Center(child: Text('No invasions at this Time'));
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
