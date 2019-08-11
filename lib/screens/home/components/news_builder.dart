import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/components/widgets.dart';
import 'package:rxdart/rxdart.dart';

import 'news.dart';

class NewsBuilder extends StatefulWidget {
  const NewsBuilder({Key key}) : super(key: key);

  @override
  _NewsBuilderState createState() => _NewsBuilderState();
}

class _NewsBuilderState extends State<NewsBuilder> {
  double page;
  StreamController<int> _currentPage;
  PageController pageController;
  PageStorageBucket _bucket;

  @override
  void initState() {
    super.initState();
    _bucket = PageStorage.of(context);
    page = _bucket.readState(context);

    pageController = PageController(initialPage: page?.toInt() ?? 0);

    _currentPage = BehaviorSubject<int>();

    _currentPage.sink.add(page?.toInt() ?? 0);
  }

  @override
  void dispose() {
    _currentPage?.close();
    pageController?.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    _currentPage.sink.add(index);
    _bucket.writeState(context, index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        child: Material(
          color: Theme.of(context).cardColor,
          elevation: 6,
          child: BlocBuilder<WorldstateBloc, WorldStates>(
              builder: (BuildContext context, WorldStates state) {
            final news = state.worldstate?.news ?? [];

            return Carousel(
              height: 200,
              dotCount: news.length,
              children: news.map((n) => NewsStyle(news: n)).toList(),
            );
          }),
        ));
  }
}
