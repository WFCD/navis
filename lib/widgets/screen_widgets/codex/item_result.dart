import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/widgets/screen_widgets/items_info/item_image.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class ItemResultWidget extends StatelessWidget {
  const ItemResultWidget({Key key, this.item}) : super(key: key);

  final ItemObject item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: ListTile(
        leading: ItemImage(imageName: item.imageName),
        title: Text(item.name),
        subtitle: Text(parseHtmlString(item.description ?? '')),
        dense: true,
        isThreeLine: true,
        onTap: () => Navigator.of(context).pushNamed('/item', arguments: item),
      ),
    );
  }
}
