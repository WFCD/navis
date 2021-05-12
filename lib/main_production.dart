import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:matomo/matomo.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'start_app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );

  await SentryFlutter.init(
    (option) => option.dsn = const String.fromEnvironment('SENTRY_DSN'),
    appRunner: () async {
      await MatomoTracker().initialize(
          siteId: 2, url: const String.fromEnvironment('MATOMO_URL'));

      await startApp();
    },
  );
}
