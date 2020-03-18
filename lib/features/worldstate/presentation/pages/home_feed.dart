import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'fissures.dart';
import 'invasions.dart';
import 'timers.dart';

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage>
    with SingleTickerProviderStateMixin {
  static const _pages = [Timers(), FissuresPage(), InvasionsPage(), SizedBox()];
  static const _tabs = [
    Tab(text: 'Timers'),
    Tab(text: 'Fissure'),
    Tab(text: 'Invasions'),
    Tab(text: 'Syndicates')
  ];

  StreamController<int> _streamController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<int>.broadcast();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        _streamController.add(_tabController.index);
      });
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: SliverToBoxAdapter(
              child: Material(
                color: Theme.of(context).canvasColor,
                child: StreamBuilder<int>(
                  initialData: 0,
                  stream: _streamController.stream.distinct(),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    return TabBar(
                      controller: _tabController,
                      labelColor: Theme.of(context).accentColor,
                      unselectedLabelColor: Theme.of(context)
                          .primaryTextTheme
                          .body2
                          .color
                          .withOpacity(.7),
                      tabs: _tabs,
                    );
                  },
                ),
              ),
            ),
          )
        ];
      },
      body: TabBarView(controller: _tabController, children: _pages),
    );
  }

  @override
  void dispose() {
    _streamController?.close();
    _tabController?.dispose();
    super.dispose();
  }
}
