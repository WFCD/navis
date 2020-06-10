import 'package:flutter/material.dart';
import 'package:navis/features/worldstate/presentation/widgets/common/faction_icons.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class SentientOutpostCard extends StatelessWidget {
  const SentientOutpostCard({Key key, @required this.outpost})
      : assert(outpost != null),
        super(key: key);

  final SentientOutpost outpost;

  Mission get _mission => outpost.mission;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: ListTile(
        leading: const Icon(FactionIcons.sentient, size: 50),
        title: Text(_mission.node),
        subtitle: Text('${_mission.faction} | ${_mission.type}'),
        trailing: CountdownTimer(expiry: outpost.expiry),
      ),
    );
  }
}
