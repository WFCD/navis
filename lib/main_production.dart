import 'package:matomo/matomo.dart';
import 'package:navis/injection_container.dart';
import 'package:navis/start_app.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:user_settings/user_settings.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (option) {
      option
        ..dsn = const String.fromEnvironment('SENTRY_DSN')
        ..beforeSend = (SentryEvent event, {dynamic hint}) {
          final usersettings = sl<UserSettings>();

          return event.copyWith(
            extra: <String, dynamic>{
              'gamePlatform': usersettings.platform,
              'appLanguage': usersettings.language
            },
          );
        };
    },
    appRunner: () async {
      await MatomoTracker().initialize(
        siteId: 2,
        url: const String.fromEnvironment('MATOMO_URL'),
      );

      await startApp();
    },
  );
}
