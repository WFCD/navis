import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'fissure_details.dart';

class FissureWidget extends StatelessWidget {
  const FissureWidget({Key key, @required this.fissure}) : super(key: key);

  final VoidFissure fissure;

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      elevation: 6.0,
      provider: skybox(context, fissure.node),
      child: Row(
        children: <Widget>[
          FissureDetails(fissure: fissure, context: context),
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
