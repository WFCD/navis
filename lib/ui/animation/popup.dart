import 'package:flutter/material.dart';

class Popup extends PopupRoute {
  final Widget child;

  Popup({@required this.child});

  @override
  Color get barrierColor => Colors.black;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: Center(child: child));
  }

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
}
