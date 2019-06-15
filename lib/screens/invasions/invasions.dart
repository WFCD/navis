import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';

import 'components/invasions_style.dart';

class InvasionsList extends StatelessWidget {
  const InvasionsList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: BlocProvider.of<WorldstateBloc>(context),
      builder: (BuildContext context, WorldStates state) {
        return ListView.builder(
          itemCount: state.invasions.length,
          itemBuilder: (BuildContext context, int index) =>
              InvasionsStyle(invasion: state.invasions[index]),
        );
      },
    );
  }
}
