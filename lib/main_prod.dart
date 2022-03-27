import 'package:matomo/matomo.dart';
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (option) => option.dsn = const String.fromEnvironment('SENTRY_DSN'),
    appRunner: () async {
      await MatomoTracker().initialize(
        siteId: 2,
        url: const String.fromEnvironment('MATOMO_URL'),
      );

      await bootstrap(() => const NavisApp());
    },
  );
}
