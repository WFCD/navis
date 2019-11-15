import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/services/repository.dart';
import 'package:wfcd_api_wrapper/wfcd_wrapper.dart';

import 'platform_icon.dart';

class PlatformChoice extends StatelessWidget {
  const PlatformChoice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WatchBoxBuilder(
      box: RepositoryProvider.of<Repository>(context).persistent.hiveBox,
      watchKeys: const [SettingsKeys.platformKey],
      builder: (BuildContext context, Box box) {
        return Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget>[
            PlatformIcon(platform: Platforms.pc),
            PlatformIcon(platform: Platforms.ps4),
            PlatformIcon(platform: Platforms.xb1),
            PlatformIcon(platform: Platforms.swi)
          ],
        );
      },
    );
  }
}
