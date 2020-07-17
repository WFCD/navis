import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:navis/blocs/worldstate/worldstate_events.dart';
import 'package:navis/constants/storage_keys.dart';
import 'package:navis/generated/l10n.dart';
import 'package:navis/screens/codex_entry.dart';
import 'package:navis/screens/nightwaves.dart';
import 'package:navis/screens/scaffold.dart';
import 'package:navis/screens/settings.dart';
import 'package:navis/screens/syndicate_bounties.dart';
import 'package:navis/screens/synth_targets.dart';
import 'package:navis/screens/trader_inventory.dart';
import 'package:navis/services/repository.dart';
import 'package:navis/themes.dart';
import 'package:navis/utils/size_config.dart';
import 'package:navis/widgets/widgets.dart';
import 'package:wfcd_client/wfcd_client.dart';

class Navis extends StatefulWidget {
  const Navis(this.repository);

  final Repository repository;

  @override
  _NavisState createState() => _NavisState();
}

class _NavisState extends State<Navis> with WidgetsBindingObserver {
  Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    BlocProvider.of<WorldstateBloc>(context).add(UpdateEvent());

    if (widget.repository.persistent.platform == null) {
      widget.repository.notifications
          .subscribeToPlatform(currentPlatform: GamePlatforms.pc);
    }

    _timer = Timer.periodic(const Duration(minutes: 5), (t) {
      BlocProvider.of<WorldstateBloc>(context).add(UpdateEvent());
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      BlocProvider.of<WorldstateBloc>(context).add(UpdateEvent());
    }
  }

  Widget _builder(BuildContext context, Widget widget) {
    ErrorWidget.builder =
        (FlutterErrorDetails error) => NavisErrorWidget(details: error);
    return widget;
  }

  ThemeMode _detectMode(ThemeData current) {
    switch (current?.brightness) {
      case Brightness.light:
        return ThemeMode.light;
      case Brightness.dark:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  Widget build(BuildContext context) {
    final repository = widget.repository;

    return RepositoryProvider.value(
      value: repository,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return OrientationBuilder(
            builder: (BuildContext context, Orientation orientation) {
              SizeConfig().init(constraints, orientation);

              return WatchBoxBuilder(
                box: repository.persistent.hiveBox,
                watchKeys: const [SettingsKeys.theme],
                builder: (BuildContext context, Box box) {
                  return MaterialApp(
                    title: 'Navis',
                    color: Colors.grey[900],
                    themeMode: _detectMode(widget.repository.persistent.theme),
                    theme: NavisThemes.light,
                    darkTheme: NavisThemes.dark,
                    home: const MainScreen(),
                    builder: _builder,
                    routes: <String, WidgetBuilder>{
                      Settings.route: (_) => const Settings(),
                      Nightwaves.route: (_) => const Nightwaves(),
                      SyndicateJobs.route: (_) => const SyndicateJobs(),
                      SynthTargetScreen.route: (_) => const SynthTargetScreen(),
                      CodexEntry.route: (_) => const CodexEntry(),
                      VoidTraderInventory.route: (_) =>
                          const VoidTraderInventory()
                    },
                    supportedLocales:
                        NavisLocalizations.delegate.supportedLocales,
                    localizationsDelegates: const [
                      AppLocalizationDelegate(),
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                    ],
                    localeResolutionCallback:
                        (Locale locale, Iterable<Locale> supportedLocales) {
                      for (final supportedLocale in supportedLocales) {
                        if (locale.languageCode ==
                            supportedLocale.languageCode) {
                          return supportedLocale;
                        }
                      }

                      return supportedLocales.first;
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    RepositoryProvider.of<Repository>(context).persistent.closeBoxInstance();
    RepositoryProvider.of<Repository>(context).cache.closeBoxInstance();
    super.dispose();
  }
}
