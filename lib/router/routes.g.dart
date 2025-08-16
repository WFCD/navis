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
  $masteryPageRoute,
  $calendar1999PageRoute,
  $archimedeaPageRoute,
  $flashSalesPageRoute,
];

RouteBase get $appShell => StatefulShellRouteData.$route(
  navigatorContainerBuilder: AppShell.$navigatorContainerBuilder,
  factory: $AppShellExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/overview',
          name: 'overview',

          factory: _$OverviewPageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/activities',
          name: 'activities',

          factory: _$ActivitesPageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/explore',
          name: 'explore',

          factory: _$ExplorePageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          name: 'settings',

          factory: _$SettingsPageRouteData._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellExtension on AppShell {
  static AppShell _fromState(GoRouterState state) => const AppShell();
}

mixin _$OverviewPageRouteData on GoRouteData {
  static OverviewPageRouteData _fromState(GoRouterState state) =>
      const OverviewPageRouteData();

  @override
  String get location => GoRouteData.$location('/overview');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ActivitesPageRouteData on GoRouteData {
  static ActivitesPageRouteData _fromState(GoRouterState state) =>
      const ActivitesPageRouteData();

  @override
  String get location => GoRouteData.$location('/activities');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$ExplorePageRouteData on GoRouteData {
  static ExplorePageRouteData _fromState(GoRouterState state) =>
      const ExplorePageRouteData();

  @override
  String get location => GoRouteData.$location('/explore');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin _$SettingsPageRouteData on GoRouteData {
  static SettingsPageRouteData _fromState(GoRouterState state) =>
      const SettingsPageRouteData();

  @override
  String get location => GoRouteData.$location('/settings');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $worldEventPageRoute => GoRouteData.$route(
  path: '/event',
  name: 'event',

  factory: _$WorldEventPageRoute._fromState,
);

mixin _$WorldEventPageRoute on GoRouteData {
  static WorldEventPageRoute _fromState(GoRouterState state) =>
      WorldEventPageRoute(state.extra as WorldEvent);

  WorldEventPageRoute get _self => this as WorldEventPageRoute;

  @override
  String get location => GoRouteData.$location('/event');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $syndicatePageRoute => GoRouteData.$route(
  path: '/bounties',
  name: 'bounties',

  factory: _$SyndicatePageRoute._fromState,
);

mixin _$SyndicatePageRoute on GoRouteData {
  static SyndicatePageRoute _fromState(GoRouterState state) =>
      SyndicatePageRoute(state.extra as SyndicateMission);

  SyndicatePageRoute get _self => this as SyndicatePageRoute;

  @override
  String get location => GoRouteData.$location('/bounties');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $nightwavePageRoute => GoRouteData.$route(
  path: '/nightwave',
  name: 'nightwave',

  factory: _$NightwavePageRoute._fromState,
);

mixin _$NightwavePageRoute on GoRouteData {
  static NightwavePageRoute _fromState(GoRouterState state) =>
      NightwavePageRoute(state.extra as Nightwave?);

  NightwavePageRoute get _self => this as NightwavePageRoute;

  @override
  String get location => GoRouteData.$location('/nightwave');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $synthTargetsPageRoute => GoRouteData.$route(
  path: '/targets',
  name: 'targets',

  factory: _$SynthTargetsPageRoute._fromState,
);

mixin _$SynthTargetsPageRoute on GoRouteData {
  static SynthTargetsPageRoute _fromState(GoRouterState state) =>
      const SynthTargetsPageRoute();

  @override
  String get location => GoRouteData.$location('/targets');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $traderPageRoute => GoRouteData.$route(
  path: '/trader',
  name: 'trader',

  factory: _$TraderPageRoute._fromState,
);

mixin _$TraderPageRoute on GoRouteData {
  static TraderPageRoute _fromState(GoRouterState state) =>
      TraderPageRoute(state.extra as List<TraderItem>?);

  TraderPageRoute get _self => this as TraderPageRoute;

  @override
  String get location => GoRouteData.$location('/trader');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $fishPageRoute => GoRouteData.$route(
  path: '/fish',
  name: 'fish',

  factory: _$FishPageRoute._fromState,
);

mixin _$FishPageRoute on GoRouteData {
  static FishPageRoute _fromState(GoRouterState state) => const FishPageRoute();

  @override
  String get location => GoRouteData.$location('/fish');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $codexPageRoute => GoRouteData.$route(
  path: '/codex',
  name: 'codex',

  factory: _$CodexPageRoute._fromState,
);

mixin _$CodexPageRoute on GoRouteData {
  static CodexPageRoute _fromState(GoRouterState state) =>
      CodexPageRoute(state.extra as String);

  CodexPageRoute get _self => this as CodexPageRoute;

  @override
  String get location => GoRouteData.$location('/codex');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $newsPageRoute => GoRouteData.$route(
  path: '/news',
  name: 'news',

  factory: _$NewsPageRoute._fromState,
);

mixin _$NewsPageRoute on GoRouteData {
  static NewsPageRoute _fromState(GoRouterState state) => const NewsPageRoute();

  @override
  String get location => GoRouteData.$location('/news');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $masteryPageRoute => GoRouteData.$route(
  path: '/mastery',
  name: 'mastery',

  factory: _$MasteryPageRoute._fromState,
);

mixin _$MasteryPageRoute on GoRouteData {
  static MasteryPageRoute _fromState(GoRouterState state) =>
      const MasteryPageRoute();

  @override
  String get location => GoRouteData.$location('/mastery');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $calendar1999PageRoute => GoRouteData.$route(
  path: '/calendar',
  name: 'calendar',

  factory: _$Calendar1999PageRoute._fromState,
);

mixin _$Calendar1999PageRoute on GoRouteData {
  static Calendar1999PageRoute _fromState(GoRouterState state) =>
      Calendar1999PageRoute(
        state.uri.queryParameters['season']!,
        state.extra as List<CalendarDay>,
      );

  Calendar1999PageRoute get _self => this as Calendar1999PageRoute;

  @override
  String get location =>
      GoRouteData.$location('/calendar', queryParams: {'season': _self.season});

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $archimedeaPageRoute => GoRouteData.$route(
  path: '/archimedea',
  name: 'archimedea',

  factory: _$ArchimedeaPageRoute._fromState,
);

mixin _$ArchimedeaPageRoute on GoRouteData {
  static ArchimedeaPageRoute _fromState(GoRouterState state) =>
      ArchimedeaPageRoute(state.extra as Archimedea);

  ArchimedeaPageRoute get _self => this as ArchimedeaPageRoute;

  @override
  String get location => GoRouteData.$location('/archimedea');

  @override
  void go(BuildContext context) => context.go(location, extra: _self.$extra);

  @override
  Future<T?> push<T>(BuildContext context) =>
      context.push<T>(location, extra: _self.$extra);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location, extra: _self.$extra);

  @override
  void replace(BuildContext context) =>
      context.replace(location, extra: _self.$extra);
}

RouteBase get $flashSalesPageRoute => GoRouteData.$route(
  path: '/worldstate/flashSales',
  name: 'flashSales',

  factory: _$FlashSalesPageRoute._fromState,
);

mixin _$FlashSalesPageRoute on GoRouteData {
  static FlashSalesPageRoute _fromState(GoRouterState state) =>
      FlashSalesPageRoute();

  @override
  String get location => GoRouteData.$location('/worldstate/flashSales');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
