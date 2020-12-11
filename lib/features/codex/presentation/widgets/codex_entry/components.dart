import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:navis/features/codex/presentation/pages/component_drops.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/widgets/widgets.dart';

class ItemComponents extends StatelessWidget {
  const ItemComponents({
    Key key,
    @required this.itemImageUrl,
    @required this.components,
  }) : super(key: key);

  final String itemImageUrl;
  final List<Component> components;

  Widget _buildComponent(BuildContext context, Component component,
      {Widget child}) {
    return Tooltip(
      message: component.name,
      child: InkWell(
        onTap: () {
          if (component.drops != null && component.drops.isNotEmpty) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => ComponentDrops(
                  drops: component.drops,
                ),
              ),
            );
          }
        },
        child: Container(
          constraints: const BoxConstraints.expand(width: 70, height: 70),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (component.itemCount > 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'x${component.itemCount}',
                    style: Theme.of(context)?.textTheme?.caption,
                  ),
                ),
              CachedNetworkImage(imageUrl: component.imageUrl),
              if (child != null) child
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final blueprint = components.firstWhere((c) => c.name == 'Blueprint');
    final parts = List<Component>.from(components)
      ..removeWhere((c) => c.name == 'Blueprint');

    return CustomCard(
      child: Column(
        children: [
          CategoryTitle(title: context.locale.componentsTitle),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildComponent(context, blueprint,
                  child: CachedNetworkImage(imageUrl: itemImageUrl)),
              for (final component in parts) _buildComponent(context, component)
            ],
          ),
        ],
      ),
    );
  }
}
