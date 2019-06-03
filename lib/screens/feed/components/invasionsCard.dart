import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/styles/invasions_style.dart';

import 'package:navis/components/layout.dart';
import 'package:navis/components/styles.dart';

class InvasionCard extends StatelessWidget {
  const InvasionCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final wstate = BlocProvider.of<WorldstateBloc>(context);

    return Tiles(
      child: BlocBuilder(
          bloc: wstate,
          builder: (context, state) {
            if (state is WorldstateLoaded) {
              final invasions =
                  state.invasions.map((i) => InvasionStyle(invasion: i));
              final length = invasions.length;

              return ExpandedInfo(
                header: Column(children: <Widget>[...invasions.take(2)]),
                body: Column(children: <Widget>[...invasions.skip(2)]),
                condition: length < 3,
              );
            }
          }),
    );
  }
}
