import 'package:flutter/material.dart';
import 'package:navis/util/assets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../animation/countdown.dart';
import '../model.dart';
import '../util/dynamicSwitch.dart';

class Fissure extends StatefulWidget {
  createState() => _Fissure();
}

class _Fissure extends State<Fissure> {
  Widget _fissureTiles(int index, NavisModel model) {
    final switcher = DynamicFaction(model: model);
    Duration timeLeft =
    DateTime.parse(model.fissures[index].expiry).difference(DateTime.now());

    return Padding(
      padding: EdgeInsets.all(4.0),
      child: Card(
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 5.0,
          color: Color.fromRGBO(187, 187, 197, 0.2),
          child: ListTile(
            leading: new Icon(
              _getTier(index, model.fissures),
              size: 45.0,
            ),
            title: Text(
              '${model.fissures[index].node} | ${model.fissures[index]
                  .missionType} | ${model.fissures[index].tier}',
              style: TextStyle(fontSize: 15.0),
            ),
            trailing: StreamBuilder<Duration>(
                initialData: Duration(seconds: 60),
                stream: CounterScreenStream(timeLeft),
                builder: (context, snapshot) {
                  Duration data = snapshot.data;

                  String hour = '${data.inHours}';
                  String minutes =
                  '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
                  String seconds =
                  '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

                  return Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                          color: switcher.alertColor(data),
                          borderRadius: BorderRadius.circular(3.0)),
                      child: Text('$hour:$minutes:$seconds',
                          style: TextStyle(color: Colors.white)));
                }),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(builder: (context, child, model) {
      return RefreshIndicator(
        onRefresh: () => model.update(),
        child: ListView.builder(
          itemCount: model.fissures.length,
          itemBuilder: (context, index) => _fissureTiles(index, model),
        ),
      );
    });
  }
}

_getTier(index, snapshot) {
  switch (snapshot[index].tier) {
    case 'Lith':
      return ImageAssets.lith;
      break;
    case 'Meso':
      return ImageAssets.meso;
      break;
    case 'Neo':
      return ImageAssets.neo;
      break;
    default:
      return ImageAssets.axi;
  }
}
