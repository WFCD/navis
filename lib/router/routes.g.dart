// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $homeScreenRouteDate,
      $settingsPageRoute,
      $worldEventPageRoute,
      $syndicatePageRoute,
      $nightwavePageRoute,
      $synthTargetsPageRoute,
      $traderPageRoute,
      $fishPageRoute,
      $codexPageRoute,
    ];

RouteBase get $homeScreenRouteDate => StatefulShellRouteData.$route(
      navigatorContainerBuilder: HomeScreenRouteDate.$navigatorContainerBuilder,
      factory: $HomeScreenRouteDateExtension._fromState,
      branches: [
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/overview',
              name: 'overview',
              factory: $OverviewPageRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/orbiter',
              name: 'orbiter',
              factory: $OrbiterPageRouteDataExtension._fromState,
            ),
          ],
        ),
        StatefulShellBranchData.$branch(
          routes: [
            GoRouteData.$route(
              path: '/explore',
              name: 'explore',
              factory: $ExplorePageRouteDataExtension._fromState,
            ),
          ],
        ),
      ],
    );

extension $HomeScreenRouteDateExtension on HomeScreenRouteDate {
  static HomeScreenRouteDate _fromState(GoRouterState state) =>
      const HomeScreenRouteDate();
}

extension $OverviewPageRouteDataExtension on OverviewPageRouteData {
  static OverviewPageRouteData _fromState(GoRouterState state) =>
      const OverviewPageRouteData();

  String get location => GoRouteData.$location(
        '/overview',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $OrbiterPageRouteDataExtension on OrbiterPageRouteData {
  static OrbiterPageRouteData _fromState(GoRouterState state) =>
      const OrbiterPageRouteData();

  String get location => GoRouteData.$location(
        '/orbiter',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExplorePageRouteDataExtension on ExplorePageRouteData {
  static ExplorePageRouteData _fromState(GoRouterState state) =>
      const ExplorePageRouteData();

  String get location => GoRouteData.$location(
        '/explore',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $settingsPageRoute => GoRouteData.$route(
      path: '/settings',
      name: 'settings',
      factory: $SettingsPageRouteExtension._fromState,
    );

extension $SettingsPageRouteExtension on SettingsPageRoute {
  static SettingsPageRoute _fromState(GoRouterState state) =>
      const SettingsPageRoute();

  String get location => GoRouteData.$location(
        '/settings',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $worldEventPageRoute => GoRouteData.$route(
      path: '/event',
      name: 'event',
      factory: $WorldEventPageRouteExtension._fromState,
    );

extension $WorldEventPageRouteExtension on WorldEventPageRoute {
  static WorldEventPageRoute _fromState(GoRouterState state) =>
      WorldEventPageRoute(
        state.extra as WorldEvent,
      );

  String get location => GoRouteData.$location(
        '/event',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $syndicatePageRoute => GoRouteData.$route(
      path: '/bounties',
      name: 'bounties',
      factory: $SyndicatePageRouteExtension._fromState,
    );

extension $SyndicatePageRouteExtension on SyndicatePageRoute {
  static SyndicatePageRoute _fromState(GoRouterState state) =>
      SyndicatePageRoute(
        state.extra as SyndicateMission,
      );

  String get location => GoRouteData.$location(
        '/bounties',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $nightwavePageRoute => GoRouteData.$route(
      path: '/nightwave',
      name: 'nightwave',
      factory: $NightwavePageRouteExtension._fromState,
    );

extension $NightwavePageRouteExtension on NightwavePageRoute {
  static NightwavePageRoute _fromState(GoRouterState state) =>
      NightwavePageRoute(
        state.extra as Nightwave?,
      );

  String get location => GoRouteData.$location(
        '/nightwave',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $synthTargetsPageRoute => GoRouteData.$route(
      path: '/targets',
      name: 'targets',
      factory: $SynthTargetsPageRouteExtension._fromState,
    );

extension $SynthTargetsPageRouteExtension on SynthTargetsPageRoute {
  static SynthTargetsPageRoute _fromState(GoRouterState state) =>
      const SynthTargetsPageRoute();

  String get location => GoRouteData.$location(
        '/targets',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $traderPageRoute => GoRouteData.$route(
      path: '/trader',
      name: 'trader',
      factory: $TraderPageRouteExtension._fromState,
    );

extension $TraderPageRouteExtension on TraderPageRoute {
  static TraderPageRoute _fromState(GoRouterState state) => TraderPageRoute(
        state.extra as List<TraderItem>?,
      );

  String get location => GoRouteData.$location(
        '/trader',
      );

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) =>
      context.replace(location, extra: $extra);
}

RouteBase get $fishPageRoute => GoRouteData.$route(
      path: '/fish',
      name: 'fish',
      factory: $FishPageRouteExtension._fromState,
    );

extension $FishPageRouteExtension on FishPageRoute {
  static FishPageRoute _fromState(GoRouterState state) => const FishPageRoute();

  String get location => GoRouteData.$location(
        '/fish',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $codexPageRoute => GoRouteData.$route(
      path: '/codex',
      name: 'codex',
      factory: $CodexPageRouteExtension._fromState,
    );

extension $CodexPageRouteExtension on CodexPageRoute {
  static CodexPageRoute _fromState(GoRouterState state) =>
      const CodexPageRoute();

  String get location => GoRouteData.$location(
        '/codex',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
