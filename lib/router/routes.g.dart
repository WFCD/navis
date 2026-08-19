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
  $relicsPageRoute,
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
          hasOverriddenOnExit: false,
          factory: $OverviewPageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/activities',
          name: 'activities',
          hasOverriddenOnExit: false,
          factory: $ActivitesPageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/explore',
          name: 'explore',
          hasOverriddenOnExit: false,
          factory: $ExplorePageRouteData._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/settings',
          name: 'settings',
          hasOverriddenOnExit: false,
          factory: $SettingsPageRouteData._fromState,
        ),
      ],
    ),
  ],
);

extension $AppShellExtension on AppShell {
  static AppShell _fromState(GoRouterState state) => const AppShell();
}

mixin $OverviewPageRouteData on GoRouteData {
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

mixin $ActivitesPageRouteData on GoRouteData {
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

mixin $ExplorePageRouteData on GoRouteData {
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

mixin $SettingsPageRouteData on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $WorldEventPageRoute._fromState,
);

mixin $WorldEventPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $SyndicatePageRoute._fromState,
);

mixin $SyndicatePageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $NightwavePageRoute._fromState,
);

mixin $NightwavePageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $SynthTargetsPageRoute._fromState,
);

mixin $SynthTargetsPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $TraderPageRoute._fromState,
);

mixin $TraderPageRoute on GoRouteData {
  static TraderPageRoute _fromState(GoRouterState state) => TraderPageRoute(
    state.uri.queryParameters['character']!,
    isVarzia:
        _$convertMapValue(
          'is-varzia',
          state.uri.queryParameters,
          _$boolConverter,
        ) ??
        false,
    state.extra
        as List<
          ({String name, int primePrice, int regularPrice, String uniqueName})
        >?,
  );

  TraderPageRoute get _self => this as TraderPageRoute;

  @override
  String get location => GoRouteData.$location(
    '/trader',
    queryParams: {
      'character': _self.character,
      if (_self.isVarzia != false) 'is-varzia': _self.isVarzia.toString(),
    },
  );

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

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $fishPageRoute => GoRouteData.$route(
  path: '/fish',
  name: 'fish',
  hasOverriddenOnExit: false,
  factory: $FishPageRoute._fromState,
);

mixin $FishPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $CodexPageRoute._fromState,
);

mixin $CodexPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $NewsPageRoute._fromState,
);

mixin $NewsPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $MasteryPageRoute._fromState,
);

mixin $MasteryPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $Calendar1999PageRoute._fromState,
);

mixin $Calendar1999PageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $ArchimedeaPageRoute._fromState,
);

mixin $ArchimedeaPageRoute on GoRouteData {
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
  hasOverriddenOnExit: false,
  factory: $FlashSalesPageRoute._fromState,
);

mixin $FlashSalesPageRoute on GoRouteData {
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

RouteBase get $relicsPageRoute => GoRouteData.$route(
  path: '/relics',
  name: 'relics',
  hasOverriddenOnExit: false,
  factory: $RelicsPageRoute._fromState,
);

mixin $RelicsPageRoute on GoRouteData {
  static RelicsPageRoute _fromState(GoRouterState state) =>
      const RelicsPageRoute();

  @override
  String get location => GoRouteData.$location('/relics');

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
