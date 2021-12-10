import 'package:flutter/material.dart';

class ViewLoading extends StatelessWidget {
  const ViewLoading({Key? key, required this.isLoading, required this.child})
      : super(key: key);

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: const Center(child: CircularProgressIndicator.adaptive()),
      secondChild: child,
      crossFadeState:
          isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: kThemeAnimationDuration,
    );
  }
}
