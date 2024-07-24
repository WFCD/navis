import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class SkyboxCard extends StatelessWidget {
  const SkyboxCard({
    super.key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.height = 100,
    required this.child,
  });

  final String node;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: NavisThemes.dark,
      child: Card(
        clipBehavior: Clip.antiAlias,
        margin: margin,
        child: BackgroundImage(
          imageUrl: getSkybox(node),
          padding: padding,
          height: height,
          child: child,
        ),
      ),
    );
  }
}

class GlitchySkyCard extends StatefulWidget {
  const GlitchySkyCard({
    super.key,
    required this.node,
    this.margin = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.padding = const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
    this.height = 100,
    required this.child,
  });

  final String node;
  final EdgeInsetsGeometry margin;
  final EdgeInsetsGeometry padding;
  final double height;
  final Widget child;

  @override
  State<GlitchySkyCard> createState() => _GlitchySkyCardState();
}

class _GlitchySkyCardState extends State<GlitchySkyCard> {
  late AnimatedGlitchController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimatedGlitchController(
      frequency: const Duration(milliseconds: 900),
      distortionShift: const DistortionShift(count: 3),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGlitchWithoutShader(
      controller: _controller,
      child: SkyboxCard(
        node: widget.node,
        margin: widget.margin,
        padding: widget.padding,
        height: widget.height,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
