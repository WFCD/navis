import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/components/animations/countdown.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class FissureCard extends StatelessWidget {
  const FissureCard({Key key, @required this.fissure}) : super(key: key);

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      elevation: 6.0,
      provider: skybox(context, fissure.node),
      child: Row(
        children: <Widget>[
          _BuildDetails(fissure: fissure, context: context),
          const Spacer(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 28),
            height: 67,
            width: 60,
            child: SvgPicture.asset(
              'assets/relics/${fissure.tier}.svg',
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}

class _BuildDetails extends StatelessWidget {
  const _BuildDetails({
    Key key,
    @required this.fissure,
    @required this.context,
  }) : super(key: key);

  final VoidFissure fissure;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 3.0);

    const node = TextStyle(
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.normal,
        fontSize: 18,
        color: color,
        shadows: <Shadow>[shadow]);
    const missionType = TextStyle(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 14,
        color: color,
        shadows: <Shadow>[shadow]);

    final info = Theme.of(context).textTheme.caption.copyWith(
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.normal,
        fontSize: 12,
        color: color,
        shadows: <Shadow>[shadow]);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                const Text('Remaining', style: TextStyle(color: color))
              ],
            )
          ]),
    );
  }
}
