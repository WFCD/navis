import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/utils/item_extensions.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class CodexResult extends StatefulWidget {
  const CodexResult({
    super.key,
    required this.item,
    required this.onTap,
    this.showDescription = false,
  });

  final Item item;
  final bool showDescription;
  final void Function() onTap;

  @override
  State<CodexResult> createState() => _CodexResultState();
}

class _CodexResultState extends State<CodexResult> {
  late String _image;

  @override
  void initState() {
    super.initState();
    _image = widget.item.imageUrl;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(
      CachedNetworkImageProvider(_image),
      context,
      onError: (e, s) {
        _image = defaultImage;
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? description;

    if (widget.item is Mod) {
      final levelStats = (widget.item as Mod).levelStats;

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
        tag: widget.item.uniqueName,
        child: CircleAvatar(
          foregroundImage: widget.item.imageName != null
              ? CachedNetworkImageProvider(_image)
              : null,
          backgroundColor: Theme.of(context).canvasColor,
        ),
      ),
      title: Text(widget.item.name.parseHtmlString()),
      subtitle: widget.showDescription
          ? Text(
              description?.trim() ??
                  widget.item.description?.parseHtmlString() ??
                  '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            )
          : null,
      isThreeLine: widget.showDescription,
      dense: widget.showDescription,
      onTap: widget.onTap,
    );
  }
}
