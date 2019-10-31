import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/utils/factionutils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:navis/widgets/widgets/static_box.dart';

class DateView extends StatelessWidget {
  const DateView({Key key, this.expiry, this.color}) : super(key: key);

  final DateTime expiry;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final persistent = RepositoryProvider.of<Repository>(context).persistent;

    return WatchBoxBuilder(
      box: persistent.hiveBox,
      watchKeys: const [SettingsKeys.dateformatKey],
      builder: (BuildContext context, Box state) {
        final dateFormat = enumToDateformat(persistent.dateformat);

        return StaticBox(
          color: color ?? Colors.blueAccent[400],
          child: Text(
            '${expiration(expiry, format: dateFormat)}',
            style: const TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
