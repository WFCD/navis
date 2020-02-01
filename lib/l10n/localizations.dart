import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/messages_all.dart';

class NavisLocalizations {
  static NavisLocalizations current;

  final String localeName;

  NavisLocalizations._(this.localeName) {
    current = this;
  }

  static Future<NavisLocalizations> load(Locale locale) {
    final name = locale.countryCode == null || locale.countryCode.isEmpty
        ? locale.languageCode
        : locale.toString();

    final localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return NavisLocalizations._(localeName);
    });
  }

  static NavisLocalizations of(BuildContext context) {
    return Localizations.of<NavisLocalizations>(context, NavisLocalizations);
  }

  // Error widget
  String get errorTitle {
    return Intl.message(
      'An application error has occurred',
      name: 'errorTitle',
      desc: 'error title',
      locale: localeName,
    );
  }

  String get errorDescription {
    return Intl.message(
      'There was unexpected error in core system.\n'
      'Reporting error to system admin...',
      name: 'errorDescription',
      desc: 'error description',
      locale: localeName,
    );
  }

  // Baro Ki'Teer related locales
  String get baroLeaving {
    return Intl.message(
      'Baro Ki\'Teer leaves in',
      name: 'baroLeaving',
      desc: 'displays remaining time before Baro Ki\'Teer leaves',
      locale: localeName,
    );
  }

  String get baroLocation {
    return Intl.message(
      'Location',
      name: 'baroLocation',
      desc: 'shows Baro ki\'Teer\'s current location',
      locale: localeName,
    );
  }

  String get baroLeavesOn {
    return Intl.message(
      'Leaves on',
      name: 'baroLeavesOn',
      desc: 'shows when Baro Ki\'Teer is leaving',
      locale: localeName,
    );
  }

  String get baroArrivesOn {
    return Intl.message(
      'Arrives on',
      name: 'baroArrivesOn',
      desc: 'shows at when Baro Ki\'Teer will arrive',
      locale: localeName,
    );
  }

  String get baroInventory {
    return Intl.message(
      'Baro Ki\'Teeer Inventory',
      name: 'baroInventory',
      desc: 'Baro Ki\'Teeer Inventory button label',
      locale: localeName,
    );
  }
}

class NavisLocalizationsDelegate
    extends LocalizationsDelegate<NavisLocalizations> {
  @override
  bool isSupported(Locale locale) => ['en', 'es'].contains(locale.languageCode);

  @override
  Future<NavisLocalizations> load(Locale locale) {
    return NavisLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<NavisLocalizations> old) => false;
}
