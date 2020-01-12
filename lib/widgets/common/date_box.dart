import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/resources/storage/persistent.dart';
import 'package:navis/utils/extensions.dart';
import 'package:navis/utils/worldstate_utils.dart';

import 'static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry, this.color}) : super(key: key);

  final DateTime expiry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<PersistentResource>(context);

    final dateFormat = enumToDateformat(persistent.dateformat);

    return StaticBox(
      color: color ?? Colors.blueAccent[400],
      child: Text(
        '${expiry.format(dateFormat)}',
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
