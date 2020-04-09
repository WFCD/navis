// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class NavisLocalizations {
  NavisLocalizations();
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<NavisLocalizations> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return NavisLocalizations();
    });
  } 

  static NavisLocalizations of(BuildContext context) {
    return Localizations.of<NavisLocalizations>(context, NavisLocalizations);
  }

  String alertInfo(Object type, Object faction, Object min, Object max) {
    return Intl.message(
      '$type ($faction) | Level: $min - $max',
      name: 'alertInfo',
      desc: 'The information of the given alert, such as mission type, faction and enemy level',
      args: [type, faction, min, max],
    );
  }

  String activeAcolyte(Object agentType, Object rank) {
    return Intl.message(
      '$agentType | level: $rank',
      name: 'activeAcolyte',
      desc: 'acolyte title with level',
      args: [agentType, rank],
    );
  }

  String get locating {
    return Intl.message(
      'Locating...',
      name: 'locating',
      desc: 'Shows up when an acolyte\'s current location is unknown, may be used in other parts of the app',
      args: [],
    );
  }

  String get acolyteCurrentLocation {
    return Intl.message(
      'Current location',
      name: 'acolyteCurrentLocation',
      desc: 'Acolyte\'s current location',
      args: [],
    );
  }

  String get acolytePassLocation {
    return Intl.message(
      'Last seen location',
      name: 'acolytePassLocation',
      desc: 'Acolyte\'s pass location',
      args: [],
    );
  }

  String get acolyteFound {
    return Intl.message(
      'Found',
      name: 'acolyteFound',
      desc: 'The elapsed time after an acolyte was found',
      args: [],
    );
  }

  String get acolyteLastSeen {
    return Intl.message(
      'Last seen',
      name: 'acolyteLastSeen',
      desc: 'The elapsed time since the acolyte was last seen',
      args: [],
    );
  }

  String get acolyteHealth {
    return Intl.message(
      'Health',
      name: 'acolyteHealth',
      desc: 'Acolytes remaining health',
      args: [],
    );
  }

  String get acolyteRank {
    return Intl.message(
      'Acolyte Level',
      name: 'acolyteRank',
      desc: 'An acolyte\'s current level',
      args: [],
    );
  }

  String acolyteElapsedTime(Object lastSeenTime) {
    return Intl.message(
      '$lastSeenTime minutes ago',
      name: 'acolyteElapsedTime',
      desc: 'Time since acolyte has either been found or last seen',
      args: [lastSeenTime],
    );
  }

  String get tapForMoreDetails {
    return Intl.message(
      'Tap for more details',
      name: 'tapForMoreDetails',
      desc: 'General description to tell the user that this object takes you to a different page',
      args: [],
    );
  }

  String get seeDetails {
    return Intl.message(
      'See details',
      name: 'seeDetails',
      desc: 'General button to see more details of given object',
      args: [],
    );
  }

  String get eventDescription {
    return Intl.message(
      'Description',
      name: 'eventDescription',
      desc: 'Event description category title',
      args: [],
    );
  }

  String get eventStatus {
    return Intl.message(
      'Event Status',
      name: 'eventStatus',
      desc: 'Event status category title',
      args: [],
    );
  }

  String get eventStatusNode {
    return Intl.message(
      'Node',
      name: 'eventStatusNode',
      desc: 'The node that the event is taking place in',
      args: [],
    );
  }

  String get eventStatusProgress {
    return Intl.message(
      'Progress',
      name: 'eventStatusProgress',
      desc: 'The progress of the current event from 0 to 100 %',
      args: [],
    );
  }

  String get eventStatusEta {
    return Intl.message(
      'Time left (ETA)',
      name: 'eventStatusEta',
      desc: 'Current events remaining estimated time',
      args: [],
    );
  }

  String get eventRewards {
    return Intl.message(
      'Rewards',
      name: 'eventRewards',
      desc: 'Event reward title',
      args: [],
    );
  }

  String get bountyTitle {
    return Intl.message(
      'Bounties',
      name: 'bountyTitle',
      desc: 'Bounty card title.',
      args: [],
    );
  }

  String get errorTitle {
    return Intl.message(
      'An application error has occurred',
      name: 'errorTitle',
      desc: 'error title',
      args: [],
    );
  }

  String get errorDescription {
    return Intl.message(
      'There was unexpected error in core system.\nReporting error to system admin...',
      name: 'errorDescription',
      desc: 'error description',
      args: [],
    );
  }

  String get baroTitle {
    return Intl.message(
      'Void trader',
      name: 'baroTitle',
      desc: 'Title for Baro Ki\'Teer card',
      args: [],
    );
  }

  String get baroLeaving {
    return Intl.message(
      'Baro Ki\'Teer leaves in',
      name: 'baroLeaving',
      desc: 'displays remaining time before Baro Ki\'Teer leaves',
      args: [],
    );
  }

  String get baroArriving {
    return Intl.message(
      'Baro Ki\'Teer arrives in',
      name: 'baroArriving',
      desc: 'displays remaining time before Baro Ki\'Teer arrives',
      args: [],
    );
  }

  String get baroLocation {
    return Intl.message(
      'Location',
      name: 'baroLocation',
      desc: 'shows Baro ki\'Teer\'s current location',
      args: [],
    );
  }

  String get baroLeavesOn {
    return Intl.message(
      'Leaves on',
      name: 'baroLeavesOn',
      desc: 'shows when Baro Ki\'Teer is leaving',
      args: [],
    );
  }

  String get baroArrivesOn {
    return Intl.message(
      'Arrives on',
      name: 'baroArrivesOn',
      desc: 'shows at when Baro Ki\'Teer will arrive',
      args: [],
    );
  }

  String get baroInventory {
    return Intl.message(
      'Baro Ki\'Teeer Inventory',
      name: 'baroInventory',
      desc: 'Baro Ki\'Teeer Inventory button label',
      args: [],
    );
  }

  String countdownTooltip(Object date) {
    return Intl.message(
      'Ends on $date',
      name: 'countdownTooltip',
      desc: 'Countdown tooltip with end date of the current running timer',
      args: [date],
    );
  }

  String get kuvaBanner {
    return Intl.message(
      'Kuva will refresh in',
      name: 'kuvaBanner',
      desc: 'Kuva refresh countdown title',
      args: [],
    );
  }

  String get formorianTitle {
    return Intl.message(
      'Fomorian',
      name: 'formorianTitle',
      desc: 'Fomorian progress title',
      args: [],
    );
  }

  String get razorbackTitle {
    return Intl.message(
      'Razorback',
      name: 'razorbackTitle',
      desc: 'Razorback progress title',
      args: [],
    );
  }

  String get earthCycleTitle {
    return Intl.message(
      'Earth Cycle',
      name: 'earthCycleTitle',
      desc: 'Earth cycle title',
      args: [],
    );
  }

  String get cetusCycleTitle {
    return Intl.message(
      'Cetus Cycle',
      name: 'cetusCycleTitle',
      desc: 'Cetus cycle title',
      args: [],
    );
  }

  String get vallisCycleTitle {
    return Intl.message(
      'Vallis Cycle',
      name: 'vallisCycleTitle',
      desc: 'Vallis cycle title',
      args: [],
    );
  }

  String get timersTitle {
    return Intl.message(
      'Timers',
      name: 'timersTitle',
      desc: 'Times title',
      args: [],
    );
  }

  String get fissuresTitle {
    return Intl.message(
      'Fissures',
      name: 'fissuresTitle',
      desc: 'Fissures title',
      args: [],
    );
  }

  String get invasionsTitle {
    return Intl.message(
      'Invasions',
      name: 'invasionsTitle',
      desc: 'Invasions title',
      args: [],
    );
  }

  String get syndicatesTitle {
    return Intl.message(
      'Syndicates',
      name: 'syndicatesTitle',
      desc: 'Syndicates title',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<NavisLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'), Locale.fromSubtags(languageCode: 'de'), Locale.fromSubtags(languageCode: 'es'), Locale.fromSubtags(languageCode: 'fr'), Locale.fromSubtags(languageCode: 'it'), Locale.fromSubtags(languageCode: 'ko'), Locale.fromSubtags(languageCode: 'pl'), Locale.fromSubtags(languageCode: 'pt'), Locale.fromSubtags(languageCode: 'ru'), Locale.fromSubtags(languageCode: 'tr'), Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<NavisLocalizations> load(Locale locale) => NavisLocalizations.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}