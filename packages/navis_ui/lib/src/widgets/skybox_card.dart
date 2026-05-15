import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    super.key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.height = 150,
    required this.child,
  });

  final String node;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: Theme(
        data: context.theme.copyWith(
          textTheme: Typography.whiteMountainView,
          iconTheme: context.theme.iconTheme.copyWith(color: Colors.white),
        ),
        child: BackgroundImage(
          imageUrl: getSkybox(node),
          alignment: Alignment.center,
          height: height,
          child: SizedBox(
            height: height,
            child: Padding(
              padding: padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}
