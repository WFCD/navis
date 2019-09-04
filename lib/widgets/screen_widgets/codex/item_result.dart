import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/utils/utils.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class ItemResultWidget extends StatelessWidget {
  const ItemResultWidget({Key key, this.item}) : super(key: key);

  final ItemObject item;

  @override
  Widget build(BuildContext context) {
    final ShapeBorder buttonShap = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4.0),
    );

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Material(
              borderRadius: BorderRadius.circular(4.0),
              elevation: 2.0,
              child: CachedNetworkImage(
                imageUrl: 'https://cdn.warframestat.us/img/${item.imageName}',
                fit: BoxFit.cover,
                width: (.7 * 180) / 2,
                height: 180,
              ),
            ),
            title: Text(item.name),
            subtitle: Text(parseHtmlString(item.description ?? '')),
            dense: true,
            isThreeLine: true,
            onTap: () =>
                Navigator.of(context).pushNamed('/item', arguments: item),
          ),
          ButtonBar(children: <Widget>[
            // if (item is Warframe && (item as Warframe).components != null)
            //   FlatButton(
            //     child: const Text('See Components'),
            //     shape: buttonShap,
            //     onPressed: () => debugPrint(item.category),
            //   ),
            if (item.wikiaUrl != null)
              FlatButton(
                child: const Text('Go to Wikia'),
                shape: buttonShap,
                onPressed: () => launchLink(context, item.wikiaUrl),
              )
          ])
        ],
      ),
    );
  }
}
