import 'package:flutter/material.dart';
import 'package:navis_ui/src/helpers/skybox_helper.dart';
import 'package:navis_ui/src/theme.dart';
import 'package:navis_ui/src/widgets/widgets.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key? key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    required this.child,
  }) : super(key: key);

  final String node;

  final EdgeInsetsGeometry margin, padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisTheme.dark,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: BackgroundImage(
          imageUrl: getSkybox(node),
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
