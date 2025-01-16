import 'package:flutter/material.dart';
import 'package:navis/profile/widgets/arsenal_item.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItems extends StatelessWidget {
  const ArsenalItems({super.key, required this.items});

  final List<MasteryProgress> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => ArsenalItemWidget(item: items[index]),
    );
  }
}
