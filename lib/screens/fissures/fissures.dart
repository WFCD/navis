import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/global_keys.dart';
import 'package:navis/models/worldstate/fissure.dart';

import 'components/fissure_style.dart';

class FissureList extends StatefulWidget {
  const FissureList({Key key}) : super(key: key);

  @override
  _FissureListState createState() => _FissureListState();
}

class _FissureListState extends State<FissureList> {
  @override
  void didChangeDependencies() {
    precacheAssetImages(context,
        BlocProvider.of<WorldstateBloc>(context).currentState.fissures);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final ws = BlocProvider.of<WorldstateBloc>(context);

    return Stack(children: <Widget>[
      BlocBuilder<UpdateEvent, WorldStates>(
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
      ),
      Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FloatingActionButton(
            child: Icon(Icons.refresh, color: Colors.white),
            backgroundColor: Theme.of(context).accentColor,
            onPressed: () {
              ws.update();
              scaffold.currentState.showSnackBar(SnackBar(
                content: const Text('Updated Fissures'),
              ));
            },
          ),
        ),
      )
    ]);
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
