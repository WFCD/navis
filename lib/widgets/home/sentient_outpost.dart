import 'package:flutter/material.dart';
import 'package:navis/widgets/common/cards.dart';
import 'package:navis/widgets/common/countdown.dart';
import 'package:navis/widgets/common/row_item.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class SentientOutpostPanel extends StatelessWidget {
  const SentientOutpostPanel({Key key, this.outpost}) : super(key: key);

  final SentientOutpost outpost;

  @override
  Widget build(BuildContext context) {
    final mission = '${outpost.mission.node} | '
        '${outpost.mission.type} | '
        '${outpost.mission.faction}';

    return Tiles(
      title: 'Sentient Outpost',
      child: RowItem(
        text: Text(mission),
        child: CountdownBox(expiry: outpost.expiry),
      ),
    );
  }
}
