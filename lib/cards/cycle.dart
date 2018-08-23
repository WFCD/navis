import 'dart:async';

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../model.dart';
import '../widgets/cards.dart';

enum Cycle { cetus, earth }

class CetusCycle extends StatefulWidget {
  final Cycle cycle;

  CetusCycle({@required this.cycle});

  @override
  createState() => _CetusCycle();
}

class _CetusCycle extends State<CetusCycle> with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _cycle(Cycle cycle) {
    switch (cycle) {
      case Cycle.cetus:
        return 'Cetus Day/Night Cycle';
      case Cycle.earth:
        return 'Earth Day/Night Cycle';
    }
  }

  _modelCycle(NavisModel model) {
    if (widget.cycle == Cycle.cetus)
      return model.cetus;
    else
      return model.earth;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle style = TextStyle(fontSize: 15.0);
    return ScopedModelDescendant<NavisModel>(builder: (context, child, model) {
      var cycle = _modelCycle(model);
      model.cetusTime.listen((data) {},
          onDone: () => Future.delayed(
              Duration(milliseconds: 500), () => model.update()));

      return Tiles(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
              padding: const EdgeInsets.only(top: 4.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RichText(
                      text: new TextSpan(
                          text: _cycle(widget.cycle),
                          style: TextStyle(fontSize: 20.0)))
                ],
              )),
          new Divider(color: Theme.of(context).accentColor),
          new Container(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  new RichText(
                      text:
                          new TextSpan(text: 'Currently it is', style: style)),
                  cycle.isDay == true
                      ? new RichText(
                          text: new TextSpan(
                              text: 'Day',
                              style: TextStyle(
                                  color: Colors.yellow[700],
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)))
                      : new RichText(
                          text: new TextSpan(
                              text: 'Night',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold)))
                ],
              )),
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                cycle.isDay == true
                    ? new RichText(
                        text: new TextSpan(
                            text: 'Time until Night', style: style))
                    : new RichText(
                        text:
                            new TextSpan(text: 'Time until Day', style: style)),
                new Container(
                    padding: EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                        color: cycle.isDay == true
                            ? Colors.green
                            : Colors.blueAccent[400],
                        borderRadius: BorderRadius.all(Radius.circular(3.0))),
                    child: StreamBuilder<Duration>(
                        initialData: Duration(seconds: 60),
                        stream: widget.cycle == Cycle.cetus
                            ? model.cetusTime
                            : model.earthTime,
                        builder: (context, snapshot) {
                          Duration data = snapshot.data;

                          String hour = '${data.inHours}';
                          String minutes = '${(data.inMinutes % 60).floor()}'
                              .padLeft(2, '0');
                          String seconds = '${(data.inSeconds % 60).floor()}'
                              .padLeft(2, '0');

                          return Text('$hour:$minutes:$seconds',
                              style: TextStyle(color: Colors.white));
                        }))
              ],
            ),
          ),
          new Container(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                cycle.isDay == true
                    ? new RichText(
                        text: new TextSpan(text: 'Time at Night', style: style))
                    : new RichText(
                        text: new TextSpan(text: 'Time at Day', style: style)),
                new Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                        color: Colors.blueAccent[400],
                        borderRadius:
                            const BorderRadius.all(const Radius.circular(3.0))),
                    child: new RichText(
                        text: new TextSpan(
                            text: widget.cycle == Cycle.cetus
                                ? '${model.cetusExpiry}'
                                : '${model.earthExpiry}',
                            style: TextStyle(color: Colors.white)))),
              ],
            ),
          )
        ],
      ));
    });
  }
}
