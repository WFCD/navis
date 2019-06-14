import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/components/animations/countdown.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/models/worldstate/fissure.dart';

class FissureCard extends StatelessWidget {
  FissureCard({Key key, @required this.fissure}) : super(key: key);

  final VoidFissure fissure;

  final _nodeBackground = RegExp(r'\(([^)]*)\)');

  Widget _buildDetails(BuildContext context) {
    final color = Colors.white;
    final node = TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        color: color);
    final missionType = TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: color);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 12,
        color: color);

    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(fissure.node, style: node),
            Text(fissure.missionType, style: missionType),
            const SizedBox(height: 16),
            Text('${fissure.tier} Fissure', style: info),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CountdownBox(
                    expiry: fissure.expiry,
                    color: Colors.transparent,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero),
                const SizedBox(width: 8.0),
                Text('Remaining', style: TextStyle(color: color))
              ],
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final relic = 'assets/relics/${fissure.tier}.svg';
    final backgroundImage =
        'assets/skyboxes/${_nodeBackground.firstMatch(fissure.node).group(1)}.webp';

    return BackgroundImageCard(
      provider: AssetImage(backgroundImage),
      child: Row(
        children: <Widget>[
          _buildDetails(context),
          const Spacer(),
          Container(
            margin: const EdgeInsets.only(right: 28),
            height: 67,
            width: 60,
            child: SvgPicture.asset(relic, color: Colors.white),
          )
        ],
      ),
    );
  }
}
