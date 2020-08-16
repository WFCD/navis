import 'package:flutter/material.dart';
import 'package:navis/widgets/common/countdown.dart';
import 'package:navis/widgets/common/skybox_card.dart';
import 'package:navis/widgets/icons.dart';
import 'package:warframestat_api_models/entities.dart';

class SentientOutpostPanel extends StatelessWidget {
  const SentientOutpostPanel({Key key, this.outpost}) : super(key: key);

  final SentientOutpost outpost;

  @override
  Widget build(BuildContext context) {
    // TODO(Ornstein): Need to get a veil proxima skybox but for now the Kuva Fortress will do
    return SkyboxCard(
      node: outpost.node,
      child: ListTile(
        leading: const Icon(FactionIcons.sentient, size: 50),
        title: Text(outpost.node),
        subtitle: Text('${outpost.faction} | ${outpost.type}'),
        trailing: CountdownBox(expiry: outpost.expiry),
      ),
    );
  }
}
