import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:warframestat_api_models/entities.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({Key key, this.item}) : super(key: key);

  final BaseItem item;

  @override
  Widget build(BuildContext context) {
    const height = 120.0;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: item.imageUrl,
          fit: BoxFit.cover,
          width: (.8 * height) / 2,
          height: height,
        ),
        title: Text(item.name),
        subtitle: Text(parseHtmlString(item.description ?? '')),
        dense: true,
        contentPadding: const EdgeInsets.all(4.0),
        // onTap: () => Navigator.of(context).pushNamed('', arguments: item),
      ),
    );
  }
}
