import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/bloc/app_config_bloc.dart';
import 'package:navis_ui/navis_ui.dart';

class NavisApp extends StatelessWidget {
  const NavisApp({super.key, required this.router});

  final AppRouter router;

  Widget _builder(BuildContext context, Widget? widget) {
    final l10n = NavisLocalizations.of(context);

    ErrorWidget.builder = (error) {
      Widget errorWidget = NavisErrorWidget(title: l10n.errorTitle, description: l10n.errorDescription, details: error);

      if (widget is Scaffold || widget is Navigator) {
        errorWidget = Scaffold(body: Center(child: errorWidget));
      }

      return errorWidget;
    };

    if (widget != null) return widget;

    throw Exception('Widget is null');
  }

  Locale _localeResolutionCallback(BuildContext context, Locale? locale, Iterable<Locale> supportedLocales) {
    const defaultLocale = Locale('en');
    Locale? newLocale;

    for (final supportedLocale in supportedLocales) {
      if (locale?.languageCode == supportedLocale.languageCode) {
        newLocale = supportedLocale;
      }
    }

    newLocale ??= defaultLocale;

    final appConfig = context.read<AppConfigBloc>();
    final language = switch (appConfig.state) {
      AppConfigUpdated(:final config) => Locale(config.language),
      _ => defaultLocale,
    };

    if (language != newLocale) {
      appConfig.add(AppConfigUpdate(language: newLocale.languageCode));
    }

    return newLocale;
  }

  bool _buildWhen(AppConfigState previous, AppConfigState next) {
    const defaultThemeMode = ThemeMode.system;
    const defaultLocale = Locale('en');

    final previousThemeMode = switch (previous) {
      AppConfigUpdated(:final config) => ThemeMode.values[config.theme],
      _ => defaultThemeMode,
    };

    final previousLanguage = switch (previous) {
      AppConfigUpdated(:final config) => Locale(config.language),
      _ => defaultLocale,
    };

    final nextThemeMode = switch (next) {
      AppConfigUpdated(:final config) => ThemeMode.values[config.theme],
      _ => defaultThemeMode,
    };

    final nextLanguage = switch (next) {
      AppConfigUpdated(:final config) => Locale(config.language),
      _ => defaultLocale,
    };

    return previousThemeMode != nextThemeMode || previousLanguage != nextLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return BlocBuilder<AppConfigBloc, AppConfigState>(
          buildWhen: _buildWhen,
          builder: (context, state) {
            final themeMode = switch (state) {
              AppConfigUpdated(:final config) => ThemeMode.values[config.theme],
              _ => null,
            };

            final language = switch (state) {
              AppConfigUpdated(:final config) => Locale(config.language),
              _ => null,
            };

            return MaterialApp.router(
              routerConfig: router.routes,
              title: 'Cephalon Navis',
              color: Colors.grey[900],
              themeMode: themeMode,
              debugShowCheckedModeBanner: false,
              theme: NavisThemes.theme(Brightness.light, lightDynamic),
              darkTheme: NavisThemes.theme(Brightness.dark, darkDynamic),
              builder: _builder,
              supportedLocales: NavisLocalizations.supportedLocales,
              locale: language,
              localizationsDelegates: NavisLocalizations.localizationsDelegates,
              localeResolutionCallback: (locale, supportedLocales) =>
                  _localeResolutionCallback(context, locale, supportedLocales),
            );
          },
        );
      },
    );
  }
}
