import 'package:flutter/material.dart';
import 'package:navis_ui/src/helpers/faction_helper.dart';
import 'package:navis_ui/src/widgets/app_icon.dart';
import 'package:warframe_common/warframe_common.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon({
    super.key,
    required this.name,
    this.size,
    this.useFactionColor = true,
  });

  final String name;
  final double? size;
  final bool useFactionColor;

  @override
  Widget build(BuildContext context) {
    final faction = Faction.values.firstWhere((f) => f.name == name.toLowerCase(), orElse: () => Faction.unknown);

    return AppIcon(
      faction.factionIcon,
      size: size,
      color: useFactionColor ? faction.iconColor : Colors.white,
    );
  }
}
