import 'package:flutter/material.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/common/skybox_card.dart';
import 'package:navis/widgets/icons.dart';
import 'package:warframestat_api_models/entities.dart';

class SentientOutpostPanel extends StatelessWidget {
  const SentientOutpostPanel({Key key, this.outpost}) : super(key: key);

  final SentientOutpost outpost;

  @override
  Widget build(BuildContext context) {
    final mission = outpost.mission;

    final fontSize = SizeConfig.textMultiplier * 5;

    final node = Theme.of(context)
        .textTheme
        .subtitle1
        .copyWith(color: Colors.white, fontSize: fontSize);

    // TODO(Ornstein): Need to get a veil proxima skybox but for now the Kuva Fortress will do
    return SkyboxCard(
      node: mission.node,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Icon(
              FactionIcons.sentient,
              size: 150,
              color: Colors.grey[600],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${mission.node}', style: node),
              const SizedBox(height: 4.0),
              Text(
                '${mission.faction} | ${mission.type}',
                style: Typography.whiteMountainView.subtitle1,
              )
            ],
          )
        ],
      ),
    );
  }
}
