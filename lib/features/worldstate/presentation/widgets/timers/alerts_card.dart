import 'package:flutter/material.dart';
import 'package:navis/core/widgets/icons.dart';
import 'package:navis/core/widgets/row_item.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/generated/l10n.dart';
import 'package:worldstate_api_model/entities.dart';

class AlertsCard extends StatelessWidget {
  const AlertsCard({Key key, @required this.alerts})
      : assert(alerts != null),
        super(key: key);

  final List<Alert> alerts;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        children: alerts.map((a) => AlertWidget(alert: a)).toList(),
      ),
    );
  }
}

class AlertWidget extends StatelessWidget {
  const AlertWidget({Key key, @required this.alert})
      : assert(alert != null),
        super(key: key);

  final Alert alert;

  Mission get _mission => alert.mission;

  bool get _isRewarding => _mission.reward.itemString.isEmpty;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final locale = NavisLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RowItem(
            icons: <Widget>[
              // Not sure we need to add nightmare icon since alerts have be axed
              // nightmare alerts haven't been a thing
              if (_mission.archwingRequired)
                NavisSystemIconWidgets.archwingIcon
            ],
            text: Text(_mission.node),
            child: _isRewarding
                ? Container()
                : StaticBox.text(
                    text: _mission.reward.itemString,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
          ),
          RowItem(
            text: Text(
              '${_mission.type} (${_mission.faction}) '
              '| ${locale.levelInfo(_mission.minEnemyLevel, _mission.maxEnemyLevel)}',
              style: textTheme.caption,
            ),
            child: CountdownTimer(expiry: alert.expiry),
          )
        ],
      ),
    );
  }
}
