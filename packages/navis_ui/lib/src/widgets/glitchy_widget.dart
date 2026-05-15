import 'package:animated_glitch/animated_glitch.dart';
import 'package:flutter/widgets.dart';

class GlitchyWidget extends StatefulWidget {
  const GlitchyWidget({super.key, required this.child});

  final Widget child;

  static const glitchFrequency = Duration(milliseconds: 1500);

  @override
  State<GlitchyWidget> createState() => _GlitchyWidgetState();
}

class _GlitchyWidgetState extends State<GlitchyWidget> {
  late AnimatedGlitchController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimatedGlitchController(
      frequency: GlitchyWidget.glitchFrequency,
      distortionShift: const DistortionShift(count: 5),
      // autoStart: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedGlitchWithoutShader(
      controller: _controller,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
