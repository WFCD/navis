import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/sliver_top_bar.dart';
import '../../../../l10n/l10n.dart';
import '../bloc/solsystem_bloc.dart';
import 'fissures.dart';
import 'invasions.dart';
import 'syndicates.dart';
import 'timers.dart';

enum Tabs { timers, fissures, invasions, syndicates }

class HomeFeedPage extends StatelessWidget {
  const HomeFeedPage({Key key}) : super(key: key);

  String _getTabLocale(BuildContext context, Tabs name) {
    final l10n = context.l10n;

    switch (name) {
      case Tabs.fissures:
        return l10n.fissuresTitle;
      case Tabs.invasions:
        return l10n.invasionsTitle;
      case Tabs.syndicates:
        return l10n.syndicatesTitle;
      default:
        return l10n.timersTitle;
    }
  }

  Widget _buildView(Tabs tab, SolState state) {
    switch (tab) {
      case Tabs.timers:
        return Timers(state: state);
      case Tabs.fissures:
        return FissuresPage(state: state);
      case Tabs.invasions:
        return InvasionsPage(state: state);
      default:
        return SyndicatePage(state: state);
    }
  }

  Widget _tabBuilder(Tabs tab) {
    return SafeArea(
      top: false,
      bottom: false,
      child: BlocBuilder<SolsystemBloc, SolsystemState>(
        builder: (BuildContext context, SolsystemState state) {
          if (state is SolState) {
            return CustomScrollView(
              key: PageStorageKey<String>(tab.toString()),
              slivers: [
                SliverOverlapInjector(
                  // This is the flip side of the SliverOverlapAbsorber above.
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),
                SliverFillRemaining(
                  child: RefreshIndicator(
                    onRefresh: BlocProvider.of<SolsystemBloc>(context).update,
                    child: _buildView(tab, state),
                  ),
                )
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
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
                    tabs: Tabs.values
                        .map((t) => Tab(text: _getTabLocale(context, t)))
                        .toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(children: Tabs.values.map(_tabBuilder).toList()),
        ),
      ),
    );
  }
}
