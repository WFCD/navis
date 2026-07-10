import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:navis/items/items.dart';
import 'package:warframe_common/warframe_common.dart';

class OpenItemContainer extends StatelessWidget {
  const OpenItemContainer({super.key, required this.item, required this.closedBuilder});

  final WarframeItem item;
  final CloseContainerBuilder closedBuilder;

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedBuilder: closedBuilder,
      openBuilder: (_, _) => ItemDetailPage(item: item),
    );
  }
}
