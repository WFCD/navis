import 'package:flutter/material.dart';
import 'package:navis/util/assets.dart';
import 'package:scoped_model/scoped_model.dart';

import '../animation/countdown.dart';
import '../json/sortie.dart';
import '../model.dart';
import '../widgets/cards.dart';

class Sortie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<NavisModel>(
      builder: (context, child, model) {
        final title = ListTile(
          leading: Icon(_factionIcon(model),
              size: 45.0, color: _factionColor(model)),
          title: Text(model.sortie.boss),
          subtitle: Text(model.sortie.faction),
          trailing: Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: _durationColor(DateTime.parse(model.sortie.expiry)
                      .difference(DateTime.now())),
                  borderRadius: BorderRadius.circular(3.0)),
              child: StreamBuilder<Duration>(
                initialData: Duration(seconds: 60),
                stream: CounterScreenStream(DateTime.parse(model.sortie.expiry)
                    .difference(DateTime.now())),
                builder: (context, snapshot) {
                  Duration data = snapshot.data;

                  String hour = '${data.inHours}';
                  String minutes =
                      '${(data.inMinutes % 60).floor()}'.padLeft(2, '0');
                  String seconds =
                      '${(data.inSeconds % 60).floor()}'.padLeft(2, '0');

                  return Text('$hour:$minutes:$seconds',
                      style: TextStyle(color: Colors.white));
                },
              )),
        );

        Widget _buildMissions(Variants variants) {
          return Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Container(
                margin: EdgeInsets.only(bottom: 4.0, right: 4.0, left: 4.0),
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Text('${variants.missionType} - ${variants.node}',
                        style: TextStyle(fontSize: 15.0))
                  ]),
                  Row(children: <Widget>[
                    Expanded(
                        child: Text(variants.modifierDescription,
                            style: TextStyle(
                                color:
                                    Theme.of(context).textTheme.caption.color)))
                  ]),
                ]),
              ));
        }

        List<Widget> missions = model.sortie.variants
            .map(_buildMissions)
            .toList()
              ..insert(0, title);

        return Tiles(child: Column(children: missions));
      },
    );
  }
}

_durationColor(Duration timeLeft) {
  if (timeLeft >= Duration(hours: 12))
    return Colors.green;
  else if (timeLeft <= Duration(hours: 12))
    return Colors.orange;
  else if (timeLeft <= Duration(hours: 6)) return Colors.red;
}

_factionIcon(NavisModel model) {
  switch (model.sortie.faction) {
    case 'Grineer':
      return ImageAssets.grineer;
    case 'Corpus':
      return ImageAssets.corpus;
    case 'Corrupted':
      return ImageAssets.corrupted;
    default:
      return ImageAssets.infested;
  }
}

_factionColor(NavisModel model) {
  switch (model.sortie.faction) {
    case 'Corpus':
      return Colors.blue[300];
    case 'Grineer':
      return Colors.red[900];
    case 'Corrupted':
      return Colors.yellow[300];
    default:
      return Colors.green;
  }
}
