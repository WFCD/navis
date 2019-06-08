import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/components/animations/countdown.dart';
import 'package:navis/models/worldstate/fissure.dart';

class FissureCard extends StatelessWidget {
  FissureCard({Key key, @required this.fissure}) : super(key: key);

  final VoidFissure fissure;

  final _nodeBackground = RegExp(r'\(([^)]*)\)');

  Widget _buildDetails(BuildContext context) {
    const node = TextStyle(
        fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontSize: 18);
    const missionType = TextStyle(
        fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 14);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500, fontStyle: FontStyle.normal, fontSize: 12);

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
              children: <Widget>[
                CountdownBox(expiry: fissure.expiry, color: Colors.transparent),
                const Text('Remaining')
              ],
            )
          ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Container(
          height: 130,
          width: 344,
          decoration: BoxDecoration(
              image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), BlendMode.dstATop),
                  image: AssetImage(
                      'assets/skyboxes/${_nodeBackground.firstMatch(fissure.node).group(1)}.webp'),
                  fit: BoxFit.cover)),
          child: Row(
            children: <Widget>[
              _buildDetails(context),
              Spacer(),
              Container(
                margin: const EdgeInsets.only(right: 28),
                height: 67,
                width: 60,
                child: SvgPicture.asset('assets/relics/${fissure.tier}.svg',
                    color: Colors.white),
              )
            ],
          ),
        ));
  }
}
