import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/common/list_screen.dart';
import 'package:navis/widgets/invasions/invasions.dart';
import 'package:worldstate_api_model/entities.dart';

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
      condition: condition,
      builder: (BuildContext context, WorldStates state) {
        final invasions = state.worldstate?.invasions ?? [];

        return ListScreen<Invasion>(
          state: state,
          emptyList: 'No invasions at this time',
          items: invasions,
          buildWidget: (BuildContext context, Invasion object) {
            return InvasionWidget(invasion: object);
          },
        );
      },
    );
  }
}
