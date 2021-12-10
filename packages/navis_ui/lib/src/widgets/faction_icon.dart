import 'package:flutter/material.dart';
import 'package:navis_ui/src/helpers/faction_helper.dart';
import 'package:navis_ui/src/widgets/app_icon.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon({
    Key? key,
    required this.name,
    this.iconSize,
    this.useFactionColor = true,
  }) : super(key: key);

  final String name;
  final double? iconSize;
  final bool useFactionColor;

  @override
  Widget build(BuildContext context) {
    final faction = Factions.values.byName(name.toLowerCase());

    return AppIcon(
      faction.factionIcon,
      size: iconSize,
      color: useFactionColor ? faction.iconColor : Colors.white,
    );
  }
}
