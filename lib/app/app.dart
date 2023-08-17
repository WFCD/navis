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
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    final notifications = context.read<NotificationRepository>()..configure();
    final userSettingsNotifier = context.read<UserSettingsNotifier>();

    if (userSettingsNotifier.isFirstTime) {
      final platform = userSettingsNotifier.platform;
      notifications.subscribeToPlatform(platform);
    }

    _timer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => context.read<SolsystemCubit>().fetchWorldstate(forceUpdate: true),
    );
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _timer = Timer.periodic(
          const Duration(seconds: 60),
          (_) =>
              context.read<SolsystemCubit>().fetchWorldstate(forceUpdate: true),
        );

      case AppLifecycleState.inactive ||
            AppLifecycleState.paused ||
            AppLifecycleState.detached ||
            AppLifecycleState.hidden:
        _timer.cancel();
    }
  }

  Widget _builder(BuildContext context, Widget? widget) {
    final l10n = NavisLocalizations.of(context);

    ErrorWidget.builder = (FlutterErrorDetails error) {
      Widget errorWidget = NavisErrorWidget(
        title: l10n?.errorTitle ?? 'An application error has occurred',
        description: l10n?.errorDescription ?? 'There was unexpected error.',
        details: error,
      );

      if (widget is Scaffold || widget is Navigator) {
        errorWidget = Scaffold(body: Center(child: errorWidget));
      }

      return errorWidget;
    };

    if (widget != null) return widget;

    throw Exception('Widget is null');
  }

  Locale localeResolutionCallback(
    Locale? locale,
    Iterable<Locale> supportedLocales,
  ) {
    Locale? newLocale;

    for (final supportedLocale in supportedLocales) {
      if (locale?.languageCode == supportedLocale.languageCode) {
        newLocale = supportedLocale;
      }
    }

    newLocale ??= supportedLocales.firstWhere((e) => e.languageCode == 'en');

    final settings = context.read<UserSettingsNotifier>();
    if (settings.language != newLocale) {
      settings.setLanguage(newLocale, notify: false);
    }

    return newLocale;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navis',
      color: Colors.grey[900],
      themeMode: context.watch<UserSettingsNotifier>().theme,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
      home: const HomeView(),
      builder: _builder,
      navigatorObservers: [SentryNavigatorObserver()],
      routes: <String, WidgetBuilder>{
        EventInformation.route: (_) => const EventInformation(),
        SettingsPage.route: (_) => const SettingsPage(),
        NightwavesPage.route: (_) => const NightwavesPage(),
        BountiesPage.route: (_) => const BountiesPage(),
        BaroInventory.route: (_) => const BaroInventory(),
      },
      supportedLocales: NavisLocalizations.supportedLocales,
      locale: context.read<UserSettingsNotifier>().language,
      localizationsDelegates: NavisLocalizations.localizationsDelegates,
      localeResolutionCallback: localeResolutionCallback,
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
