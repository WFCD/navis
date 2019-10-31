import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/screens/codex_entry.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class ItemResultWidget extends StatelessWidget {
  const ItemResultWidget({Key key, this.item}) : super(key: key);

  final ItemObject item;

  @override
  Widget build(BuildContext context) {
    const height = 100.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: CachedNetworkImage(
            imageUrl: 'https://cdn.warframestat.us/img/${item.imageName}',
            fit: BoxFit.cover,
            width: (1.5 * height) / 2,
            height: height,
          ),
        ),
        title: Text(item.name),
        subtitle: Text(parseHtmlString(item.description ?? '')),
        dense: true,
        isThreeLine: true,
        onTap: () =>
            Navigator.of(context).pushNamed(CodexEntry.route, arguments: item),
      ),
    );
  }
}
