import 'package:animated_glitch/animated_glitch.dart';
import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
          child: Material(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: .5),
            child: SizedBox(
              height: height,
              child: Padding(padding: padding, child: child),
            ),
          ),
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
    this.height = 150,
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
      frequency: const Duration(milliseconds: 1500),
      distortionShift: const DistortionShift(count: 3),
    )..stop();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('SkyboxCard-glitched'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (!mounted) return;

        setState(() {
          if (info.visibleFraction == 1) {
            _controller.start();
          } else {
            _controller.stop();
          }
        });
      },
      child: AnimatedGlitchWithoutShader(
        controller: _controller,
        child: SkyboxCard(
          node: widget.node,
          margin: widget.margin,
          padding: widget.padding,
          height: widget.height,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
