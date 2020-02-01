import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../injection_container.dart';
import 'bloc/navigation_bloc.dart';
import 'home.dart';
import 'localizations.dart';
import 'themes/themes.dart';

class NavisApp extends StatelessWidget {
  const NavisApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navis',
      color: Colors.grey[900],
      theme: NavisTheming.dark,
      darkTheme: NavisTheming.dark,
      home: BlocProvider(
        create: (_) => sl<NavigationBloc>(),
        child: const Home(),
      ),
      // builder: _builder,
      routes: <String, WidgetBuilder>{
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
