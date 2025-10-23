import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/app/app.dart';
import 'package:navis/codex/codex.dart';
import 'package:navis/explore/explore.dart';
import 'package:navis/home/home.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/synthtargets/synthtargets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:worldstate_models/worldstate_models.dart';

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
class ActivitesPageRouteData extends GoRouteData with $ActivitesPageRouteData {
  const ActivitesPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(
      actionName: 'Activites()',
      child: SafeArea(child: ActivitiesPage()),
    );
  }
}

@immutable
class OverviewPageBranchData extends StatefulShellBranchData {
  const OverviewPageBranchData();
}

@immutable
class OverviewPageRouteData extends GoRouteData with $OverviewPageRouteData {
  const OverviewPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'Overview()', child: HomePage());
  }
}

@immutable
class ExplorePageBranchData extends StatefulShellBranchData {
  const ExplorePageBranchData();
}

@immutable
class ExplorePageRouteData extends GoRouteData with $ExplorePageRouteData {
  const ExplorePageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(
      actionName: 'Explore()',
      child: SafeArea(child: ExplorePage()),
    );
  }
}

@immutable
class SettingsPageBranchData extends StatefulShellBranchData {
  const SettingsPageBranchData();
}

@immutable
class SettingsPageRouteData extends GoRouteData with $SettingsPageRouteData {
  const SettingsPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(
      actionName: 'Settings()',
      child: SafeArea(child: SettingsPage()),
    );
  }
}

@immutable
@TypedGoRoute<WorldEventPageRoute>(name: 'event', path: '/event')
class WorldEventPageRoute extends GoRouteData with $WorldEventPageRoute {
  const WorldEventPageRoute(this.$extra);

  final WorldEvent $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'WorldEvent()',
      child: EventInformation(event: $extra),
    );
  }
}

@immutable
@TypedGoRoute<SyndicatePageRoute>(name: 'bounties', path: '/bounties')
class SyndicatePageRoute extends GoRouteData with $SyndicatePageRoute {
  const SyndicatePageRoute(this.$extra);

  final SyndicateMission $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'BountiesPage(${$extra.name})',
      child: BountiesPage(syndicate: $extra),
    );
  }
}

@immutable
@TypedGoRoute<NightwavePageRoute>(name: 'nightwave', path: '/nightwave')
class NightwavePageRoute extends GoRouteData with $NightwavePageRoute {
  const NightwavePageRoute(this.$extra);

  final Nightwave? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'Nightwave()',
      child: NightwavesPage(nightwave: $extra),
    );
  }
}

@immutable
@TypedGoRoute<SynthTargetsPageRoute>(name: 'targets', path: '/targets')
class SynthTargetsPageRoute extends GoRouteData with $SynthTargetsPageRoute {
  const SynthTargetsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'SynthTargets()', child: SynthTargetsView());
  }
}

@immutable
@TypedGoRoute<TraderPageRoute>(name: 'trader', path: '/trader')
class TraderPageRoute extends GoRouteData with $TraderPageRoute {
  const TraderPageRoute(this.character, this.$extra, {this.isVarzia = false});

  final String character;
  final bool isVarzia;
  final List<TraderItem>? $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'BaroInventory()',
      child: BaroInventory(character: character, inventory: $extra, isVarzia: isVarzia),
    );
  }
}

@immutable
@TypedGoRoute<FishPageRoute>(name: 'fish', path: '/fish')
class FishPageRoute extends GoRouteData with $FishPageRoute {
  const FishPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'Fish()', child: FishPage());
  }
}

@immutable
@TypedGoRoute<CodexPageRoute>(name: 'codex', path: '/codex')
class CodexPageRoute extends GoRouteData with $CodexPageRoute {
  const CodexPageRoute(this.$extra);

  final String $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'CodexSearch()',
      child: CodexSearchPage(query: $extra),
    );
  }
}

@immutable
@TypedGoRoute<NewsPageRoute>(name: 'news', path: '/news')
class NewsPageRoute extends GoRouteData with $NewsPageRoute {
  const NewsPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'Orbiter()', child: OrbiterNewsPage());
  }
}

@immutable
@TypedGoRoute<MasteryPageRoute>(name: 'mastery', path: '/mastery')
class MasteryPageRoute extends GoRouteData with $MasteryPageRoute {
  const MasteryPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'Mastery()', child: MasteryPage());
  }
}

@immutable
@TypedGoRoute<Calendar1999PageRoute>(name: 'calendar', path: '/calendar')
class Calendar1999PageRoute extends GoRouteData with $Calendar1999PageRoute {
  const Calendar1999PageRoute(this.season, this.$extra);

  final String season;
  final List<CalendarDay> $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'Calendar()',
      child: CalendarPage(season: season, days: $extra),
    );
  }
}

@immutable
@TypedGoRoute<ArchimedeaPageRoute>(name: 'archimedea', path: '/archimedea')
class ArchimedeaPageRoute extends GoRouteData with $ArchimedeaPageRoute {
  const ArchimedeaPageRoute(this.$extra);

  final Archimedea $extra;

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return TraceableWidget(
      actionName: 'Archimedea(${$extra.id})',
      child: ArchimedeaPage(archimedea: $extra),
    );
  }
}

@immutable
@TypedGoRoute<FlashSalesPageRoute>(name: 'flashSales', path: '/worldstate/flashSales')
class FlashSalesPageRoute extends GoRouteData with $FlashSalesPageRoute {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const TraceableWidget(actionName: 'flashSales', child: FlashSalesPage());
  }
}
