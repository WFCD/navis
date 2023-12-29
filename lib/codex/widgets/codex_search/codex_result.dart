import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    String? description;

    if (item is Mod) {
      final levelStats = (item as Mod).levelStats;

      if (levelStats != null) {
        description = levelStats.last.stats.fold('', (p, e) {
          return p == null ? '$e ' : '$p $e ';
        });
      }

      if (description != null) {
        description = description.parseHtmlString();
      }
    }

    return AppCard(
      padding: EdgeInsets.zero,
      child: ListTile(
        leading: Hero(
          tag: item.uniqueName,
          child: CircleAvatar(
            backgroundImage: item.imageName != null
                ? CachedNetworkImageProvider(item.imageUrl)
                : null,
            backgroundColor: Theme.of(context).canvasColor,
          ),
        ),
        title: Text(item.name.parseHtmlString()),
        subtitle: Text(
          description?.trim() ?? item.description?.parseHtmlString() ?? '',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        isThreeLine: true,
        dense: true,
      ),
    );
  }
}
