import 'package:flutter/material.dart';

class Indicator extends StatefulWidget {
  const Indicator({
    Key key,
    @required this.numberOfDot,
    this.position = 0,
    this.dotColor = Colors.grey,
    this.dotActiveColor = Colors.lightBlue,
    this.dotSize = defaultSize,
    this.dotActiveSize = defaultSize,
    this.dotShape = defaultShape,
    this.dotActiveShape = defaultShape,
    this.dotSpacing = defaultSpacing,
  })  : assert(numberOfDot != null),
        assert(position != null),
        assert(dotColor != null),
        assert(dotActiveColor != null),
        assert(dotSize != null),
        assert(dotActiveSize != null),
        assert(dotShape != null),
        assert(dotActiveShape != null),
        assert(dotSpacing != null),
        assert(
            position < numberOfDot,
            'The position must be inferior of numberOfDot (position start at 0).'
            ' Example for active last dot: numberOfDot=3 / position=2'),
        super(key: key);

  static const Size defaultSize = Size.square(9.0);
  static const EdgeInsets defaultSpacing = EdgeInsets.all(6.0);
  static const ShapeBorder defaultShape = CircleBorder();

  final int numberOfDot;
  final int position;
  final Color dotColor;
  final Color dotActiveColor;
  final Size dotSize;
  final Size dotActiveSize;
  final ShapeBorder dotShape;
  final ShapeBorder dotActiveShape;
  final EdgeInsets dotSpacing;

  @override
  _IndicatorState createState() => _IndicatorState();
}

class _IndicatorState extends State<Indicator> with TickerProviderStateMixin {
  final List<IndicatorInfo> _indicators = [];

  void _buildControllers() {
    for (int i = 0; i < widget.numberOfDot; i++) {
      final controller = AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      );

      final shape =
          ShapeBorderTween(begin: widget.dotShape, end: widget.dotActiveShape)
              .animate(controller);

      final color =
          ColorTween(begin: widget.dotColor, end: widget.dotActiveColor)
              .animate(controller);

      _indicators.add(
        IndicatorInfo(
          controller: controller,
          shape: shape,
          color: color,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _buildControllers();
    _indicators[widget.position].controller.forward();
  }

  @override
  void didUpdateWidget(Indicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.numberOfDot != widget.numberOfDot) {
      for (final i in _indicators) {
        i?.controller?.dispose();
      }

      _indicators.clear();
      _buildControllers();
    }

    if (oldWidget.position != widget.position) {
      _indicators[oldWidget.position].controller.reverse();
      _indicators[widget.position].controller.forward();
    }
  }

  Size _getDotSize(int index) {
    return index == widget.position ? widget.dotActiveSize : widget.dotSize;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          for (final info in _indicators)
            AnimatedBuilder(
              animation: info.controller,
              builder: (BuildContext context, Widget child) {
                final index = _indicators.indexOf(info);

                return Container(
                  width: _getDotSize(index).width,
                  height: _getDotSize(index).height,
                  margin: widget.dotSpacing,
                  decoration: ShapeDecoration(
                    color: info.color.value,
                    shape: info.shape.value,
                  ),
                );
              },
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (final i in _indicators) {
      i.controller?.dispose();
    }

    super.dispose();
  }
}

class IndicatorInfo {
  IndicatorInfo({this.controller, this.shape, this.color});

  final AnimationController controller;
  final Animation<ShapeBorder> shape;
  final Animation<Color> color;
}
