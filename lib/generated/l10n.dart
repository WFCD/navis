// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars

class NavisLocalizations {
  NavisLocalizations();
  
  static NavisLocalizations current;
  
  static const AppLocalizationDelegate delegate =
    AppLocalizationDelegate();

  static Future<NavisLocalizations> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name); 
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      NavisLocalizations.current = NavisLocalizations();
      
      return NavisLocalizations.current;
    });
  } 

  static NavisLocalizations of(BuildContext context) {
    return Localizations.of<NavisLocalizations>(context, NavisLocalizations);
  }

  /// `Level: {min} - {max}`
  String levelInfo(Object min, Object max) {
    return Intl.message(
      'Level: $min - $max',
      name: 'levelInfo',
      desc: 'The information of the current enemy levels',
      args: [min, max],
    );
  }

  /// `{agentType} | level: {rank}`
  String activeAcolyte(Object agentType, Object rank) {
    return Intl.message(
      '$agentType | level: $rank',
      name: 'activeAcolyte',
      desc: 'acolyte title with level',
      args: [agentType, rank],
    );
  }

  /// `Locating...`
  String get locating {
    return Intl.message(
      'Locating...',
      name: 'locating',
      desc: 'Shows up when an acolyte\'s current location is unknown, may be used in other parts of the app',
      args: [],
    );
  }

  /// `Current location`
  String get acolyteCurrentLocation {
    return Intl.message(
      'Current location',
      name: 'acolyteCurrentLocation',
      desc: 'Acolyte\'s current location',
      args: [],
    );
  }

  /// `Last seen location`
  String get acolytePassLocation {
    return Intl.message(
      'Last seen location',
      name: 'acolytePassLocation',
      desc: 'Acolyte\'s pass location',
      args: [],
    );
  }

  /// `Found`
  String get acolyteFound {
    return Intl.message(
      'Found',
      name: 'acolyteFound',
      desc: 'The elapsed time after an acolyte was found',
      args: [],
    );
  }

  /// `Last seen`
  String get acolyteLastSeen {
    return Intl.message(
      'Last seen',
      name: 'acolyteLastSeen',
      desc: 'The elapsed time since the acolyte was last seen',
      args: [],
    );
  }

  /// `Health`
  String get acolyteHealth {
    return Intl.message(
      'Health',
      name: 'acolyteHealth',
      desc: 'Acolytes remaining health',
      args: [],
    );
  }

  /// `Acolyte Level`
  String get acolyteRank {
    return Intl.message(
      'Acolyte Level',
      name: 'acolyteRank',
      desc: 'An acolyte\'s current level',
      args: [],
    );
  }

  /// `{lastSeenTime} minutes ago`
  String acolyteElapsedTime(Object lastSeenTime) {
    return Intl.message(
      '$lastSeenTime minutes ago',
      name: 'acolyteElapsedTime',
      desc: 'Time since acolyte has either been found or last seen',
      args: [lastSeenTime],
    );
  }

  /// `Tap for more details`
  String get tapForMoreDetails {
    return Intl.message(
      'Tap for more details',
      name: 'tapForMoreDetails',
      desc: 'General description to tell the user that this object takes you to a different page',
      args: [],
    );
  }

  /// `See details`
  String get seeDetails {
    return Intl.message(
      'See details',
      name: 'seeDetails',
      desc: 'General button to see more details of given object',
      args: [],
    );
  }

  /// `Description`
  String get eventDescription {
    return Intl.message(
      'Description',
      name: 'eventDescription',
      desc: 'Event description category title',
      args: [],
    );
  }

  /// `Event Status`
  String get eventStatus {
    return Intl.message(
      'Event Status',
      name: 'eventStatus',
      desc: 'Event status category title',
      args: [],
    );
  }

  /// `Node`
  String get eventStatusNode {
    return Intl.message(
      'Node',
      name: 'eventStatusNode',
      desc: 'The node that the event is taking place in',
      args: [],
    );
  }

  /// `Progress`
  String get eventStatusProgress {
    return Intl.message(
      'Progress',
      name: 'eventStatusProgress',
      desc: 'The progress of the current event from 0 to 100 %',
      args: [],
    );
  }

  /// `Time left (ETA)`
  String get eventStatusEta {
    return Intl.message(
      'Time left (ETA)',
      name: 'eventStatusEta',
      desc: 'Current events remaining estimated time',
      args: [],
    );
  }

  /// `Rewards`
  String get eventRewards {
    return Intl.message(
      'Rewards',
      name: 'eventRewards',
      desc: 'Event reward title',
      args: [],
    );
  }

  /// `Bounties`
  String get bountyTitle {
    return Intl.message(
      'Bounties',
      name: 'bountyTitle',
      desc: 'Bounty card title.',
      args: [],
    );
  }

  /// `An application error has occurred`
  String get errorTitle {
    return Intl.message(
      'An application error has occurred',
      name: 'errorTitle',
      desc: 'error title',
      args: [],
    );
  }

  /// `There was unexpected error in core system.\nReporting error to system admin...`
  String get errorDescription {
    return Intl.message(
      'There was unexpected error in core system.\nReporting error to system admin...',
      name: 'errorDescription',
      desc: 'error description',
      args: [],
    );
  }

  /// `Void trader`
  String get baroTitle {
    return Intl.message(
      'Void trader',
      name: 'baroTitle',
      desc: 'Title for Baro Ki\'Teer card',
      args: [],
    );
  }

  /// `Baro Ki'Teer leaves in`
  String get baroLeaving {
    return Intl.message(
      'Baro Ki\'Teer leaves in',
      name: 'baroLeaving',
      desc: 'displays remaining time before Baro Ki\'Teer leaves',
      args: [],
    );
  }

  /// `Baro Ki'Teer arrives in`
  String get baroArriving {
    return Intl.message(
      'Baro Ki\'Teer arrives in',
      name: 'baroArriving',
      desc: 'displays remaining time before Baro Ki\'Teer arrives',
      args: [],
    );
  }

  /// `Location`
  String get baroLocation {
    return Intl.message(
      'Location',
      name: 'baroLocation',
      desc: 'shows Baro ki\'Teer\'s current location',
      args: [],
    );
  }

  /// `Leaves on`
  String get baroLeavesOn {
    return Intl.message(
      'Leaves on',
      name: 'baroLeavesOn',
      desc: 'shows when Baro Ki\'Teer is leaving',
      args: [],
    );
  }

  /// `Arrives on`
  String get baroArrivesOn {
    return Intl.message(
      'Arrives on',
      name: 'baroArrivesOn',
      desc: 'shows at when Baro Ki\'Teer will arrive',
      args: [],
    );
  }

  /// `Baro Ki'Teeer Inventory`
  String get baroInventory {
    return Intl.message(
      'Baro Ki\'Teeer Inventory',
      name: 'baroInventory',
      desc: 'Baro Ki\'Teeer Inventory button label',
      args: [],
    );
  }

  /// `Ends on {date}`
  String countdownTooltip(Object date) {
    return Intl.message(
      'Ends on $date',
      name: 'countdownTooltip',
      desc: 'Countdown tooltip with end date of the current running timer',
      args: [date],
    );
  }

  /// `Kuva will refresh in`
  String get kuvaBanner {
    return Intl.message(
      'Kuva will refresh in',
      name: 'kuvaBanner',
      desc: 'Kuva refresh countdown title',
      args: [],
    );
  }

  /// `Fomorian`
  String get formorianTitle {
    return Intl.message(
      'Fomorian',
      name: 'formorianTitle',
      desc: 'Fomorian progress title',
      args: [],
    );
  }

  /// `Razorback`
  String get razorbackTitle {
    return Intl.message(
      'Razorback',
      name: 'razorbackTitle',
      desc: 'Razorback progress title',
      args: [],
    );
  }

  /// `Earth Cycle`
  String get earthCycleTitle {
    return Intl.message(
      'Earth Cycle',
      name: 'earthCycleTitle',
      desc: 'Earth cycle title',
      args: [],
    );
  }

  /// `Cetus Cycle`
  String get cetusCycleTitle {
    return Intl.message(
      'Cetus Cycle',
      name: 'cetusCycleTitle',
      desc: 'Cetus cycle title',
      args: [],
    );
  }

  /// `Vallis Cycle`
  String get vallisCycleTitle {
    return Intl.message(
      'Vallis Cycle',
      name: 'vallisCycleTitle',
      desc: 'Vallis cycle title',
      args: [],
    );
  }

  /// `Cambion Cycle`
  String get cambionCycleTitle {
    return Intl.message(
      'Cambion Cycle',
      name: 'cambionCycleTitle',
      desc: 'Cambion Cycle title',
      args: [],
    );
  }

  /// `Timers`
  String get timersTitle {
    return Intl.message(
      'Timers',
      name: 'timersTitle',
      desc: 'Times title',
      args: [],
    );
  }

  /// `Fissures`
  String get fissuresTitle {
    return Intl.message(
      'Fissures',
      name: 'fissuresTitle',
      desc: 'Fissures title',
      args: [],
    );
  }

  /// `Invasions`
  String get invasionsTitle {
    return Intl.message(
      'Invasions',
      name: 'invasionsTitle',
      desc: 'Invasions title',
      args: [],
    );
  }

  /// `Syndicates`
  String get syndicatesTitle {
    return Intl.message(
      'Syndicates',
      name: 'syndicatesTitle',
      desc: 'Syndicates title',
      args: [],
    );
  }

  /// `Codex`
  String get codexTitle {
    return Intl.message(
      'Codex',
      name: 'codexTitle',
      desc: 'Codex title',
      args: [],
    );
  }

  /// `Helpful Links`
  String get helpfulLinksTitle {
    return Intl.message(
      'Helpful Links',
      name: 'helpfulLinksTitle',
      desc: 'Helpful Links title',
      args: [],
    );
  }

  /// `Behavior`
  String get behaviorTitle {
    return Intl.message(
      'Behavior',
      name: 'behaviorTitle',
      desc: 'Behavior category title',
      args: [],
    );
  }

  /// `Theme`
  String get themeTitle {
    return Intl.message(
      'Theme',
      name: 'themeTitle',
      desc: 'Theme title',
      args: [],
    );
  }

  /// `Choose app theme.`
  String get themeDescription {
    return Intl.message(
      'Choose app theme.',
      name: 'themeDescription',
      desc: 'Theme option description',
      args: [],
    );
  }

  /// `Back button opens drawer`
  String get backOpensDrawerTitle {
    return Intl.message(
      'Back button opens drawer',
      name: 'backOpensDrawerTitle',
      desc: 'Title for the option that allows back button to open the drawer',
      args: [],
    );
  }

  /// `Pressing the back button opens the drawer.`
  String get backOpensDrawerDescription {
    return Intl.message(
      'Pressing the back button opens the drawer.',
      name: 'backOpensDrawerDescription',
      desc: 'Description for back button opens drawer option',
      args: [],
    );
  }

  /// `Notifications`
  String get notificationsTitle {
    return Intl.message(
      'Notifications',
      name: 'notificationsTitle',
      desc: 'Notifications category title',
      args: [],
    );
  }

  /// `Rare Alerts`
  String get rareAlertsNotificationTitle {
    return Intl.message(
      'Rare Alerts',
      name: 'rareAlertsNotificationTitle',
      desc: 'Rare Alerts title',
      args: [],
    );
  }

  /// `Rare alert notifications, mainly gifts of the lotus.`
  String get rareAlertsNotificationDescription {
    return Intl.message(
      'Rare alert notifications, mainly gifts of the lotus.',
      name: 'rareAlertsNotificationDescription',
      desc: 'Description for rare alerts option',
      args: [],
    );
  }

  /// `Baro Ki'Teer`
  String get baroNotificationTitle {
    return Intl.message(
      'Baro Ki\'Teer',
      name: 'baroNotificationTitle',
      desc: 'Baro\'s notification title',
      args: [],
    );
  }

  /// `Notifications for both Baro's arrivial and departure.`
  String get baroNotificationDescription {
    return Intl.message(
      'Notifications for both Baro\'s arrivial and departure.',
      name: 'baroNotificationDescription',
      desc: 'Notification description for both Baro\'s arrivial and departure.',
      args: [],
    );
  }

  /// `Darvo's Daily Deals`
  String get darvoNotificationTitle {
    return Intl.message(
      'Darvo\'s Daily Deals',
      name: 'darvoNotificationTitle',
      desc: 'Notification title for darvo\'s daily deals',
      args: [],
    );
  }

  /// `Darvo's new find of the day.`
  String get darvoNotificationDescription {
    return Intl.message(
      'Darvo\'s new find of the day.',
      name: 'darvoNotificationDescription',
      desc: 'Notification description for Darvo\'s Daily Deal',
      args: [],
    );
  }

  /// `Sortie`
  String get sortieNotificationTitle {
    return Intl.message(
      'Sortie',
      name: 'sortieNotificationTitle',
      desc: 'Notification title for sorties',
      args: [],
    );
  }

  /// `Notifications for new sorties.`
  String get sortieNotificationDescription {
    return Intl.message(
      'Notifications for new sorties.',
      name: 'sortieNotificationDescription',
      desc: 'description for sortie notification option',
      args: [],
    );
  }

  /// `Sentient Outpost`
  String get sentientOutpostNotificationTitle {
    return Intl.message(
      'Sentient Outpost',
      name: 'sentientOutpostNotificationTitle',
      desc: 'Notification title for sentient outpost',
      args: [],
    );
  }

  /// `Notifications for new sentient threats`
  String get sentientOutpostNotificationDescription {
    return Intl.message(
      'Notifications for new sentient threats',
      name: 'sentientOutpostNotificationDescription',
      desc: 'Notification description for sentient outpost option',
      args: [],
    );
  }

  /// `News`
  String get warframeNewsNotificationTitle {
    return Intl.message(
      'News',
      name: 'warframeNewsNotificationTitle',
      desc: 'Main Title for Warframe news notifications',
      args: [],
    );
  }

  /// `News notifications for Prime Access, Streams and Updates.`
  String get warframeNewsNotificationDescription {
    return Intl.message(
      'News notifications for Prime Access, Streams and Updates.',
      name: 'warframeNewsNotificationDescription',
      desc: 'Main description for Warframe news notifications',
      args: [],
    );
  }

  /// `Open World Cycles`
  String get planetCyclesNotificationTitle {
    return Intl.message(
      'Open World Cycles',
      name: 'planetCyclesNotificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `Open world notifications for their given cycles.`
  String get planetCyclesNotificationDescription {
    return Intl.message(
      'Open world notifications for their given cycles.',
      name: 'planetCyclesNotificationDescription',
      desc: '',
      args: [],
    );
  }

  /// `Resources`
  String get resourcesNotificationTitle {
    return Intl.message(
      'Resources',
      name: 'resourcesNotificationTitle',
      desc: 'Main title for resource notifications',
      args: [],
    );
  }

  /// `Resources mostly found in invasions.`
  String get resourcesNotificationDescription {
    return Intl.message(
      'Resources mostly found in invasions.',
      name: 'resourcesNotificationDescription',
      desc: 'Main description for resource notifications',
      args: [],
    );
  }

  /// `Fissure Missions`
  String get fissuresNotificationTitle {
    return Intl.message(
      'Fissure Missions',
      name: 'fissuresNotificationTitle',
      desc: 'Main title for fisssures notifications',
      args: [],
    );
  }

  /// `Filter fissure notifications by prefered mission type`
  String get fissuresNotificationDescription {
    return Intl.message(
      'Filter fissure notifications by prefered mission type',
      name: 'fissuresNotificationDescription',
      desc: 'Main description for fissures notifications',
      args: [],
    );
  }

  /// `Acolytes`
  String get acolytesNotificationTitle {
    return Intl.message(
      'Acolytes',
      name: 'acolytesNotificationTitle',
      desc: 'Main title for acolyte notifications',
      args: [],
    );
  }

  /// `Notifies when an acolyte is found`
  String get acolytesNotificationDescription {
    return Intl.message(
      'Notifies when an acolyte is found',
      name: 'acolytesNotificationDescription',
      desc: 'Main description for acolyte notifications',
      args: [],
    );
  }

  /// `Earth Day`
  String get earthDayOption {
    return Intl.message(
      'Earth Day',
      name: 'earthDayOption',
      desc: 'Earth cycle option',
      args: [],
    );
  }

  /// `Earth Night`
  String get earthNightOption {
    return Intl.message(
      'Earth Night',
      name: 'earthNightOption',
      desc: 'Earth cycle option',
      args: [],
    );
  }

  /// `Cetus Day`
  String get cetusDayOption {
    return Intl.message(
      'Cetus Day',
      name: 'cetusDayOption',
      desc: 'Cetus cycle option',
      args: [],
    );
  }

  /// `Cetus Night`
  String get cetusNightOption {
    return Intl.message(
      'Cetus Night',
      name: 'cetusNightOption',
      desc: 'Cetus cycle option',
      args: [],
    );
  }

  /// `Orb Vallis Warm`
  String get vallisWarmOption {
    return Intl.message(
      'Orb Vallis Warm',
      name: 'vallisWarmOption',
      desc: 'Orb vallis cycle option',
      args: [],
    );
  }

  /// `Orb Vallis Cold`
  String get vallisColdOption {
    return Intl.message(
      'Orb Vallis Cold',
      name: 'vallisColdOption',
      desc: 'Orb vallis cycle option',
      args: [],
    );
  }

  /// `Prime Access`
  String get primeAccessNewsOption {
    return Intl.message(
      'Prime Access',
      name: 'primeAccessNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  /// `Stream Announcements`
  String get streamNewsOption {
    return Intl.message(
      'Stream Announcements',
      name: 'streamNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  /// `Warframe Update News`
  String get updateNewsOption {
    return Intl.message(
      'Warframe Update News',
      name: 'updateNewsOption',
      desc: 'Warframe news option',
      args: [],
    );
  }

  /// `Last updated {date}`
  String updateDropTableDescription(Object date) {
    return Intl.message(
      'Last updated $date',
      name: 'updateDropTableDescription',
      desc: 'Description for updating drop table with date of the last update',
      args: [date],
    );
  }

  /// `Report Bugs`
  String get reportBugsTitle {
    return Intl.message(
      'Report Bugs',
      name: 'reportBugsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Report bugs or Request a feature`
  String get reportBugsDescription {
    return Intl.message(
      'Report bugs or Request a feature',
      name: 'reportBugsDescription',
      desc: 'Description for bug report link',
      args: [],
    );
  }

  /// `About`
  String get aboutCategoryTitle {
    return Intl.message(
      'About',
      name: 'aboutCategoryTitle',
      desc: 'Title for the about category of the settings page',
      args: [],
    );
  }

  /// `Light`
  String get lightThemeTitle {
    return Intl.message(
      'Light',
      name: 'lightThemeTitle',
      desc: 'Title for light theme',
      args: [],
    );
  }

  /// `Dark`
  String get darkThemeTitle {
    return Intl.message(
      'Dark',
      name: 'darkThemeTitle',
      desc: 'Title for dark theme',
      args: [],
    );
  }

  /// `System`
  String get systemThemeTitle {
    return Intl.message(
      'System',
      name: 'systemThemeTitle',
      desc: 'Title for system theme',
      args: [],
    );
  }

  /// `Warframe and the Warframe logo are registered trademarks of Digital Extremes Ltd. Cephalon Navis nor WFCD are affiliated with Digital Extremes Ltd. in any way.`
  String get legalese {
    return Intl.message(
      'Warframe and the Warframe logo are registered trademarks of Digital Extremes Ltd. Cephalon Navis nor WFCD are affiliated with Digital Extremes Ltd. in any way.',
      name: 'legalese',
      desc: 'Cephalon Navis legalese',
      args: [],
    );
  }

  /// `Homepage`
  String get homePageTitle {
    return Intl.message(
      'Homepage',
      name: 'homePageTitle',
      desc: 'Displayes a link to Navis\'s homepage',
      args: [],
    );
  }

  /// `Report issues or feature request for this project's`
  String get issueTrackerDescription {
    return Intl.message(
      'Report issues or feature request for this project\'s',
      name: 'issueTrackerDescription',
      desc: 'Description for Navis\'s issue tracker',
      args: [],
    );
  }

  /// `issues tracker`
  String get issueTrackerTitle {
    return Intl.message(
      'issues tracker',
      name: 'issueTrackerTitle',
      desc: 'Display link to Navis\'s issue tracker',
      args: [],
    );
  }

  /// `More information on Warframe can be found on their official site`
  String get warframeLinkTitle {
    return Intl.message(
      'More information on Warframe can be found on their official site',
      name: 'warframeLinkTitle',
      desc: 'Description for Warframe\'s main site link',
      args: [],
    );
  }

  /// `Settings`
  String get settingsTitle {
    return Intl.message(
      'Settings',
      name: 'settingsTitle',
      desc: 'Settings title',
      args: [],
    );
  }

  /// `Daily Reward Reset Timer`
  String get dailyRewardTitle {
    return Intl.message(
      'Daily Reward Reset Timer',
      name: 'dailyRewardTitle',
      desc: 'Title for daily reward timer',
      args: [],
    );
  }

  /// `Elite`
  String get eliteBadgeTitle {
    return Intl.message(
      'Elite',
      name: 'eliteBadgeTitle',
      desc: 'Nightwave Elite badge title',
      args: [],
    );
  }

  /// `Daily`
  String get dailyNightwaveTitle {
    return Intl.message(
      'Daily',
      name: 'dailyNightwaveTitle',
      desc: 'Nightwave daily title',
      args: [],
    );
  }

  /// `Weekly`
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