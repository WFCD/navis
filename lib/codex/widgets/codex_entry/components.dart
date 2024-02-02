import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframestat_client/warframestat_client.dart';

class ItemComponents extends StatelessWidget {
  const ItemComponents({
    super.key,
    required this.itemImageUrl,
    required this.components,
  });

  final String itemImageUrl;
  final List<Component> components;

  @override
  Widget build(BuildContext context) {
    final blueprint = components.cast<Component?>().firstWhere(
          (c) => c?.name.contains('Blueprint') ?? false,
          orElse: () => null,
        );

    final parts = components.where((c) => !c.name.contains('Blueprint'));

    return AppCard(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          const CategoryTitle(title: 'Components'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (blueprint != null)
                _BuildBlueprint(
                  blueprintImage: blueprint.imageUrl,
                  componentImage: itemImageUrl,
                  drops: blueprint.drops,
                ),
              for (final component in parts)
                _BuildComponent(component: component),
            ],
          ),
        ],
      ),
    );
  }
}

class _BuildComponent extends StatelessWidget {
  const _BuildComponent({required this.component});

  final Component component;

  void _onTap(BuildContext context) {
    final drops = component.drops;

    if (drops != null && drops.isNotEmpty) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => ComponentDrops(drops: drops),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const imageBoxSize = 60.0;

    return Tooltip(
      message: component.name,
      child: InkWell(
        onTap: () => _onTap(context),
        child: SizedBox.square(
          dimension: imageBoxSize,
          child: Stack(
            children: [
              if (component.itemCount > 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'x${component.itemCount}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              CachedNetworkImage(imageUrl: component.imageUrl),
            ],
          ),
        ),
      ),
    );
  }
}

class _BuildBlueprint extends StatelessWidget {
  const _BuildBlueprint({
    required this.blueprintImage,
    required this.componentImage,
    required this.drops,
  });

  final String blueprintImage;
  final String componentImage;
  final List<Drop>? drops;

  void _onTap(BuildContext context) {
    if (drops != null && (drops?.isNotEmpty ?? false)) {
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (context) => ComponentDrops(drops: drops!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onTap(context),
      child: CircleAvatar(
        radius: 25,
        foregroundImage: CachedNetworkImageProvider(componentImage),
      ),
    );
  }
}
