import 'package:matomo/matomo.dart';
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  const siteId = 2;

  await SentryFlutter.init(
    (option) {
      option
        ..dsn = const String.fromEnvironment('SENTRY_DSN')
        ..addIntegration(LoggingIntegration());
    },
    appRunner: () async {
      await MatomoTracker().initialize(
        siteId: siteId,
        url: const String.fromEnvironment('MATOMO_URL'),
      );

      await bootstrap(() => const NavisApp());
    },
  );
}
