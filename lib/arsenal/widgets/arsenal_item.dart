import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class ArsenalItemWidget extends StatelessWidget {
  const ArsenalItemWidget({super.key, required this.arsenalItem});

  final MasteryProgress arsenalItem;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: arsenalItem.item.imageUrl,
          width: 50,
        ),
        title: Text(arsenalItem.item.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Rank ${arsenalItem.rank}'),
            LinearProgressIndicator(
              value: arsenalItem.rank / arsenalItem.maxRank,
            ),
          ],
        ),
      ),
    );
  }
}
