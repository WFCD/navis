import 'dart:async';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:feedback_sentry/feedback_sentry.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/worldstate.dart';
import 'package:navis_ui/navis_ui.dart';

class NavisApp extends StatefulWidget {
  const NavisApp({super.key, required this.router});

  final AppRouter router;

  @override
  NavisAppState createState() => NavisAppState();
}

class NavisAppState extends State<NavisApp> with WidgetsBindingObserver {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _timer = Timer.periodic(
      const Duration(seconds: 60),
      (_) => BlocProvider.of<WorldstateCubit>(context).fetchWorldstate(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _timer = Timer.periodic(
          const Duration(seconds: 60),
          (_) => BlocProvider.of<WorldstateCubit>(context).fetchWorldstate(),
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
      Widget errorWidget = NavisErrorWidget(title: l10n.errorTitle, description: l10n.errorDescription, details: error);

      if (widget is Scaffold || widget is Navigator) {
        errorWidget = Scaffold(body: Center(child: errorWidget));
      }

      return errorWidget;
    };

    if (widget != null) return widget;

    throw Exception('Widget is null');
  }

  Locale localeResolutionCallback(Locale? locale, Iterable<Locale> supportedLocales) {
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
      _ => defaultLocale,
    };

    if (language != newLocale) {
      userSettingsCubit.updateLanguage(newLocale);
    }
    context.read<UserSettingsCubit>().updateLanguage(newLocale);

    return newLocale;
  }

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<UserSettingsCubit>().state;

    final themeMode = switch (settings) {
      UserSettingsSuccess() => settings.themeMode,
      _ => ThemeMode.system,
    };

    final language = switch (settings) {
      UserSettingsSuccess() => settings.language,
      _ => const Locale('en'),
    };

    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return BetterFeedback(
          pixelRatio: 1,
          localizationsDelegates: NavisLocalizations.localizationsDelegates,
          child: MaterialApp.router(
            routerConfig: widget.router.routes,
            title: 'Navis',
            color: Colors.grey[900],
            themeMode: themeMode,
            theme: NavisThemes.theme(Brightness.light, lightDynamic),
            darkTheme: NavisThemes.theme(Brightness.dark, darkDynamic),
            builder: _builder,
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
