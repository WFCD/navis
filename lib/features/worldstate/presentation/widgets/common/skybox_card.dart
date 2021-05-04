import 'package:flutter/material.dart';

import '../../../../../core/themes/themes.dart';
import '../../../utils/skybox_loader.dart';
import 'background_image.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key? key,
    required this.node,
    this.height,
    this.width,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    required this.child,
  }) : super(key: key);

  final String node;

  final double? height, width;
  final EdgeInsetsGeometry margin, padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisTheming.dark,
      child: Card(
        margin: margin,
        child: BackgroundImage(
          imageUrl: getSkybox(node),
          height: height,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
