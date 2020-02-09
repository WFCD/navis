import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:navis/core/widgets/widgets.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:navis/features/worldstate/presentation/pages/event.dart';
import 'package:navis/l10n/localizations.dart';

import 'home.dart';
import 'themes/themes.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({Key key}) : super(key: key);

  @override
  _NavisAppState createState() => _NavisAppState();
}

class _NavisAppState extends State<NavisApp> {
  @override
  void initState() {
    super.initState();

    BlocProvider.of<SolsystemBloc>(context)
        .add(const SolupdateSystem(GamePlatforms.pc));
  }

  Widget _builder(BuildContext context, Widget widget) {
    ErrorWidget.builder = (FlutterErrorDetails error) => NavisErrorWidget(
          details: error,
          showStacktrace: true,
        );

    return widget;
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
        EventInformation.route: (_) => const EventInformation()
        // Settings.route: (_) => const Settings(),
        // Nightwaves.route: (_) => const Nightwaves(),
        // SyndicateJobs.route: (_) => const SyndicateJobs(),
        // SynthTargetScreen.route: (_) => const SynthTargetScreen(),
        // CodexEntry.route: (_) => const CodexEntry(),
        // VoidTraderInventory.route: (_) => const VoidTraderInventory()
      },
      supportedLocales: const [Locale('en'), Locale('es')],
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
}
