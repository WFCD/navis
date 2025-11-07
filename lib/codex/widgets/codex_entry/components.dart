import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/utils/string_extensions.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Alignment;

class ItemComponents extends StatelessWidget {
  const ItemComponents({super.key, required this.itemImageName, required this.components});

  final String? itemImageName;
  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    final blueprint = components.cast<Component?>().firstWhere(
      (c) => c?.name.contains('Blueprint') ?? false,
      orElse: () => null,
    );

    final parts = components.where((c) => !c.name.contains('Blueprint'));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryTitle(title: context.l10n.componentsTitle, contentPadding: EdgeInsets.zero),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (blueprint != null)
              _BuildBlueprint(
                blueprintImage: blueprint.imageName,
                componentImage: itemImageName,
                drops: blueprint.drops,
              ),
            for (final component in parts) _BuildComponent(component: component),
          ],
        ),
      ],
    );
  }
}

void _onTap(BuildContext context, List<Drop> drops) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    builder: (_) => DraggableScrollableSheet(
      initialChildSize: 0.4,
      minChildSize: 0.2,
      maxChildSize: 0.9,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return ComponentDrops(controller: scrollController, drops: drops);
      },
    ),
  );
}

class _BuildComponent extends StatelessWidget {
  const _BuildComponent({required this.component});

  final Component component;

  @override
  Widget build(BuildContext context) {
    const imageBoxSize = 60.0;
    final drops = component.drops;
    final hasDrops = drops != null && drops.isNotEmpty;

    return Tooltip(
      message: component.name,
      child: InkWell(
        onTap: hasDrops ? () => _onTap(context, component.drops!) : null,
        child: SizedBox.square(
          dimension: imageBoxSize,
          child: Stack(
            children: [
              if (component.itemCount > 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Text('x${component.itemCount}', style: Theme.of(context).textTheme.bodySmall),
                ),
              CachedNetworkImage(
                imageUrl: component.imageName.warframeItemsCdn().optimize(
                  pixelRatio: MediaQuery.devicePixelRatioOf(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildBlueprint extends StatelessWidget {
  const _BuildBlueprint({required this.blueprintImage, required this.componentImage, required this.drops});

  final String? blueprintImage;
  final String? componentImage;
  final List<Drop>? drops;

  @override
  Widget build(BuildContext context) {
    final pixelRatio = MediaQuery.devicePixelRatioOf(context);
    final hasDrops = drops != null && (drops?.isNotEmpty ?? false);

    return InkWell(
      onTap: hasDrops ? () => _onTap(context, drops!) : null,
      child: CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(blueprintImage.warframeItemsCdn().optimize(pixelRatio: pixelRatio)),
        foregroundImage: CachedNetworkImageProvider(componentImage.warframeItemsCdn().optimize(pixelRatio: pixelRatio)),
      ),
    );
  }
}
