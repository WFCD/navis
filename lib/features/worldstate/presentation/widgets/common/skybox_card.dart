import 'package:flutter/material.dart';
import 'package:navis/injection_container.dart';

import '../../../../../core/themes/themes.dart';
import '../../../data/datasources/skybox_parser.dart';
import 'background_image.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key key,
    @required this.node,
    this.alignment = Alignment.center,
    this.height,
    this.width,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    @required this.child,
  })  : assert(node != null),
        assert(child != null),
        super(key: key);

  final String node;
  final Alignment alignment;
  final double height, width;
  final EdgeInsetsGeometry margin, padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisTheming.dark,
      child: Card(
        margin: margin,
        child: BackgroundImage(
          imageUrl: sl<SkyboxService>().getSkybox(node),
          alignment: alignment,
          height: height,
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
