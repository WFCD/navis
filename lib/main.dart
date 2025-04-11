import 'dart:developer' as dev;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';
import 'package:matomo_tracker/matomo_tracker.dart' hide Level;
import 'package:navis/app/app.dart';
import 'package:navis/bootstrap.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:sentry_logging/sentry_logging.dart';

Future<void> main() async {
  const siteId = 2;
  const tracesSampleRate = 1.0;

  if (kDebugMode) {
    Logger.root.level = Level.ALL; // defaults to Level.INFO
    Logger.root.onRecord.listen((record) {
      var message = '${record.level.name}: ${record.time}: ${record.loggerName}: ${record.message} ';
      if (record.error != null) message += '${record.error}';
      if (record.stackTrace != null) message += '${record.stackTrace}';

      dev.log(message);
    });
  }

  final logger = Logger('Main');

  await SentryFlutter.init(
    (option) {
      option
        ..dsn = kDebugMode || kProfileMode ? '' : const String.fromEnvironment('SENTRY_DSN')
        ..debug = kDebugMode
        ..enableDeduplication = true
        ..tracesSampleRate = tracesSampleRate
        ..ignoreErrors = ['SocketException', 'ClientException']
        ..enableBreadcrumbTrackingForCurrentPlatform()
        ..addIntegration(LoggingIntegration());
    },
    appRunner: () async {
      if (!kDebugMode || !kProfileMode) {
        logger.info('Starting up Matomo Tracker');
        await MatomoTracker.instance.initialize(
          siteId: siteId.toString(),
          url: const String.fromEnvironment('MATOMO_URL'),
        );
      }

      logger.info('Boostraping app start up');
      await bootstrap((router) => DefaultAssetBundle(bundle: SentryAssetBundle(), child: NavisApp(router: router)));
    },
  );
}
