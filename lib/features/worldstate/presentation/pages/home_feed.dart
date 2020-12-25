import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/sliver_top_bar.dart';
import '../bloc/solsystem_bloc.dart';
import 'fissures.dart';
import 'invasions.dart';
import 'syndicates.dart';
import 'timers.dart';

enum Tabs { Timers, Fissures, Invasions, Syndicates }

class HomeFeedPage extends StatelessWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  static const _tabs = <Tabs, Widget>{
    Tabs.Timers: Timers(),
    Tabs.Fissures: FissuresPage(),
    Tabs.Invasions: InvasionsPage(),
    Tabs.Syndicates: SyndicatePage()
  };

  String _getTabLocale(BuildContext context, Tabs name) {
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
                    tabs: _tabs.keys
                        .map((t) => Tab(text: _getTabLocale(context, t)))
                        .toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: _tabs.values.map((e) => SafeArea(child: e)).toList(),
          ),
        ),
      ),
    );
  }
}
