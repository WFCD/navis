import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/pages/acolyte_profile.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class AcolyteCard extends StatelessWidget {
  const AcolyteCard({Key key, this.enemies}) : super(key: key);

  final List<PersistentEnemies> enemies;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: enemies
            .map<Widget>((enemy) => AcolyteWidget(enemy: enemy))
            .toList(),
      ),
    );
  }
}

class AcolyteWidget extends StatefulWidget {
  const AcolyteWidget({Key key, @required this.enemy})
      : assert(enemy != null),
        super(key: key);

  final PersistentEnemies enemy;

  @override
  _AcolyteWidgetState createState() => _AcolyteWidgetState();
}

class _AcolyteWidgetState extends State<AcolyteWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;

  bool get _isDiscovered => widget.enemy.isDiscovered;

  void _setupController() {
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this)
      ..addStatusListener(_statusListener);

    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
        reverseCurve: Curves.easeInOut));

    _controller.forward().orCancel;
  }

  @override
  void initState() {
    super.initState();
    _setupController();
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed && !_isDiscovered) {
      _controller.repeat(reverse: true);
    }
  }

  Widget _searchStatus() {
    return Stack(
      children: <Widget>[
        FadeTransition(
          opacity: _opacity,
          child: Icon(Icons.gps_fixed),
        ),
        Icon(Icons.gps_not_fixed),
      ],
    );
  }

  @override
  void didUpdateWidget(AcolyteWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.enemy.isDiscovered != _isDiscovered) {
      _controller?.dispose();
      _setupController();
      _controller.resync(this);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${widget.enemy.agentType} | level: ${widget.enemy.rank}'),
      subtitle: const Text('Tap for more details'),
      trailing: StaticBox(
        color: _isDiscovered
            ? const Color(0xFFB00020)
            : Theme.of(context).primaryColor,
        icon: _searchStatus(),
        child: AnimatedCrossFade(
          firstChild: Text(widget.enemy.lastDiscoveredAt),
          secondChild: const Text('Locating...'),
          crossFadeState: _isDiscovered
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(milliseconds: 250),
        ),
      ),
      onTap: () {
        Navigator.of(context)
            .pushNamed(AcolyteProfile.route, arguments: widget.enemy);
      },
    );
  }

  @override
  void dispose() {
    _controller?.removeStatusListener(_statusListener);
    _controller?.dispose();
    _opacity = null;
    super.dispose();
  }
}
