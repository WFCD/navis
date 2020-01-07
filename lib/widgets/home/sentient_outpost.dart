import 'package:flutter/material.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import '../common/cards.dart';

class SentientOutpostPanel extends StatelessWidget {
  const SentientOutpostPanel({Key key, this.outpost}) : super(key: key);

  final SentientOutpost outpost;

  @override
  Widget build(BuildContext context) {
    final mission = outpost.mission;

    final node = Theme.of(context)
        .textTheme
        .subhead
        .copyWith(fontWeight: FontWeight.w700);

    return Tiles(
      title: 'Sentient Outpost',
      child: RichText(
        text: TextSpan(children: <TextSpan>[
          TextSpan(text: '${mission?.node} ', style: node),
          TextSpan(
            text: '- ${mission?.faction} - ${mission.type}',
            style: Theme.of(context).textTheme.subhead,
          )
        ]),
      ),
    );
  }
}
