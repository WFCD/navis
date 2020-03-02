import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/pages/acolyte_profile.dart';
import 'package:navis/features/worldstate/presentation/pages/event.dart';
import 'package:navis/features/worldstate/presentation/pages/trader_inventory.dart';
import 'package:navis/l10n/localizations.dart';

import 'home.dart';
import 'themes/themes.dart';

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
      theme: NavisTheming.dark,
      darkTheme: NavisTheming.dark,
      home: const Home(),
      builder: _builder,
      routes: <String, WidgetBuilder>{
        EventInformation.route: (_) => const EventInformation(),
        AcolyteProfile.route: (_) => const AcolyteProfile(),
        // Settings.route: (_) => const Settings(),
        // Nightwaves.route: (_) => const Nightwaves(),
        // SyndicateJobs.route: (_) => const SyndicateJobs(),
        // SynthTargetScreen.route: (_) => const SynthTargetScreen(),
        // CodexEntry.route: (_) => const CodexEntry(),
        BaroInventory.route: (_) => const BaroInventory()
      },
      supportedLocales: supportedLocales.map((locale) => Locale(locale)),
      localizationsDelegates: [
        NavisLocalizationsDelegate(),
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
