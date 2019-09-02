import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/widgets/animations.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

class AlertWidget extends StatelessWidget {
  AlertWidget({@required this.alert});

  final Alert alert;

  final _nightmareIcon = SvgPicture.asset('assets/general/nightmare.svg',
      color: Colors.red, height: 25, width: 25);

  final _archwingIcon = SvgPicture.asset('assets/general/archwing.svg',
      color: Colors.blue, height: 25, width: 25);

  @override
  Widget build(BuildContext context) {
    final archwing = alert.mission.archwingRequired;
    final nightmare = alert.mission.nightmare;

    return Container(
      padding: const EdgeInsets.only(bottom: 8.0, top: 5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RowItem(
              icons: <Widget>[
                if (archwing) _archwingIcon,
                if (nightmare) _nightmareIcon
              ],
              text: alert.mission.node,
              child: alert.mission.reward.itemString.isEmpty
                  ? Container()
                  : StaticBox(
                      color: Colors.blueAccent[400],
                      child: Text(
                        alert.mission.reward.itemString,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                            color: Colors.white),
                      )),
            ),
            RowItem(
                text: '${alert.mission.type} (${alert.mission.faction}) '
                    '| Level: ${alert.mission.minEnemyLevel} - ${alert.mission.maxEnemyLevel} '
                    '| ${alert.mission.reward.credits}cr',
                caption: true,
                child: CountdownBox(expiry: alert.expiry)),
          ]),
    );
  }
}
