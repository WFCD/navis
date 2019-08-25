import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/components/layout.dart';
import 'package:rxdart/rxdart.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key key,
    @required this.children,
    @required this.dotCount,
    this.height = 150,
    this.enableIndicator = true,
  })  : assert(children != null),
        assert(dotCount != null),
        super(key: key);

  final List<Widget> children;
  final double height;
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
    return Container(
      height: widget.height + 15,
      child: Stack(
        children: <Widget>[
          Container(
            height: widget.height,
            child: PageView(
              controller: _pageController,
              children: widget.children,
              onPageChanged: onPageChanged,
            ),
          ),
          if (widget.enableIndicator)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // color: const Color.fromRGBO(34, 34, 34, .4),
                height: 20,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
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
      ),
    );
  }
}
