import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/models/worldstate/fissure.dart';

import 'components/fissure_style.dart';

class FissureList extends StatelessWidget {
  const FissureList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ws = BlocProvider.of<WorldstateBloc>(context);

    return BlocBuilder<UpdateEvent, WorldStates>(
      bloc: ws,
      builder: (BuildContext context, WorldStates state) {
        if (state is WorldstateLoaded) {
          return CustomScrollView(slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 145,
              delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) =>
                      FissureCard(fissure: state.fissures[index]),
                  childCount: state.fissures.length),
            ),
          ]);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

Future<void> precacheAssetImages(
    BuildContext context, List<VoidFissure> fissures) async {
  final _nodeBackground = RegExp(r'\(([^)]*)\)');

  for (int i = 0; i < fissures.length; i++) {
    final node = _nodeBackground.firstMatch(fissures[i].node).group(1);

    await precacheImage(AssetImage('assets/skyboxes/$node.webp'), context);
  }
}
