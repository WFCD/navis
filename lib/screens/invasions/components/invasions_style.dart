import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:navis/components/layout/static_box.dart';
import 'package:navis/components/widgets/invasions_bar.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:worldstate_model/worldstate_models.dart';

class InvasionsStyle extends StatelessWidget {
  const InvasionsStyle({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;

  Widget _buildDetails(String faction, String reward) {
    return Container(
      child: Column(children: <Widget>[
        FactionIcon(faction, size: 50, hasColor: false),
        const SizedBox(height: 8.0),
        if (reward.isNotEmpty)
          StaticBox.text(text: reward, color: factionColor(faction))
      ]),
    );
  }

  Widget _buildInvasionDetails(
    BuildContext context,
    String node,
    String description,
    String eta,
  ) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    return Container(
      child: Column(children: <Widget>[
        Text(node,
            style: Theme.of(context)
                .textTheme
                .subhead
                .copyWith(fontSize: 15, shadows: <Shadow>[shadow])),
        Text('$description ($eta)',
            style: TextStyle(color: Theme.of(context).textTheme.caption.color)),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageCard(
      height: 200,
      provider: skybox(context, invasion.node),
      child: Column(children: <Widget>[
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildDetails(
                  invasion.attackingFaction,
                  invasion.attackerReward.itemString,
                ),
                const Spacer(),
                _buildDetails(
                  invasion.defendingFaction,
                  invasion.defenderReward.itemString,
                )
              ]),
        ),
        const Spacer(),
        _buildInvasionDetails(
          context,
          invasion.node,
          invasion.desc,
          invasion.eta,
        ),
        const SizedBox(height: 8.0),
        Padding(
          padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 8.0),
          child: InvasionBar(
            attackingFaction: invasion.attackingFaction,
            defendingFaction: invasion.defendingFaction,
            progress: invasion.completion / 100,
            lineHeight: 15.0,
          ),
        ),
      ]),
    );
  }
}
