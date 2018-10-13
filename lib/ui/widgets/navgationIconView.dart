import 'package:flutter/material.dart';

// borrowed from flutter gallery
class NavigationIconView {
  NavigationIconView({
    IconData icon,
    Widget activeIcon,
    String title,
    Color color,
    Widget child,
    TickerProvider vsync,
  })  : _child = child,
        item = BottomNavigationBarItem(
          icon: Icon(icon, size: 25.0),
          activeIcon: activeIcon,
          title: Text(title, style: TextStyle(fontSize: 12.0)),
          backgroundColor: color,
        ),
        controller = AnimationController(
          duration: kThemeAnimationDuration,
          vsync: vsync,
        ) {
    _animation = CurvedAnimation(
        parent: controller,
        curve: Interval(0.5, 1.0, curve: Curves.fastOutSlowIn));
  }

  final Widget _child;
  final BottomNavigationBarItem item;
  final AnimationController controller;
  Animation<double> _animation;

  FadeTransition transition() {
    return FadeTransition(opacity: _animation, child: _child);
  }
}
