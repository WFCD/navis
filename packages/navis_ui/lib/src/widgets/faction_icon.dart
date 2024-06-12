import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class FactionIcon extends StatelessWidget {
  const FactionIcon({
    Key? key,
    required this.name,
    this.size,
    this.useFactionColor = true,
  }) : super(key: key);

  final String name;
  final double? size;
  final bool useFactionColor;

  @override
  Widget build(BuildContext context) {
    final faction = EnemyFactions.fromString(name);
    final iconColor =
        faction?.colorScheme.iconColor ?? context.theme.colorScheme.primary;

    return AppIcon(
      faction?.icon ?? WarframeSymbols.menu_LotusEmblem,
      size: size,
      color: useFactionColor ? iconColor : Colors.white,
    );
  }
}
