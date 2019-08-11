import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/fissure_style.dart';

class FissureList extends StatelessWidget {
  const FissureList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ws = BlocProvider.of<WorldstateBloc>(context);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      child: BlocBuilder<WorldstateBloc, WorldStates>(
        bloc: ws,
        builder: (BuildContext context, WorldStates state) {
          if (state is WorldstateLoaded) {
            return CustomScrollView(slivers: <Widget>[
              SliverFixedExtentList(
                itemExtent: 145,
                delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) =>
                        FissureCard(fissure: state.worldstate.fissures[index]),
                    childCount: state.worldstate.fissures.length),
              ),
            ]);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
