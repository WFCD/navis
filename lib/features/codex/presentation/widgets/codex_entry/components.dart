import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../../constants/sizedbox_spacer.dart';
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

  @override
  Widget build(BuildContext context) {
    final blueprint = components.cast<Component?>().firstWhere(
        (c) => c?.name.contains('Blueprint') ?? false,
        orElse: () => null);

    final parts = components.where((c) => !c.name.contains('Blueprint'));

    return Column(
      children: [
        CategoryTitle(
          title: context.l10n.componentsTitle,
          contentPadding: EdgeInsets.zero,
        ),
        SizedBoxSpacer.spacerHeight8,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (blueprint != null)
              _BuildComponent(
                component: blueprint,
                child: CachedNetworkImage(imageUrl: itemImageUrl),
              ),
            for (final component in parts) _BuildComponent(component: component)
          ],
        ),
      ],
    );
  }
}

class _BuildComponent extends StatelessWidget {
  const _BuildComponent({Key? key, required this.component, this.child})
      : super(key: key);

  final Component component;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
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
        child: SizedBox(
          width: 60,
          height: 60,
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
              if (child != null) child!
            ],
          ),
        ),
      ),
    );
  }
}
