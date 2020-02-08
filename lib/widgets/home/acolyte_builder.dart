import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/widgets/widgets.dart';

import 'acolyte_widget.dart';

class Acolytes extends StatelessWidget {
  const Acolytes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WorldstateBloc, WorldStates>(
      builder: (context, state) {
        final acolytes = state.worldstate?.persistentEnemies ?? [];

        return Tiles(
          title: 'Acolytes',
          child: Column(
            children: acolytes.map((e) => AcolyteWidget(enemy: e)).toList(),
          ),
        );
      },
    );
  }
}
