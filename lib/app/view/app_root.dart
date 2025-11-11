import 'package:dynamic_system_colors/dynamic_system_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/l10n/l10n.dart';
import 'package:navis/router/app_router.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis_ui/navis_ui.dart';

class NavisApp extends StatelessWidget {
  const NavisApp({super.key, required this.router});

  final AppRouter router;

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

  Locale localeResolutionCallback(BuildContext context, Locale? locale, Iterable<Locale> supportedLocales) {
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
              localeResolutionCallback(context, locale, supportedLocales),
        );
      },
    );
  }
}
