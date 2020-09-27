import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/widgets/sliver_top_bar.dart';
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
    return DefaultTabController(
      length: Tabs.values.length,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverTopbar(
                pinned: true,
                child: TabBar(
                  labelColor:
                      Theme.of(context).primaryTextTheme.bodyText1.color,
                  unselectedLabelColor: Theme.of(context)
                      .primaryTextTheme
                      .bodyText1
                      .color
                      .withOpacity(.7),
                  indicatorColor: Theme.of(context).accentColor,
                  tabs: tabs,
                ),
              ),
            )
          ];
        },
        body: const Padding(
            padding: EdgeInsets.only(top: kTextTabBarHeight),
            child: TabBarView(children: _pages)),
      ),
    );
  }
}
