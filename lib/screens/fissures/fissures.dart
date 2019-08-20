import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/fissure_style.dart';

class FissureList extends StatelessWidget {
  const FissureList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ws = BlocProvider.of<WorldstateBloc>(context);

    return RefreshIndicator(
      onRefresh: ws.update,
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        bloc: ws,
        builder: (BuildContext context, WorldStates state) {
          if (state is WorldstateLoaded) {
            final fissures = state.worldstate?.fissures ?? [];

            if (fissures.isNotEmpty) {
              return ListView.builder(
                itemCount: fissures.length,
                cacheExtent: fissures.length / 2,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4.0,
                      vertical: 2.0,
                    ),
                    child: FissureCard(fissure: fissures[index]),
                  );
                },
              );
            }

            return const Center(child: Text('No fissures at this Time'));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
