import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/cubits/solsystem_cubit.dart';
import 'package:navis/worldstate/views/fissures.dart';
import 'package:navis/worldstate/views/invasions.dart';
import 'package:navis/worldstate/views/syndicates.dart';
import 'package:navis/worldstate/views/timers.dart';
import 'package:navis_ui/navis_ui.dart';

enum Tabs { timers, fissures, invasions, syndicates }

class FeedView extends StatelessWidget {
  const FeedView({Key? key}) : super(key: key);

  String _getTabLocale(BuildContext context, Tabs name) {
    final l10n = context.l10n;

    switch (name) {
      case Tabs.fissures:
        return l10n.fissuresTitle;
      case Tabs.invasions:
        return l10n.invasionsTitle;
      case Tabs.syndicates:
        return l10n.syndicatesTitle;
      case Tabs.timers:
        return l10n.timersTitle;
    }
  }

  void listener(BuildContext context, SolsystemState state) {
    if (state is SystemError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(state.message)));
    } else if (state is SolState) {
      final now = DateTime.now();
      final timestamp = state.worldstate.timestamp;

      if (timestamp.difference(now) >= const Duration(minutes: 30)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Worldstate is out of date by more then 30 mins'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SolsystemCubit, SolsystemState>(
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
                    indicatorColor: context.theme.brightness.isDark
                        ? null
                        : context.theme.colorScheme.secondary,
                    tabs: Tabs.values
                        .map((t) => Tab(text: _getTabLocale(context, t)))
                        .toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: Tabs.values.map((e) => _TabView(tab: e)).toList(),
          ),
        ),
      ),
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({Key? key, required this.tab}) : super(key: key);

  final Tabs tab;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
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
                  onRefresh:
                      BlocProvider.of<SolsystemCubit>(context).fetchWorldstate,
                  child: () {
                    switch (tab) {
                      case Tabs.timers:
                        return const Timers();
                      case Tabs.fissures:
                        return const FissuresPage();
                      case Tabs.invasions:
                        return const InvasionsPage();
                      case Tabs.syndicates:
                        return const SyndicatePage();
                    }
                  }(),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
