import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/common/list_screen.dart';
import 'package:navis/widgets/fissures/fissures.dart';
import 'package:worldstate_api_model/entities.dart';

class FissureScreen extends StatelessWidget {
  const FissureScreen({Key key}) : super(key: key);

  bool condition(previous, current) {
    return compareIds(
      previous.worldstate?.fissures,
      current.worldstate?.fissures,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      condition: condition,
      builder: (context, state) {
        final fissures = state.worldstate?.fissures ?? <VoidFissure>[];

        return ListScreen(
          state: state,
          noItemsText: 'No Fissures at this time',
          items: fissures.map((f) => FissureWidget(fissure: f)).toList(),
        );
      },
    );
  }
}
