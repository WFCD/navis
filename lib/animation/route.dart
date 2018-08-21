import 'package:flutter/material.dart';
import 'package:flutter_villains/villain.dart';

class VillainRoute extends PageRoute {
  final Widget child;

  VillainRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return Villain(
        villainAnimation:
            VillainAnimation.fromBottom(curve: Curves.fastOutSlowIn),
        secondaryVillainAnimation: VillainAnimation.fade(),
        child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 200);
}

class VillainPopup extends PopupRoute {
  final Widget child;

  VillainPopup({@required this.child});

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
