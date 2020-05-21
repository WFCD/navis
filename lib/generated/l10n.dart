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
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return NavisLocalizations();
    });
  } 

  static NavisLocalizations of(BuildContext context) {
    return Localizations.of<NavisLocalizations>(context, NavisLocalizations);
  }

  String levelInfo(Object min, Object max) {
    return Intl.message(
      'Level: $min - $max',
      name: 'levelInfo',
      desc: 'The information of the current enemy levels',
      args: [min, max],
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

  String get codexTitle {
    return Intl.message(
      'Codex',
      name: 'codexTitle',
      desc: 'Codex title',
      args: [],
    );
  }

  String get helpfulLinksTitle {
    return Intl.message(
      'Helpful Links',
      name: 'helpfulLinksTitle',
      desc: 'Helpful Links title',
      args: [],
    );
  }

  String get behaviorTitle {
    return Intl.message(
      'Behavior',
      name: 'behaviorTitle',
      desc: 'Behavior category title',
      args: [],
    );
  }

  String get themeTitle {
    return Intl.message(
      'Theme',
      name: 'themeTitle',
      desc: 'Theme title',
      args: [],
    );
  }

  String get themeDescription {
    return Intl.message(
      'Choose app theme.',
      name: 'themeDescription',
      desc: 'Theme option description',
      args: [],
    );
  }

  String get backOpensDrawerTitle {
    return Intl.message(
      'Back button opens drawer',
      name: 'backOpensDrawerTitle',
      desc: 'Title for the option that allows back button to open the drawer',
      args: [],
    );
  }

  String get backOpensDrawerDescription {
    return Intl.message(
      'Pressing the back button opens the drawer.',
      name: 'backOpensDrawerDescription',
      desc: 'Description for back button opens drawer option',
      args: [],
    );
  }

  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: 'Notifications category title',
      args: [],
    );
  }

  String get rareAlertsNotificationTitle {
    return Intl.message(
      'Rare Alerts',
      name: 'rareAlertsNotificationTitle',
      desc: 'Rare Alerts title',
      args: [],
    );
  }

  String get rareAlertsNotificationDescription {
    return Intl.message(
      'Rare alert notifications, mainly gifts of the lotus.',
      name: 'rareAlertsNotificationDescription',
      desc: 'Description for rare alerts option',
      args: [],
    );
  }

  String get baroNotificationTitle {
    return Intl.message(
      'Baro Ki\'Teer',
      name: 'baroNotificationTitle',
      desc: 'Baro\'s notification title',
      args: [],
    );
  }

  String get baroNotificationDescription {
    return Intl.message(
      'Notifications for both Baro\'s arrivial and departure.',
      name: 'baroNotificationDescription',
      desc: 'Notification description for both Baro\'s arrivial and departure.',
      args: [],
    );
  }

  String get darvoNotificationTitle {
    return Intl.message(
      'Darvo\'s Daily Deals',
      name: 'darvoNotificationTitle',
      desc: 'Notification title for darvo\'s daily deals',
      args: [],
    );
  }

  String get darvoNotificationDescription {
    return Intl.message(
      'Darvo\'s new find of the day.',
      name: 'darvoNotificationDescription',
      desc: 'Notification description for Darvo\'s Daily Deal',
      args: [],
    );
  }

  String get sortieNotificationTitle {
    return Intl.message(
      'Sortie',
      name: 'sortieNotificationTitle',
      desc: 'Notification title for sorties',
      args: [],
    );
  }

  String get sortieNotificationDescription {
    return Intl.message(
      'Notifications for new sorties.',
      name: 'sortieNotificationDescription',
      desc: 'description for sortie notification option',
      args: [],
    );
  }

  String get sentientOutpostNotificationTitle {
    return Intl.message(
      'Sentient Outpost',
      name: 'sentientOutpostNotificationTitle',
      desc: 'Notification title for sentient outpost',
      args: [],
    );
  }

  String get sentientOutpostNotificationDescription {
    return Intl.message(
      'Notifications for new sentient threats',
      name: 'sentientOutpostNotificationDescription',
      desc: 'Notification description for sentient outpost option',
      args: [],
    );
  }

  String get warframeNewsNotificationTitle {
    return Intl.message(
      'News',
      name: 'warframeNewsNotificationTitle',
      desc: 'Main Title for Warframe news notifications',
      args: [],
    );
  }

  String get warframeNewsNotificationDescription {
    return Intl.message(
      'News notifications for Prime Access, Streams and Updates.',
      name: 'warframeNewsNotificationDescription',
      desc: 'Main description for Warframe news notifications',
      args: [],
    );
  }

  String get planetCyclesNotificationTitle {
    return Intl.message(
      'Open World Cycles',
      name: 'planetCyclesNotificationTitle',
      desc: '',
      args: [],
    );
  }

  String get planetCyclesNotificationDescription {
    return Intl.message(
      'Open world notifications for their given cycles.',
      name: 'planetCyclesNotificationDescription',
      desc: '',
      args: [],
    );
  }

  String get resourcesNotificationTitle {
    return Intl.message(
      'Resources',
      name: 'resourcesNotificationTitle',
      desc: 'Main title for resource notifications',
      args: [],
    );
  }

  String get resourcesNotificationDescription {
    return Intl.message(
      'Resources mostly found in invasions.',
      name: 'resourcesNotificationDescription',
      desc: 'Main description for resource notifications',
      args: [],
    );
  }

  String get fissuresNotificationTitle {
    return Intl.message(
      'Fissure Missions',
      name: 'fissuresNotificationTitle',
      desc: 'Main title for fisssures notifications',
      args: [],
    );
  }

  String get fissuresNotificationDescription {
    return Intl.message(
      'Filter fissure notifications by prefered mission type',
      name: 'fissuresNotificationDescription',
      desc: 'Main description for fissures notifications',
      args: [],
    );
  }

  String get acolytesNotificationTitle {
    return Intl.message(
      'Acolytes',
      name: 'acolytesNotificationTitle',
      desc: 'Main title for acolyte notifications',
      args: [],
    );
  }

  String get acolytesNotificationDescription {
    return Intl.message(
      'Notifies when an acolyte is found',
      name: 'acolytesNotificationDescription',
      desc: 'Main description for acolyte notifications',
      args: [],
    );
  }

  String get earthDayOption {
    return Intl.message(
      'Earth Day',
      name: 'earthDayOption',
      desc: 'Earth cycle option',
      args: [],
    );
  }

  String get earthNightOption {
    return Intl.message(
      'Earth Night',
      name: 'earthNightOption',
      desc: 'Earth cycle option',
      args: [],
    );
  }

  String get cetusDayOption {
    return Intl.message(
      'Cetus Day',
      name: 'cetusDayOption',
      desc: 'Cetus cycle option',
      args: [],
    );
  }

  String get cetusNightOption {
    return Intl.message(
      'Cetus Day',
      name: 'cetusNightOption',
      desc: 'Cetus cycle option',
      args: [],
    );
  }

  String get vallisWarmOption {
    return Intl.message(
      'Orb Vallis Warm',
      name: 'vallisWarmOption',
      desc: 'Orb vallis cycle option',
      args: [],
    );
  }

  String get vallisColdOption {
    return Intl.message(
      'Orb Vallis Cold',
      name: 'vallisColdOption',
      desc: 'Orb vallis cycle option',
      args: [],
    );
  }

  String get primeAccessNewsOption {
    return Intl.message(
      'Prime Access',
      name: 'primeAccessNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  String get streamNewsOption {
    return Intl.message(
      'Stream Announcements',
      name: 'streamNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  String get updateNewsOption {
    return Intl.message(
      'Warframe Update News',
      name: 'updateNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  String get updateDropTableTitle {
    return Intl.message(
      'Update Drop Table',
      name: 'updateDropTableTitle',
      desc: 'Title for updaing drop tables',
      args: [],
    );
  }

  String updateDropTableDescription(Object date) {
    return Intl.message(
      'Last updated $date',
      name: 'updateDropTableDescription',
      desc: 'Description for updating drop table with date of the last update',
      args: [date],
    );
  }

  String get reportBugsTitle {
    return Intl.message(
      'Report Bugs',
      name: 'reportBugsTitle',
      desc: '',
      args: [],
    );
  }

  String get reportBugsDescription {
    return Intl.message(
      'Report bugs or Request a feature',
      name: 'reportBugsDescription',
      desc: 'Description for bug report link',
      args: [],
    );
  }

  String get aboutCategoryTitle {
    return Intl.message(
      'About',
      name: 'aboutCategoryTitle',
      desc: 'Title for the about category of the settings page',
      args: [],
    );
  }

  String get dailyRewardTitle {
    return Intl.message(
      'Daily Reward Reset Timer',
      name: 'dailyRewardTitle',
      desc: 'Title for daily reward timer',
      args: [],
    );
  }

  String get eliteBadgeTitle {
    return Intl.message(
      'Elite',
      name: 'eliteBadgeTitle',
      desc: 'Nightwave Elite badge title',
      args: [],
    );
  }

  String get dailyNightwaveTitle {
    return Intl.message(
      'Daily',
      name: 'dailyNightwaveTitle',
      desc: 'Nightwave daily title',
      args: [],
    );
  }

  String get weeklyNightwaveTitle {
    return Intl.message(
      'Weekly',
      name: 'weeklyNightwaveTitle',
      desc: 'Nightwave weekly title',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<NavisLocalizations> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'ko'),
      Locale.fromSubtags(languageCode: 'pl'),
      Locale.fromSubtags(languageCode: 'pt'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
      Locale.fromSubtags(languageCode: 'zh'),
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
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}