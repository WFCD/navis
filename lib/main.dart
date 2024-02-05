import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
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
        ..enableDeduplication = true
        ..tracesSampleRate = tracesSampleRate
        ..enableBreadcrumbTrackingForCurrentPlatform()
        ..addIntegration(LoggingIntegration())
        ..beforeSend = _beforeSend;
    },
    appRunner: () async {
      if (!kDebugMode || !kProfileMode) {
        await MatomoTracker.instance.initialize(
          siteId: siteId,
          url: const String.fromEnvironment('MATOMO_URL'),
        );
      }

      await bootstrap(
        () => DefaultAssetBundle(
          bundle: SentryAssetBundle(),
          child: const NavisApp(),
        ),
      );
    },
  );
}

SentryEvent? _beforeSend(SentryEvent event, {Hint? hint}) {
  if (kDebugMode || kProfileMode) return null;

  return event;
}
