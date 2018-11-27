import 'package:flutter/material.dart';

class Popup extends PopupRoute {
  final Widget child;

  Popup({@required this.child});

  @override
  Color get barrierColor => Color.fromRGBO(34, 34, 34, .9);

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => 'close';

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) =>
      child;

  @override
  Duration get transitionDuration => Duration(milliseconds: 200);
}
