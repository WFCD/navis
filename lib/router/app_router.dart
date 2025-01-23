import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/router/routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppRouter {
  AppRouter({
    required GlobalKey<NavigatorState> navigatorKey,
    required RouteObserver<ModalRoute<void>> observer,
    bool debugLogDiagnostics = false,
  }) {
    _goRouter = _routes(
      navigatorKey,
      observer,
      debugLogDiagnostics,
    );
  }

  late final GoRouter _goRouter;

  GoRouter get routes => _goRouter;

  GoRouter _routes(
    GlobalKey<NavigatorState> navigatorKey,
    RouteObserver<ModalRoute<void>> observer,
    bool debugLogDiagnostics,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: const ActivitesPageRouteData().location,
      observers: [observer, matomoObserver, SentryNavigatorObserver()],
      debugLogDiagnostics: debugLogDiagnostics,
      routes: $appRoutes,
    );
  }
}
