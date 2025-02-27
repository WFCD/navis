// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'routes.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $appShell,
  $worldEventPageRoute,
  $syndicatePageRoute,
  $nightwavePageRoute,
  $synthTargetsPageRoute,
  $traderPageRoute,
  $fishPageRoute,
  $codexPageRoute,
  $newsPageRoute,
  $calendar1999PageRoute,
];

RouteBase get $appShell => StatefulShellRouteData.$route(
  navigatorContainerBuilder: AppShell.$navigatorContainerBuilder,
  factory: $AppShellExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/overview', name: 'overview', factory: $OverviewPageRouteDataExtension._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/activities',
          name: 'activities',
          factory: $ActivitesPageRouteDataExtension._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/explore', name: 'explore', factory: $ExplorePageRouteDataExtension._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/settings', name: 'settings', factory: $SettingsPageRouteDataExtension._fromState),
      ],
    ),
  ],
);

extension $AppShellExtension on AppShell {
  static AppShell _fromState(GoRouterState state) => const AppShell();
}

extension $OverviewPageRouteDataExtension on OverviewPageRouteData {
  static OverviewPageRouteData _fromState(GoRouterState state) => const OverviewPageRouteData();

  String get location => GoRouteData.$location('/overview');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ActivitesPageRouteDataExtension on ActivitesPageRouteData {
  static ActivitesPageRouteData _fromState(GoRouterState state) => const ActivitesPageRouteData();

  String get location => GoRouteData.$location('/activities');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $ExplorePageRouteDataExtension on ExplorePageRouteData {
  static ExplorePageRouteData _fromState(GoRouterState state) => const ExplorePageRouteData();

  String get location => GoRouteData.$location('/explore');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

extension $SettingsPageRouteDataExtension on SettingsPageRouteData {
  static SettingsPageRouteData _fromState(GoRouterState state) => const SettingsPageRouteData();

  String get location => GoRouteData.$location('/settings');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $worldEventPageRoute =>
    GoRouteData.$route(path: '/event', name: 'event', factory: $WorldEventPageRouteExtension._fromState);

extension $WorldEventPageRouteExtension on WorldEventPageRoute {
  static WorldEventPageRoute _fromState(GoRouterState state) => WorldEventPageRoute(state.extra as WorldEvent);

  String get location => GoRouteData.$location('/event');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

RouteBase get $syndicatePageRoute =>
    GoRouteData.$route(path: '/bounties', name: 'bounties', factory: $SyndicatePageRouteExtension._fromState);

extension $SyndicatePageRouteExtension on SyndicatePageRoute {
  static SyndicatePageRoute _fromState(GoRouterState state) => SyndicatePageRoute(state.extra as SyndicateMission);

  String get location => GoRouteData.$location('/bounties');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

RouteBase get $nightwavePageRoute =>
    GoRouteData.$route(path: '/nightwave', name: 'nightwave', factory: $NightwavePageRouteExtension._fromState);

extension $NightwavePageRouteExtension on NightwavePageRoute {
  static NightwavePageRoute _fromState(GoRouterState state) => NightwavePageRoute(state.extra as Nightwave?);

  String get location => GoRouteData.$location('/nightwave');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

RouteBase get $synthTargetsPageRoute =>
    GoRouteData.$route(path: '/targets', name: 'targets', factory: $SynthTargetsPageRouteExtension._fromState);

extension $SynthTargetsPageRouteExtension on SynthTargetsPageRoute {
  static SynthTargetsPageRoute _fromState(GoRouterState state) => const SynthTargetsPageRoute();

  String get location => GoRouteData.$location('/targets');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $traderPageRoute =>
    GoRouteData.$route(path: '/trader', name: 'trader', factory: $TraderPageRouteExtension._fromState);

extension $TraderPageRouteExtension on TraderPageRoute {
  static TraderPageRoute _fromState(GoRouterState state) => TraderPageRoute(state.extra as List<TraderItem>?);

  String get location => GoRouteData.$location('/trader');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

RouteBase get $fishPageRoute =>
    GoRouteData.$route(path: '/fish', name: 'fish', factory: $FishPageRouteExtension._fromState);

extension $FishPageRouteExtension on FishPageRoute {
  static FishPageRoute _fromState(GoRouterState state) => const FishPageRoute();

  String get location => GoRouteData.$location('/fish');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $codexPageRoute =>
    GoRouteData.$route(path: '/codex', name: 'codex', factory: $CodexPageRouteExtension._fromState);

extension $CodexPageRouteExtension on CodexPageRoute {
  static CodexPageRoute _fromState(GoRouterState state) => CodexPageRoute(state.extra as String);

  String get location => GoRouteData.$location('/codex');

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}

RouteBase get $newsPageRoute =>
    GoRouteData.$route(path: '/news', name: 'news', factory: $NewsPageRouteExtension._fromState);

extension $NewsPageRouteExtension on NewsPageRoute {
  static NewsPageRoute _fromState(GoRouterState state) => const NewsPageRoute();

  String get location => GoRouteData.$location('/news');

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) => context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $calendar1999PageRoute =>
    GoRouteData.$route(path: '/calendar', name: 'calendar', factory: $Calendar1999PageRouteExtension._fromState);

extension $Calendar1999PageRouteExtension on Calendar1999PageRoute {
  static Calendar1999PageRoute _fromState(GoRouterState state) =>
      Calendar1999PageRoute(state.uri.queryParameters['season']!, state.extra as List<CalendarDay>);

  String get location => GoRouteData.$location('/calendar', queryParams: {'season': season});

  void go(BuildContext context) => context.go(location, extra: $extra);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location, extra: $extra);

  void pushReplacement(BuildContext context) => context.pushReplacement(location, extra: $extra);

  void replace(BuildContext context) => context.replace(location, extra: $extra);
}
