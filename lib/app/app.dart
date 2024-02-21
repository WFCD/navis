import 'dart:async';

import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/home/home.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/synthtargets/views/targets.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

    context.read<NotificationRepository>().configure();

    _timer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => context
          .read<WorldstateCubit>()
          .fetchWorldstate(context.locale, forceUpdate: true),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _timer = Timer.periodic(
          const Duration(seconds: 60),
          (_) => context
              .read<WorldstateCubit>()
              .fetchWorldstate(context.locale, forceUpdate: true),
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
    const defaultLocale = Locale('en');
    Locale? newLocale;

    for (final supportedLocale in supportedLocales) {
      if (locale?.languageCode == supportedLocale.languageCode) {
        newLocale = supportedLocale;
      }
    }

    newLocale ??= defaultLocale;

    final userSettingsCubit = context.read<UserSettingsCubit>();
    final settings = userSettingsCubit.state;
    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => defaultLocale
    };

    if (language != newLocale) {
      userSettingsCubit.updateLanguage(newLocale);
    }

    return newLocale;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final settings = context.read<UserSettingsCubit>().state;
    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => const Locale('en')
    };

    BlocProvider.of<WorldstateCubit>(context)
        .fetchWorldstate(language, forceUpdate: true);
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<UserSettingsCubit>().state;

    final themeMode = switch (settings) {
      UserSettingsSuccess() => settings.themeMode,
      _ => ThemeMode.system
    };

    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => const Locale('en')
    };

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return BetterFeedback(
          pixelRatio: 1,
          localizationsDelegates: NavisLocalizations.localizationsDelegates,
          child: MaterialApp(
            title: 'Navis',
            color: Colors.grey[900],
            themeMode: themeMode,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: lightDynamic ?? lightColorScheme,
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: darkDynamic ?? darkColorScheme,
            ),
            home: const HomeView(),
            builder: _builder,
            navigatorObservers: [SentryNavigatorObserver()],
            routes: <String, WidgetBuilder>{
              EventInformation.route: (_) => const EventInformation(),
              SettingsPage.route: (_) => const SettingsPage(),
              NightwavesPage.route: (_) => const NightwavesPage(),
              BountiesPage.route: (_) => const BountiesPage(),
              BaroInventory.route: (_) => const BaroInventory(),
              SynthTargetsView.route: (_) => const SynthTargetsView(),
            },
            supportedLocales: NavisLocalizations.supportedLocales,
            locale: language,
            localizationsDelegates: NavisLocalizations.localizationsDelegates,
            localeResolutionCallback: localeResolutionCallback,
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
