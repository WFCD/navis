import 'package:flutter/material.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'invasion_progress.dart';
import 'invasion_rewards.dart';

class InvasionWidget extends StatefulWidget {
  const InvasionWidget({Key key, @required this.invasion})
      : assert(invasion != null),
        super(key: key);

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

  Widget _buildDetails(String node, String description, String eta) {
    const shadow = Shadow(offset: Offset(1.0, 0.0), blurRadius: 4.0);

    final _node = Typography.whiteMountainView.subhead
        .copyWith(fontSize: 15, shadows: <Shadow>[shadow]);

    return Container(
      child: Column(children: <Widget>[
        Text(node, style: _node),
        Text(
          '$description ($eta)',
          style: Theme.of(context)
              .textTheme
              .caption
              .copyWith(shadows: <Shadow>[shadow]),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
        child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          const Spacer(),
          _buildDetails(
            widget.invasion.node,
            widget.invasion.desc,
            widget.invasion.eta,
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
                return InvasionProgress(
                  progress: _progress.value / 100,
                  attackingFaction: widget.invasion.attackingFaction,
                  defendingFaction: widget.invasion.defendingFaction,
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
