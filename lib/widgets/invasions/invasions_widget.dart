import 'package:flutter/material.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'invasion_details.dart';
import 'invasion_reward.dart';
import 'invasions_bar.dart';

class InvasionWidget extends StatefulWidget {
  const InvasionWidget({Key key, this.invasion}) : super(key: key);

  final Invasion invasion;

  @override
  _InvasionWidgetState createState() => _InvasionWidgetState();
}

class _InvasionWidgetState extends State<InvasionWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    final completion = widget.invasion.completion.toDouble();

    final tween = Tween<double>(begin: 0, end: completion)
        .chain(CurveTween(curve: Curves.easeInOut));

    return SkyboxCard(
      height: 200,
      node: widget.invasion.node,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        child: Column(children: <Widget>[
          const Spacer(),
          InvasionDetails(
            node: widget.invasion.node,
            description: widget.invasion.desc,
            eta: widget.invasion.eta,
          ),
          const Spacer(),
          InvasionReward(
            attackerReward: widget.invasion.attackerReward.itemString,
            defenderReward: widget.invasion.defenderReward.itemString,
            attackingFaction: widget.invasion.attackingFaction,
            defendingFaction: widget.invasion.defendingFaction,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
            child: ControlledAnimation(
              duration: const Duration(milliseconds: 500),
              tween: tween,
              builder: (context, animation) {
                return InvasionBar(
                  attackingFaction: widget.invasion.attackingFaction,
                  defendingFaction: widget.invasion.defendingFaction,
                  progress: animation / 100,
                  lineHeight: 15.0,
                );
              },
            ),
          ),
        ]),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
