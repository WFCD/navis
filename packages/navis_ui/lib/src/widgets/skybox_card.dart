import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    Key? key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.height = 100,
    this.enableGlitch = false,
    required this.child,
  }) : super(key: key);

  final String node;
  final EdgeInsetsGeometry margin, padding;
  final double height;
  final bool enableGlitch;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Widget child = BackgroundImage(
      imageUrl: getSkybox(node),
      padding: padding,
      child: this.child,
    );

    if (enableGlitch) {
      child = AnimatedGlitch.shader(
        glitchAmount: 1,
        distortionLevel: 2,
        showColorChannels: false,
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: child,
        ),
      );
    }

    return Theme(
      data: NavisThemes.dark,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: margin,
        child: child,
      ),
    );
  }
}
