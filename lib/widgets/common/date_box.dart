import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navis/utils/extensions.dart';

import 'static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry, this.color}) : super(key: key);

  final DateTime expiry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return StaticBox(
      color: color ?? Colors.blueAccent[400],
      child: Text(
        expiry.toLocal().format(Intl.getCurrentLocale()),
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
