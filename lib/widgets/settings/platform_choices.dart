import 'package:flutter/material.dart';
import 'package:navis/utils/enums.dart';

import 'platform_icon.dart';

class PlatformChoice extends StatelessWidget {
  const PlatformChoice({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
