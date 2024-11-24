import 'package:flutter/material.dart';
import 'package:navis_ui/navis_ui.dart';

class ViewLoading extends StatelessWidget {
  const ViewLoading({super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final fadeState =
        isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond;

    return AnimatedCrossFade(
      firstCurve: Curves.easeInOut,
      secondCurve: Curves.easeInOut,
      sizeCurve: Curves.easeInOut,
      duration: Durations.medium1,
      crossFadeState: fadeState,
      firstChild: const Center(child: WarframeSpinner()),
      secondChild: child,
    );
  }
}
