import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:matomo_tracker/matomo_tracker.dart';
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  const siteId = 2;
  const tracesSampleRate = 1.0;

  await SentryFlutter.init(
    (option) {
      option
        ..dsn = kDebugMode || kProfileMode ? '' : const String.fromEnvironment('SENTRY_DSN')
        ..enableDeduplication = true
        ..tracesSampleRate = tracesSampleRate
        ..enableBreadcrumbTrackingForCurrentPlatform()
        ..addIntegration(LoggingIntegration());
    },
    appRunner: () async {
      if (!kDebugMode || !kProfileMode) {
        await MatomoTracker.instance.initialize(
          siteId: siteId.toString(),
          url: const String.fromEnvironment('MATOMO_URL'),
        );
      }

      await bootstrap((router) => DefaultAssetBundle(bundle: SentryAssetBundle(), child: NavisApp(router: router)));
    },
  );
}
