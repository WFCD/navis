import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:navis/l10n/messages_all.dart';

// I'm adding this as I reimplement everything and is subject to change.
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

  // Alert
  String alertInfo(String type, String faction, int min, int max) {
    return Intl.message(
      '${type} (${faction}) | Level: ${min} - ${max}',
      name: 'alertInfo',
      desc: 'The information of the given alert, '
          'such as mission type, faction and enemy level',
      args: [type, faction, min, max],
      locale: localeName,
    );
  }

  // Acolyte card
  String activeAcolyte(String agentType, int rank) {
    return Intl.message(
      '${agentType} | level: ${rank}',
      name: 'activeAcolyte',
      desc: 'acolyte title with level',
      args: [agentType, rank],
      locale: localeName,
    );
  }

  String get locating {
    return Intl.message(
      'Locating...',
      name: 'locating',
      desc: 'Shows up when an acolyte\'s current location '
          'is unknown, may be used in other parts of the app',
      locale: localeName,
    );
  }

  String get acolyteCurrentLocation {
    return Intl.message(
      'Current location',
      name: 'acolyteCurrentLocation',
      desc: 'Acolyte\'s current location',
      locale: localeName,
    );
  }

  String get acolytePassLocation {
    return Intl.message(
      'Last seen location',
      name: 'acolytePassLocation',
      desc: 'Acolyte\'s pass location',
      locale: localeName,
    );
  }

  String get acolyteFound {
    return Intl.message(
      'Found',
      name: 'acolyteFound',
      desc: 'The elapsed time after an acolyte was found',
      locale: localeName,
    );
  }

  String get acolyteLastSeen {
    return Intl.message(
      'Last seen',
      name: 'acolyteLastSeen',
      desc: 'The elapsed time since the acolyte was last seen',
      locale: localeName,
    );
  }

  String get acolyteHealth {
    return Intl.message(
      'Health',
      name: 'acolyteHealth',
      desc: 'Acolytes remaining health',
      locale: localeName,
    );
  }

  String get acolyteRank {
    return Intl.message(
      'Acolyte Level',
      name: 'acolyteRank',
      desc: 'An acolyte\'s current level',
      locale: localeName,
    );
  }

  String acolyteElapsedTime(int lastSeenTime) {
    return Intl.message(
      '$lastSeenTime minutes ago',
      name: 'acolyteElapsedTime',
      desc: 'Time since acolyte has either been found or last seen',
      args: [lastSeenTime],
      locale: localeName,
    );
  }

  String get tapForMoreDetails {
    return Intl.message(
      'Tap for more details',
      name: 'tapForMoreDetails',
      desc: 'General description to tell the user that this object '
          'takes you to a different page',
      locale: localeName,
    );
  }

  // Event page
  String get seeDetails {
    return Intl.message(
      'See details',
      name: 'seeDetails',
      desc: 'General button to see more details of given object',
      locale: localeName,
    );
  }

  String get eventDescription {
    return Intl.message(
      'Description',
      name: 'eventDescription',
      desc: 'Event description category title',
      locale: localeName,
    );
  }

  String get eventStatus {
    return Intl.message(
      'Event Status',
      name: 'eventStatus',
      desc: 'Event status category title',
      locale: localeName,
    );
  }

  String get eventStatusNode {
    return Intl.message(
      'Node',
      name: 'eventStatusNode',
      desc: 'The node that the event is taking place in',
      locale: localeName,
    );
  }

  String get eventStatusProgress {
    return Intl.message(
      'Progress',
      name: 'eventStatusProgress',
      desc: 'The progress of the current event from 0 to 100 %',
      locale: localeName,
    );
  }

  String get eventStatusEta {
    return Intl.message(
      'Time left (ETA)',
      name: 'eventStatusEta',
      desc: 'Current events remaining estimated time',
      locale: localeName,
    );
  }

  String get eventRewards {
    return Intl.message(
      'Rewards',
      name: 'eventRewards',
      desc: 'Event reward title',
      locale: localeName,
    );
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
  String get baroTitle {
    return Intl.message(
      'Void trader',
      name: 'baroTitle',
      desc: 'Title for Baro Ki\'Teer card',
      locale: localeName,
    );
  }

  String get baroLeaving {
    return Intl.message(
      'Baro Ki\'Teer leaves in',
      name: 'baroLeaving',
      desc: 'displays remaining time before Baro Ki\'Teer leaves',
      locale: localeName,
    );
  }

  String get baroArriving {
    return Intl.message(
      'Baro Ki\'Teer arrives in',
      name: 'baroArriving',
      desc: 'displays remaining time before Baro Ki\'Teer arrives',
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

  // Countdown tooltip
  String countdownTooltip(String date) {
    return Intl.message(
      'Ends on $date',
      name: 'countdownTooltip',
      args: [date],
      desc: 'Countdown tooltip with end date of the current running timer',
      locale: localeName,
    );
  }
}

class NavisLocalizationsDelegate
    extends LocalizationsDelegate<NavisLocalizations> {
  @override
  bool isSupported(Locale locale) {
    return ['de', 'en', 'es', 'fr', 'it', 'ko', 'pl', 'pt', 'ru', 'tr', 'zh']
        .contains(locale.languageCode);
  }

  @override
  Future<NavisLocalizations> load(Locale locale) {
    return NavisLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<NavisLocalizations> old) => false;
}
