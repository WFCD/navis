import 'package:flutter/material.dart';

class NavigationIcon extends StatelessWidget {
  const NavigationIcon({super.key, required this.activeIcon, required this.inactiveIcon, this.isActive = false});

  final Widget activeIcon;
  final Widget inactiveIcon;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: activeIcon,
      secondChild: inactiveIcon,
      crossFadeState: isActive ? CrossFadeState.showFirst : CrossFadeState.showSecond,
      duration: Durations.medium1,
      firstCurve: Curves.easeOut,
      secondCurve: Curves.easeIn,
    );
  }
}
