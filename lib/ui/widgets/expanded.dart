import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class ExpandedCard extends StatefulWidget {
  final double length;
  final Widget child;
  final AnimationController controller;

  ExpandedCard({Key key, this.controller, this.length, this.child})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => ExpandedCardState();
}

class ExpandedCardState extends State<ExpandedCard> {
  SequenceAnimation _expand;

  @override
  void initState() {
    super.initState();
    _updateLength();
  }

  @override
  void didUpdateWidget(ExpandedCard oldWidget) {
    if (oldWidget.length != widget.length) {
      _expand = null;
      _updateLength();
    }

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _expand = null;
    super.dispose();
  }

  _updateLength() {
    _expand = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: widget.length),
            from: Duration(milliseconds: 0),
            to: Duration(milliseconds: 125),
            curve: Curves.easeOut,
            tag: 'expand')
        .addAnimatable(
            animatable: Tween<double>(begin: 0, end: 1),
            from: Duration(milliseconds: 125),
            to: Duration(milliseconds: 225),
            curve: Curves.easeOut,
            tag: 'fade')
        .animate(widget.controller);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: widget.controller,
        builder: (BuildContext context, Widget child) {
          return Container(
              height: _expand['expand'].value,
              child: FadeTransition(
                  opacity: _expand['fade'], child: widget.child));
        });
  }
}
