import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/screen_widgets/invasions/invasions.dart';

class InvasionsList extends StatelessWidget {
  const InvasionsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: BlocProvider.of<WorldstateBloc>(context).update,
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        condition: (previous, current) {
          return compareList(
            previous.worldstate.invasions,
            current.worldstate.invasions,
          );
        },
        builder: (BuildContext context, WorldStates state) {
          if (state is WorldstateLoaded) {
            final invasions = state.worldstate?.invasions ?? [];

            if (invasions.isNotEmpty) {
              return ListView.builder(
                itemCount: invasions.length,
                cacheExtent: invasions.length / 2,
                itemBuilder: (BuildContext context, int index) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 2.0, vertical: 4.0),
                  child: InvasionWidget(invasion: invasions[index]),
                ),
              );
            }

            return const Center(child: Text('No invasions at this Time'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
