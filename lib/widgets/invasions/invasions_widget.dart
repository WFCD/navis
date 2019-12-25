import 'package:flutter/material.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

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
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  Animation<double> _progress;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    _progress =
        Tween<double>(begin: 0, end: widget.invasion.completion.toDouble())
            .chain(CurveTween(curve: Curves.easeInOut))
            .animate(_controller);

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

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
            child: AnimatedBuilder(
              animation: _progress,
              builder: (BuildContext context, Widget child) {
                return InvasionBar(
                  attackingFaction: widget.invasion.attackingFaction,
                  defendingFaction: widget.invasion.defendingFaction,
                  progress: _progress.value / 100,
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

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
