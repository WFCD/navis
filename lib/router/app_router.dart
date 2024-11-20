import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navis/router/routes.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class AppRouter {
  AppRouter({
    required GlobalKey<NavigatorState> navigatorKey,
    bool debugLogDiagnostics = false,
  }) {
    _goRouter = _routes(
      navigatorKey,
      debugLogDiagnostics,
    );
  }

  late final GoRouter _goRouter;

  GoRouter get routes => _goRouter;

  GoRouter _routes(
    GlobalKey<NavigatorState> navigatorKey,
    bool debugLogDiagnostics,
  ) {
    return GoRouter(
      navigatorKey: navigatorKey,
      initialLocation: const ActivitesPageRouteData().location,
      observers: [SentryNavigatorObserver()],
      debugLogDiagnostics: debugLogDiagnostics,
      routes: $appRoutes,
    );
  }
}
