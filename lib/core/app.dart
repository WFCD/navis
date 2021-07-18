import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../features/codex/presentation/pages/codex_entry.dart';
import '../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../features/worldstate/presentation/pages/acolyte_profile.dart';
import '../features/worldstate/presentation/pages/bounties.dart';
import '../features/worldstate/presentation/pages/event.dart';
import '../features/worldstate/presentation/pages/nightwaves.dart';
import '../features/worldstate/presentation/pages/trader_inventory.dart';
import '../injection_container.dart';
import '../l10n/l10n.dart';
import 'home.dart';
import 'notifiers/user_settings_notifier.dart';
import 'services/notifications.dart';
import 'settings/settings.dart';
import 'themes/themes.dart';
import 'widgets/widgets.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({Key? key}) : super(key: key);

  @override
  _NavisAppState createState() => _NavisAppState();
}

class _NavisAppState extends State<NavisApp> with WidgetsBindingObserver {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);

    BlocProvider.of<SolsystemBloc>(context).add(const SyncSystemStatus());

    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      BlocProvider.of<SolsystemBloc>(context).add(const SyncSystemStatus());
    });

    sl<NotificationService>().configure();
  }

  Widget _builder(BuildContext context, Widget? widget) {
    ErrorWidget.builder = (FlutterErrorDetails error) {
      Widget _error = NavisErrorWidget(
        details: error,
        showStacktrace: true,
      );

      if (widget is Scaffold || widget is Navigator) {
        _error = Scaffold(body: Center(child: _error));
      }

      return _error;
    };

    return widget!;
  }

  Locale localeResolutionCallback(
      Locale? locale, Iterable<Locale> supportedLocales) {
    Locale? _locale;

    for (final supportedLocale in supportedLocales) {
      if (locale?.languageCode == supportedLocale.languageCode) {
        _locale = supportedLocale;
      }
    }

    _locale ??= supportedLocales.firstWhere((e) => e.languageCode == 'en');

    if (context.read<UserSettingsNotifier>().language != _locale) {
      context.read<UserSettingsNotifier>().setLanguage(_locale);
    }

    return _locale;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<SolsystemBloc>(context).update(forceUpdate: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navis',
      color: Colors.grey[900],
      themeMode: context.watch<UserSettingsNotifier>().theme,
      debugShowCheckedModeBanner: false,
      theme: NavisTheming.light,
      darkTheme: NavisTheming.dark,
      home: const Home(),
      builder: _builder,
      navigatorObservers: [SentryNavigatorObserver()],
      routes: <String, WidgetBuilder>{
        EventInformation.route: (_) => const EventInformation(),
        AcolyteProfile.route: (_) => const AcolyteProfile(),
        Settings.route: (_) => const Settings(),
        NightwavesPage.route: (_) => const NightwavesPage(),
        BountiesPage.route: (_) => const BountiesPage(),
        CodexEntry.route: (_) => const CodexEntry(),
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
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }
}
