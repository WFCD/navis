import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/utils/helper_methods.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:warframestat_api_models/entities.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({Key key, this.item}) : super(key: key);

  final BaseItem item;

  @override
  Widget build(BuildContext context) {
    const height = 120.0;

    return CustomCard(
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(2.0),
          child: CachedNetworkImage(
            imageUrl: 'https://cdn.warframestat.us/img/${item.imageName}',
            fit: BoxFit.cover,
            width: (1 * height) / 2,
            height: height,
          ),
        ),
        title: Text(item.name),
        subtitle: Text(parseHtmlString(item.description ?? '')),
        dense: true,
        isThreeLine: true,
        // onTap: () => Navigator.of(context).pushNamed('', arguments: item),
      ),
    );
  }
}
