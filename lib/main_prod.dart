import 'package:flutter/cupertino.dart';
import 'package:matomo/matomo.dart';
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  const siteId = 2;

  // Can be any value between 0 and 1.
  // 0.25 = 25%
  const tracesSampleRate = 0.25;

  await SentryFlutter.init(
    (option) {
      option
        ..dsn = const String.fromEnvironment('SENTRY_DSN')
        ..enableBreadcrumbTrackingForCurrentPlatform()
        ..tracesSampleRate = tracesSampleRate
        ..addIntegration(LoggingIntegration());
    },
    appRunner: () async {
      await MatomoTracker().initialize(
        siteId: siteId,
        url: const String.fromEnvironment('MATOMO_URL'),
      );

      await bootstrap(() {
        return DefaultAssetBundle(
          bundle: SentryAssetBundle(enableStructuredDataTracing: true),
          child: const NavisApp(),
        );
      });
    },
  );
}
