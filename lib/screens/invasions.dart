import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/common/list_screen.dart';
import 'package:navis/widgets/invasions/invasions.dart';

class InvasionsScreen extends StatelessWidget {
  const InvasionsScreen({Key key}) : super(key: key);

  bool condition(previous, current) {
    return compareIds(
      previous.worldstate?.invasions,
      current.worldstate?.invasions,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      buildWhen: condition,
      builder: (BuildContext context, WorldStates state) {
        final invasions = state.worldstate?.invasions ?? [];

        return ListScreen(
          state: state,
          noItemsText: 'No invasions at this time',
          items: invasions.map((i) => InvasionWidget(invasion: i)).toList(),
        );
      },
    );
  }
}
