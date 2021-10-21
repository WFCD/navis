import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/utils/helper_methods.dart';
import '../../../../../core/widgets/widgets.dart';

class CodexResult extends StatelessWidget {
  const CodexResult({Key? key, required this.item}) : super(key: key);

  final Item item;

  @override
  Widget build(BuildContext context) {
    String? description;

    if (item is Mod) {
      if ((item as Mod).levelStats != null) {
        description = (item as Mod).levelStats?.last['stats']!.fold('', (p, e) {
          if (p == null) {
            return '$e ';
          } else {
            return '$p $e ';
          }
        });
      }

      if (description != null) {
        description = description.parseHtmlString();
      }
    }

    return CustomCard(
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
        title: Text(item.name),
        subtitle: Text(
          description?.trim() ?? item.description?.parseHtmlString() ?? '',
        ),
        isThreeLine: true,
        dense: true,
      ),
    );
  }
}
