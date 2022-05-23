import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/home.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:user_settings/user_settings.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({super.key});

  @override
  _NavisAppState createState() => _NavisAppState();
}

class _NavisAppState extends State<NavisApp> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    context.read<NotificationRepository>().configure();
    if (context.read<UserSettingsNotifier>().isFirstTime) {
      final platform = context.read<UserSettingsNotifier>().platform;
      context.read<NotificationRepository>().subscribeToPlatform(platform);
    }
  }

  @override
  void didChangeDependencies() {
    const package = 'navis_ui';

    precacheImage(
      const AssetImage('assets/baro_banner.webp', package: package),
      context,
    );
    precacheImage(
      const AssetImage('assets/Derelict.webp', package: package),
      context,
    );
    super.didChangeDependencies();
  }

  Widget _builder(BuildContext context, Widget? widget) {
    final l10n = NavisLocalizations.of(context);

    ErrorWidget.builder = (FlutterErrorDetails error) {
      Widget _error = NavisErrorWidget(
        title: l10n?.errorTitle ?? 'An application error has occurred',
        description: l10n?.errorDescription ?? 'There was unexpected error.',
        details: error,
      );

      if (widget is Scaffold || widget is Navigator) {
        _error = Scaffold(body: Center(child: _error));
      }

      return _error;
    };

    return widget!;
  }

  Locale localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    Locale? _locale;

    for (final supportedLocale in supportedLocales) {
      if (locale?.languageCode == supportedLocale.languageCode) {
        _locale = supportedLocale;
      }
    }

    _locale ??= supportedLocales.firstWhere((e) => e.languageCode == 'en');

    if (context.read<UserSettingsNotifier>().language != _locale) {
      context.read<UserSettingsNotifier>().setLanguage(_locale, notify: false);
    }

    return _locale;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navis',
      color: Colors.grey[900],
      themeMode: context.watch<UserSettingsNotifier>().theme,
      theme: NavisTheme.standard,
      darkTheme: NavisTheme.dark,
      home: const HomeView(),
      builder: _builder,
      navigatorObservers: [SentryNavigatorObserver()],
      routes: <String, WidgetBuilder>{
        EventInformation.route: (_) => const EventInformation(),
        SettingsView.route: (_) => const SettingsView(),
        NightwavesPage.route: (_) => const NightwavesPage(),
        BountiesPage.route: (_) => const BountiesPage(),
        BaroInventory.route: (_) => const BaroInventory()
      },
      supportedLocales: NavisLocalizations.supportedLocales,
      locale: context.read<UserSettingsNotifier>().language,
      localizationsDelegates: NavisLocalizations.localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
