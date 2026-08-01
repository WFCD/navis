import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/items/widgets/open_item_container.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_common/warframe_common.dart';

class ItemTile extends StatelessWidget {
  const ItemTile({super.key, required this.item, this.child});

  final WarframeItem item;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final imageName = item.imageName;

    return OpenItemContainer(
      item: item,
      closedBuilder: (context, action) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: Hero(
              tag: item.uniqueName,
              child: CircleAvatar(
                foregroundImage: imageName != null
                    ? CachedNetworkImageProvider(
                        imageName.warframeItemsCdn().optimize(pixelRatio: MediaQuery.devicePixelRatioOf(context)),
                      )
                    : null,
                backgroundColor: Theme.of(context).canvasColor,
              ),
            ),
            title: Text(item.name.parseHtmlString()),
            subtitle: child ?? Text(item.description ?? '', maxLines: 3, overflow: TextOverflow.ellipsis),
            isThreeLine: child != null,
            onTap: action,
          ),
        );
      },
    );
  }
}
