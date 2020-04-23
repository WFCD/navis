import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/generated/l10n.dart';

import 'fissures.dart';
import 'invasions.dart';
import 'syndicates.dart';
import 'timers.dart';

enum Tabs { Timers, Fissures, Invasions, Syndicates }

class HomeFeedPage extends StatefulWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  @override
  _HomeFeedPageState createState() => _HomeFeedPageState();
}

class _HomeFeedPageState extends State<HomeFeedPage>
    with SingleTickerProviderStateMixin {
  static const _pages = [
    Timers(),
    FissuresPage(),
    InvasionsPage(),
    SyndicatePage()
  ];

  List<Tab> tabs;
  TabController _tabController;

  @override
  void initState() {
    super.initState();

    // tabs = Tabs.values.map((t) => Tab(text: _getTabLocale(t))).toList();
    _tabController = TabController(length: Tabs.values.length, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    tabs = Tabs.values.map((t) => Tab(text: _getTabLocale(t))).toList();
  }

  String _getTabLocale(Tabs name) {
    final localizations = NavisLocalizations.of(context);

    switch (name) {
      case Tabs.Fissures:
        return localizations.fissuresTitle;
      case Tabs.Invasions:
        return localizations.invasionsTitle;
      case Tabs.Syndicates:
        return localizations.syndicatesTitle;
      default:
        return localizations.timersTitle;
    }
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
                child: TabBar(
                  controller: _tabController,
                  labelColor: Theme.of(context).accentColor,
                  unselectedLabelColor: Theme.of(context)
                      .primaryTextTheme
                      .body2
                      .color
                      .withOpacity(.7),
                  tabs: tabs,
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
    _tabController?.dispose();
    super.dispose();
  }
}
