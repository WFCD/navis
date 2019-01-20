import 'package:flutter/material.dart';
import 'package:navis/models/export.dart';
import 'package:navis/ui/widgets/cards.dart';

class WMD extends StatelessWidget {
  final Events event;

  WMD({@required this.event});

  _healthColor(double health) {
    if (health > 50.0)
      return Colors.green;
    else if (health <= 50.0 && health >= 10.0)
      return Colors.orange[700];
    else if (health < 10.0) return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    final double health = double.parse(event.health);
    final TextStyle style = TextStyle(
        fontSize: 15.0, color: Theme.of(context).textTheme.body2.color);

    return Tiles(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
                child:
                    Text(event.description, style: TextStyle(fontSize: 20.0))),
            Divider(color: Theme.of(context).accentColor),
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text(event.victimNode, style: style)),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Container(
                            padding: EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                                color: _healthColor(health),
                                borderRadius: BorderRadius.circular(8.0)),
                            child: Text('${event.health}\% Remaining',
                                style: style),
                          ),
                        ),
                      ]),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Container(
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8.0)),
                      child: Text(
                          '${event.rewards.first.itemString} + ${event.rewards.first.credits}cr',
                          style: style),
                    ),
                  ),
                ])
          ]),
    ));
  }
}
