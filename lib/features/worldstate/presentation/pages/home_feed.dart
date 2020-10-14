import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/core/widgets/sliver_top_bar.dart';
import 'package:navis/core/utils/extensions.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';

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
    switch (name) {
      case Tabs.Fissures:
        return context.locale.fissuresTitle;
      case Tabs.Invasions:
        return context.locale.invasionsTitle;
      case Tabs.Syndicates:
        return context.locale.syndicatesTitle;
      default:
        return context.locale.timersTitle;
    }
  }

  void listener(BuildContext context, SolsystemState state) {
    const displayDuration = Duration(seconds: 50);

    if (state is SystemError) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text(state.message),
        duration: displayDuration,
      ));
    } else if (state is SolState) {
      final now = DateTime.now();
      final timestamp = state.worldstate.timestamp;

      if (timestamp.difference(now) >= const Duration(minutes: 30)) {
        Scaffold.of(context).showSnackBar(const SnackBar(
          content: Text('Worldstate is out of date by more then 30 mins'),
          duration: displayDuration,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SolsystemBloc, SolsystemState>(
      listener: listener,
      child: DefaultTabController(
        length: Tabs.values.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
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
            child: TabBarView(children: _pages),
          ),
        ),
      ),
    );
  }
}
