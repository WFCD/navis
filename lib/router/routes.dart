import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/app/app.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/explore/explore.dart';
import 'package:navis/home/home.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/synthtargets/synthtargets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<AppShell>(
  branches: [
    TypedStatefulShellBranch<OverviewPageBranchData>(
      routes: [TypedGoRoute<OverviewPageRouteData>(name: 'overview', path: '/overview')],
    ),
    TypedStatefulShellBranch<ActivitiesPageBranchData>(
      routes: [TypedGoRoute<ActivitesPageRouteData>(name: 'activities', path: '/activities')],
    ),
    TypedStatefulShellBranch<ExplorePageBranchData>(
      routes: [TypedGoRoute<ExplorePageRouteData>(name: 'explore', path: '/explore')],
    ),
    TypedStatefulShellBranch<SettingsPageBranchData>(
      routes: [TypedGoRoute<SettingsPageRouteData>(name: 'settings', path: '/settings')],
    ),
  ],
)
@immutable
class AppShell extends StatefulShellRouteData {
  const AppShell();

  @override
  Widget builder(BuildContext context, GoRouterState state, StatefulNavigationShell navigationShell) => navigationShell;

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return AppView(navigationShell: navigationShell, children: children);
  }
}

@immutable
class ActivitiesPageBranchData extends StatefulShellBranchData {
  const ActivitiesPageBranchData();
}

@immutable
class ActivitesPageRouteData extends GoRouteData {
  const ActivitesPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SafeArea(child: ActivitiesView());
  }
}

@immutable
class OverviewPageBranchData extends StatefulShellBranchData {
  const OverviewPageBranchData();
}

@immutable
class OverviewPageRouteData extends GoRouteData {
  const OverviewPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const HomePage();
  }
}

@immutable
class ExplorePageBranchData extends StatefulShellBranchData {
  const ExplorePageBranchData();
}

@immutable
class ExplorePageRouteData extends GoRouteData {
  const ExplorePageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SafeArea(child: ExplorePage());
  }
}

@immutable
class SettingsPageBranchData extends StatefulShellBranchData {
  const SettingsPageBranchData();
}

@immutable
class SettingsPageRouteData extends GoRouteData {
  const SettingsPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SettingsPage();
  }
}

@immutable
@TypedGoRoute<WorldEventPageRoute>(name: 'event', path: '/event')
class WorldEventPageRoute extends GoRouteData {
  const WorldEventPageRoute(this.$extra);

  final WorldEvent $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(actionName: 'worldEvent', child: EventInformation(event: $extra));
  }
}

@immutable
@TypedGoRoute<SyndicatePageRoute>(name: 'bounties', path: '/bounties')
class SyndicatePageRoute extends GoRouteData {
  const SyndicatePageRoute(this.$extra);

  final SyndicateMission $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BountiesPage(syndicate: $extra);
  }
}

@immutable
@TypedGoRoute<NightwavePageRoute>(name: 'nightwave', path: '/nightwave')
class NightwavePageRoute extends GoRouteData {
  const NightwavePageRoute(this.$extra);

  final Nightwave? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return NightwavesPage(nightwave: $extra);
  }
}

@immutable
@TypedGoRoute<SynthTargetsPageRoute>(name: 'targets', path: '/targets')
class SynthTargetsPageRoute extends GoRouteData {
  const SynthTargetsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SynthTargetsView();
  }
}

@immutable
@TypedGoRoute<TraderPageRoute>(name: 'trader', path: '/trader')
class TraderPageRoute extends GoRouteData {
  const TraderPageRoute(this.$extra);

  final List<TraderItem>? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BaroInventory(inventory: $extra);
  }
}

@immutable
@TypedGoRoute<FishPageRoute>(name: 'fish', path: '/fish')
class FishPageRoute extends GoRouteData {
  const FishPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FishPage();
  }
}

@immutable
@TypedGoRoute<CodexPageRoute>(name: 'codex', path: '/codex')
class CodexPageRoute extends GoRouteData {
  const CodexPageRoute(this.$extra);

  final String $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(actionName: 'CodexSearchPage', child: CodexSearchPage(query: $extra));
  }
}

@immutable
@TypedGoRoute<NewsPageRoute>(name: 'news', path: '/news')
class NewsPageRoute extends GoRouteData {
  const NewsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrbiterNewsPage();
  }
}

@immutable
@TypedGoRoute<Calendar1999PageRoute>(name: 'calendar', path: '/calendar')
class Calendar1999PageRoute extends GoRouteData {
  const Calendar1999PageRoute(this.season, this.$extra);

  final String season;
  final List<CalendarDay> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(actionName: 'calendar', child: CalendarPage(season: season, days: $extra));
  }
}

@immutable
@TypedGoRoute<DeepArchimedeaPageRoute>(name: 'deepArchimedea', path: '/deepArchimedea')
class DeepArchimedeaPageRoute extends GoRouteData {
  const DeepArchimedeaPageRoute(this.$extra);

  final DeepArchimedea $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(actionName: 'deepArchimedea', child: ArchimedeaPage(archimedea: $extra));
  }
}
