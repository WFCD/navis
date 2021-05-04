import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../core/widgets/widgets.dart';
import '../../../../../l10n/l10n.dart';
import '../../pages/component_drops.dart';

class ItemComponents extends StatelessWidget {
  const ItemComponents({
    Key? key,
    required this.itemImageUrl,
    required this.components,
  }) : super(key: key);

  final String itemImageUrl;
  final List<Component> components;

  Widget _buildComponent(
    BuildContext context,
    Component component,
    Widget? child,
  ) {
    return Tooltip(
      message: component.name,
      child: InkWell(
        onTap: () {
          if (component.drops != null &&
              (component.drops?.isNotEmpty ?? false)) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => ComponentDrops(
                  drops: component.drops!,
                ),
              ),
            );
          }
        },
        child: Container(
          constraints: const BoxConstraints.expand(width: 60, height: 60),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              if (component.itemCount > 1)
                Align(
                  alignment: Alignment.topRight,
                  child: Text(
                    'x${component.itemCount}',
                    style: Theme.of(context).textTheme.caption,
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
    final blueprint = components.cast<Component?>().firstWhere(
        (c) => c?.name.contains('Blueprint') ?? false,
        orElse: () => null);

    final parts = components.where((c) => !c.name.contains('Blueprint'));

    return CustomCard(
      child: Column(
        children: [
          CategoryTitle(title: context.l10n.componentsTitle),
          const SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              if (blueprint != null)
                _buildComponent(
                  context,
                  blueprint,
                  CachedNetworkImage(imageUrl: itemImageUrl),
                ),
              for (final component in parts)
                _buildComponent(context, component, null)
            ],
          ),
        ],
      ),
    );
  }
}
