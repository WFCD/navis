import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:navis/worldstate/views/fissures.dart';
import 'package:navis/worldstate/views/invasions.dart';
import 'package:navis/worldstate/views/syndicates.dart';
import 'package:navis/worldstate/views/timers.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:warframe_repository/warframe_repository.dart';

enum Tabs { timers, fissures, invasions, syndicates }

class ActivitiesPage extends StatelessWidget {
  const ActivitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final wsRepo = RepositoryProvider.of<WarframeRepository>(context);

    return BlocProvider(create: (_) => WorldstateBloc(wsRepo), child: const _ActivitiesView());
  }
}

class _ActivitiesView extends StatelessWidget {
  const _ActivitiesView();

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

  void _listener(BuildContext context, WorldState state) {
    if (state is WorldstateFailure) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(context.l10n.worldstateFailureText)));
    } else if (state is WorldstateSuccess) {
      final now = DateTime.now();
      final timestamp = state.seed.timestamp;

      if (timestamp.difference(now) >= const Duration(minutes: 30)) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(context.l10n.worldstateOutdatedText)));
      }
    }
  }

  List<Widget> _headerSliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        sliver: SliverTopbar(
          pinned: true,
          child: TabBar(tabs: Tabs.values.map((t) => Tab(text: _getTabLocale(context, t))).toList()),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WorldstateBloc, WorldState>(
      listener: _listener,
      child: DefaultTabController(
        length: Tabs.values.length,
        child: Scaffold(
          body: NestedScrollView(
            headerSliverBuilder: _headerSliverBuilder,
            body: TabBarView(children: Tabs.values.map((e) => _TabView(tab: e)).toList()),
          ),
        ),
      ),
    );
  }
}

class _TabView extends StatelessWidget {
  const _TabView({required this.tab});

  final Tabs tab;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: kTextTabBarHeight),
      child: switch (tab) {
        Tabs.timers => const Timers(),
        Tabs.fissures => const FissuresPage(),
        Tabs.invasions => const InvasionsPage(),
        Tabs.syndicates => const SyndicatePage(),
      },
    );
  }
}
