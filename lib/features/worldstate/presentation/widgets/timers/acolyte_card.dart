import 'package:flutter/material.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/pages/acolyte_profile.dart';
import 'package:navis/generated/l10n.dart';
import 'package:warframestat_api_models/entities.dart';

class AcolyteCard extends StatelessWidget {
  const AcolyteCard({Key key, this.enemies}) : super(key: key);

  final List<PersistentEnemy> enemies;

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

  final PersistentEnemy enemy;

  @override
  _AcolyteWidgetState createState() => _AcolyteWidgetState();
}

class _AcolyteWidgetState extends State<AcolyteWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _opacity;

  PersistentEnemy get enemy => widget.enemy;

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
          child: const Icon(Icons.gps_fixed),
        ),
        const Icon(Icons.gps_not_fixed),
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
    final localizations = NavisLocalizations.of(context);

    return ListTile(
      title: Text(localizations.activeAcolyte(enemy.agentType, enemy.rank)),
      subtitle: Text(localizations.tapForMoreDetails),
      trailing: StaticBox(
        color: _isDiscovered
            ? const Color(0xFFB00020)
            : Theme.of(context).primaryColor,
        icon: _searchStatus(),
        child: AnimatedCrossFade(
          firstChild: Text(enemy.lastDiscoveredAt),
          secondChild: Text(localizations.locating),
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
