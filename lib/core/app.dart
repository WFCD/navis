import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';
import 'package:provider/provider.dart';

import '../features/worldstate/presentation/bloc/solsystem_bloc.dart';
import '../features/worldstate/presentation/pages/acolyte_profile.dart';
import '../features/worldstate/presentation/pages/bounties.dart';
import '../features/worldstate/presentation/pages/event.dart';
import '../features/worldstate/presentation/pages/nightwaves.dart';
import '../features/worldstate/presentation/pages/trader_inventory.dart';
import '../generated/l10n.dart';
import '../injection_container.dart';
import 'home.dart';
import 'services/notifications.dart';
import 'settings/settings.dart';
import 'themes/themes.dart';
import 'widgets/widgets.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({Key key}) : super(key: key);

  @override
  _NavisAppState createState() => _NavisAppState();
}

class _NavisAppState extends State<NavisApp> with WidgetsBindingObserver {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    BlocProvider.of<SolsystemBloc>(context)
        .add(const SyncSystemStatus(GamePlatforms.pc));

    _timer = Timer.periodic(const Duration(minutes: 5), (_) {
      BlocProvider.of<SolsystemBloc>(context)
          .add(const SyncSystemStatus(GamePlatforms.pc));
    });

    sl<NotificationService>().configure();
  }

  Widget _builder(BuildContext context, Widget widget) {
    ErrorWidget.builder = (FlutterErrorDetails error) => NavisErrorWidget(
          details: error,
          showStacktrace: true,
        );

    return widget;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<SolsystemBloc>(context)
          .add(const SyncSystemStatus(GamePlatforms.pc));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navis',
      color: Colors.grey[900],
      themeMode: context.watch<Usersettings>().theme,
      theme: NavisTheming.light,
      darkTheme: NavisTheming.dark,
      home: const Home(),
      builder: _builder,
      routes: <String, WidgetBuilder>{
        EventInformation.route: (_) => const EventInformation(),
        AcolyteProfile.route: (_) => const AcolyteProfile(),
        Settings.route: (_) => const Settings(),
        NightwavesPage.route: (_) => const NightwavesPage(),
        BountiesPage.route: (_) => const BountiesPage(),
        // SynthTargetScreen.route: (_) => const SynthTargetScreen(),
        // CodexEntry.route: (_) => const CodexEntry(),
        BaroInventory.route: (_) => const BaroInventory()
      },
      supportedLocales: NavisLocalizations.delegate.supportedLocales,
      localizationsDelegates: const [
        AppLocalizationDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate
      ],
      localeResolutionCallback:
          (Locale locale, Iterable<Locale> supportedLocales) {
        for (final supportedLocale in supportedLocales) {
          if (locale.languageCode == supportedLocale.languageCode) {
            return supportedLocale;
          }
        }

        return supportedLocales.first;
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
