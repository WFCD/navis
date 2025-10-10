import 'package:cached_network_image/cached_network_image.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({super.key, required this.item, required this.onTap, this.showDescription = false});

  final CodexItem item;
  final bool showDescription;
  final void Function() onTap;

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

    return ListTile(
      leading: Hero(
        tag: item.uniqueName,
        child: CircleAvatar(
          foregroundImage: item.imageName != null ? CachedNetworkImageProvider(imageUri(item.imageName)) : null,
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ),
      title: Text(item.name.parseHtmlString()),
      subtitle: showDescription
          ? Text(
              description?.trim() ?? item.description?.parseHtmlString() ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      isThreeLine: showDescription,
      dense: showDescription,
      onTap: onTap,
    );
  }
}
