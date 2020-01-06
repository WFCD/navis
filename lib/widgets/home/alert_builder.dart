import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import 'alert_widget.dart';

class AlertPanel extends StatelessWidget {
  const AlertPanel({Key key, this.alerts}) : super(key: key);

  final List<Alert> alerts;

  @override
  Widget build(BuildContext context) {
    return Tiles(
      title: 'Alerts',
      child: Column(children: <Widget>[
        ...alerts.map((alert) => AlertWidget(alert: alert))
      ]),
    );
  }
}
