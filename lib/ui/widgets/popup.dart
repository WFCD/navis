import 'package:flutter/material.dart';

class Popup extends PopupRoute {
  final Widget child;
  final BuildContext context;

  Popup({@required this.child, @required this.context});

  @override
  Color get barrierColor => Color.fromRGBO(34, 34, 34, .9);

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
