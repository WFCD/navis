import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:simple_icons/simple_icons.dart';

class UserTitle extends StatelessWidget {
  const UserTitle({super.key, required this.username});

  final String username;

  IconData _icon(String platform) {
    final codepoint = platform.codeUnitAt(0).toRadixString(16);

    return switch (int.parse(codepoint[codepoint.length - 1])) {
      0 => SimpleIcons.steam,
      1 => SimpleIcons.xbox,
      2 => SimpleIcons.playstation,
      3 => SimpleIcons.nintendo,
      4 => SimpleIcons.ios,
      _ => WarframeSymbols.nightmare,
    };
  }

  @override
  Widget build(BuildContext context) {
    // 0x0 - pc
    // 0x1 - xbox
    // 0x2 - ps
    // 0x3 - switch
    // 0x4 - ios
    final name = username.substring(0, username.length - 1);
    final platform = username.substring(username.length - 1);

    return Row(mainAxisSize: MainAxisSize.min, spacing: 16, children: [Text(name), Icon(_icon(platform))]);
  }
}
