import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/utils/size_config.dart';
import 'package:rxdart/rxdart.dart';

import 'indicator.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
    @required this.children,
    @required this.dotCount,
    this.enableIndicator = true,
  })  : assert(children != null),
        assert(dotCount != null),
        super(key: key);

  final List<Widget> children;
  final int dotCount;
  final bool enableIndicator;

  @override
  _CarouselState createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  num _page;
  StreamController<int> _currentPage;
  PageController _pageController;
  PageStorageBucket _bucket;

  @override
  void initState() {
    super.initState();
    _bucket = PageStorage.of(context);
    _page = _bucket.readState(context);

    _pageController = PageController(initialPage: _page?.toInt() ?? 0);

    _currentPage = BehaviorSubject<int>();

    _currentPage.sink.add(_page?.toInt() ?? 0);
  }

  @override
  void dispose() {
    _currentPage?.close();
    _pageController?.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    _currentPage.sink.add(index);
    _bucket.writeState(context, index);
  }

  @override
  Widget build(BuildContext context) {
    final hegiht = SizeConfig.heightMultiplier * 30;
    final width = SizeConfig.widthMultiplier * 20;

    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        LimitedBox(
          maxHeight: hegiht,
          maxWidth: width,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: onPageChanged,
            itemCount: widget.children.length,
            itemBuilder: (BuildContext context, int index) =>
                widget.children[index],
          ),
        ),
        if (widget.enableIndicator)
          Align(
            heightFactor: 9.4,
            alignment: Alignment.bottomCenter,
            child: FittedBox(
              child: StreamBuilder<int>(
                stream: _currentPage.stream,
                initialData: _page?.toInt() ?? 0,
                builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                  return Indicator(
                    numberOfDot: widget.dotCount,
                    position: snapshot.data,
                    dotSize: const Size.square(9.0),
                    dotActiveColor: Theme.of(context).accentColor,
                  );
                },
              ),
            ),
          )
      ],
    );
  }
}
