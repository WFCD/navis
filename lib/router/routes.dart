import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/codex/views/codex_search_view.dart';
import 'package:navis/explore/views/fish_view.dart';
import 'package:navis/explore/views/main_view.dart';
import 'package:navis/home/home.dart';
import 'package:navis/settings/views/settings.dart';
import 'package:navis/synthtargets/synthtargets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'routes.g.dart';

@TypedStatefulShellRoute<HomeScreenRouteDate>(
  branches: [
    TypedStatefulShellBranch<OverviewPageBranchData>(
      routes: [
        TypedGoRoute<OverviewPageRouteData>(
          name: 'overview',
          path: '/overview',
        ),
      ],
    ),
    TypedStatefulShellBranch<OrbiterPageBranchData>(
      routes: [
        TypedGoRoute<OrbiterPageRouteData>(
          name: 'orbiter',
          path: '/orbiter',
        ),
      ],
    ),
    TypedStatefulShellBranch<ExplorePageBranchData>(
      routes: [
        TypedGoRoute<ExplorePageRouteData>(
          name: 'explore',
          path: '/explore',
        ),
      ],
    ),
  ],
)
@immutable
class HomeScreenRouteDate extends StatefulShellRouteData {
  const HomeScreenRouteDate();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) =>
      navigationShell;

  static Widget $navigatorContainerBuilder(
    BuildContext context,
    StatefulNavigationShell navigationShell,
    List<Widget> children,
  ) {
    return HomePage(navigationShell: navigationShell, children: children);
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
    return const FeedView();
  }
}

@immutable
class OrbiterPageBranchData extends StatefulShellBranchData {
  const OrbiterPageBranchData();
}

@immutable
class OrbiterPageRouteData extends GoRouteData {
  const OrbiterPageRouteData();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OrbiterNewsPage();
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
    return const ExplorePage();
  }
}

@immutable
@TypedGoRoute<SettingsPageRoute>(name: 'settings', path: '/settings')
class SettingsPageRoute extends GoRouteData {
  const SettingsPageRoute();

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
    return EventInformation(event: $extra);
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
  const CodexPageRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CodexSearchPage();
  }
}
