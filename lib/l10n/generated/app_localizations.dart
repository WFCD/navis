import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_cs.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_sr.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of NavisLocalizations
/// returned by `NavisLocalizations.of(context)`.
///
/// Applications need to include `NavisLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: NavisLocalizations.localizationsDelegates,
///   supportedLocales: NavisLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the NavisLocalizations.supportedLocales
/// property.
abstract class NavisLocalizations {
  NavisLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static NavisLocalizations of(BuildContext context) {
    return Localizations.of<NavisLocalizations>(context, NavisLocalizations)!;
  }

  static const LocalizationsDelegate<NavisLocalizations> delegate = _NavisLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('cs'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ko'),
    Locale('pl'),
    Locale('pt'),
    Locale('ru'),
    Locale('sr'),
    Locale('tr'),
    Locale('zh'),
  ];

  /// The information of the current enemy levels
  ///
  /// In en, this message translates to:
  /// **'Level: {min} - {max}'**
  String levelInfo(int min, int max);

  /// General description to tell the user that this object takes you to a different page
  ///
  /// In en, this message translates to:
  /// **'Tap for more details'**
  String get tapForMoreDetails;

  /// General button to see more details of given object
  ///
  /// In en, this message translates to:
  /// **'See details'**
  String get seeDetails;

  /// General button to see more of a overview object
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// General button to wikia of given item
  ///
  /// In en, this message translates to:
  /// **'See Wikia'**
  String get seeWikia;

  /// Event description category title
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get eventDescription;

  /// Event status category title
  ///
  /// In en, this message translates to:
  /// **'Event Status'**
  String get eventStatus;

  /// The node that the event is taking place in
  ///
  /// In en, this message translates to:
  /// **'Node'**
  String get eventStatusNode;

  /// The progress of the current event from 0 to 100 %
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get eventStatusProgress;

  /// Current events remaining estimated time
  ///
  /// In en, this message translates to:
  /// **'Time left (ETA)'**
  String get eventStatusEta;

  /// Event reward title
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get eventRewards;

  /// Bounty card title.
  ///
  /// In en, this message translates to:
  /// **'Bounties'**
  String get bountyTitle;

  /// error title
  ///
  /// In en, this message translates to:
  /// **'An application error has occurred'**
  String get errorTitle;

  /// error description
  ///
  /// In en, this message translates to:
  /// **'There was unexpected error in core system.\nReporting error to system admin...'**
  String get errorDescription;

  /// Title for Baro Ki'Teer card
  ///
  /// In en, this message translates to:
  /// **'Baro Ki\'Teer'**
  String get baroTitle;

  /// Reuseable string for location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// shows when Baro Ki'Teer is leaving
  ///
  /// In en, this message translates to:
  /// **'Leaves on'**
  String get baroLeavesOn;

  /// shows at when Baro Ki'Teer will arrive
  ///
  /// In en, this message translates to:
  /// **'Arrives on'**
  String get baroArrivesOn;

  /// Baro Ki'Teer Inventory button label
  ///
  /// In en, this message translates to:
  /// **'Baro Ki\'Teer Inventory'**
  String get baroInventory;

  /// Countdown tooltip with end date of the current running timer
  ///
  /// In en, this message translates to:
  /// **'Ends on {date}'**
  String countdownTooltip(DateTime date);

  /// Kuva refresh countdown title
  ///
  /// In en, this message translates to:
  /// **'Kuva will refresh in'**
  String get kuvaBanner;

  /// Fomorian progress title
  ///
  /// In en, this message translates to:
  /// **'Fomorian'**
  String get formorianTitle;

  /// Razorback progress title
  ///
  /// In en, this message translates to:
  /// **'Razorback'**
  String get razorbackTitle;

  /// Earth cycle title
  ///
  /// In en, this message translates to:
  /// **'Earth Cycle'**
  String get earthCycleTitle;

  /// Cetus cycle title
  ///
  /// In en, this message translates to:
  /// **'Cetus Cycle'**
  String get cetusCycleTitle;

  /// Vallis cycle title
  ///
  /// In en, this message translates to:
  /// **'Vallis Cycle'**
  String get vallisCycleTitle;

  /// Cambion Cycle title
  ///
  /// In en, this message translates to:
  /// **'Cambion Cycle'**
  String get cambionCycleTitle;

  /// Zariman Cycle title
  ///
  /// In en, this message translates to:
  /// **'Zariman Cycle'**
  String get zarimanCycleTitle;

  /// Times title
  ///
  /// In en, this message translates to:
  /// **'Timers'**
  String get timersTitle;

  /// Fissures title
  ///
  /// In en, this message translates to:
  /// **'Fissures'**
  String get fissuresTitle;

  /// Invasions title
  ///
  /// In en, this message translates to:
  /// **'Invasions'**
  String get invasionsTitle;

  /// Syndicates title
  ///
  /// In en, this message translates to:
  /// **'Syndicates'**
  String get syndicatesTitle;

  /// Codex title
  ///
  /// In en, this message translates to:
  /// **'Codex'**
  String get codexTitle;

  /// Codex description
  ///
  /// In en, this message translates to:
  /// **'Search all warframe items'**
  String get codexDescription;

  /// Helpful Links title
  ///
  /// In en, this message translates to:
  /// **'Helpful Links'**
  String get helpfulLinksTitle;

  /// Behavior category title
  ///
  /// In en, this message translates to:
  /// **'Behavior'**
  String get behaviorTitle;

  /// Theme title
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeTitle;

  /// Theme option description
  ///
  /// In en, this message translates to:
  /// **'Choose app theme.'**
  String get themeDescription;

  /// Notifications category title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Rare Alerts title
  ///
  /// In en, this message translates to:
  /// **'Rare Alerts'**
  String get rareAlertsNotificationTitle;

  /// Description for rare alerts option
  ///
  /// In en, this message translates to:
  /// **'Rare alert notifications, mainly gifts of the lotus.'**
  String get rareAlertsNotificationDescription;

  /// Rare Alerts title
  ///
  /// In en, this message translates to:
  /// **'Operation Alerts'**
  String get operationAlertsNotificationTitle;

  /// Description for rare alerts option
  ///
  /// In en, this message translates to:
  /// **'Alert notifications for operations'**
  String get operationAlertsNotificationDescription;

  /// Baro's notification title
  ///
  /// In en, this message translates to:
  /// **'Baro Ki\'Teer'**
  String get baroNotificationTitle;

  /// Notification description for both Baro's arrivial and departure.
  ///
  /// In en, this message translates to:
  /// **'Notifications for both Baro\'s arrivial and departure.'**
  String get baroNotificationDescription;

  /// Notification title for darvo's daily deals
  ///
  /// In en, this message translates to:
  /// **'Darvo\'s Daily Deals'**
  String get darvoNotificationTitle;

  /// Notification description for Darvo's Daily Deal
  ///
  /// In en, this message translates to:
  /// **'Darvo\'s new find of the day.'**
  String get darvoNotificationDescription;

  /// Notification title for sorties
  ///
  /// In en, this message translates to:
  /// **'Sortie'**
  String get sortieNotificationTitle;

  /// description for sortie notification option
  ///
  /// In en, this message translates to:
  /// **'Notifications for new sorties.'**
  String get sortieNotificationDescription;

  /// Notification title for sentient outpost
  ///
  /// In en, this message translates to:
  /// **'Sentient Outpost'**
  String get sentientOutpostNotificationTitle;

  /// Notification description for sentient outpost option
  ///
  /// In en, this message translates to:
  /// **'Notifications for new sentient threats.'**
  String get sentientOutpostNotificationDescription;

  /// Main Title for Warframe news page
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get warframeNewsTitle;

  /// Main Title for Warframe news notifications
  ///
  /// In en, this message translates to:
  /// **'News'**
  String get warframeNewsNotificationTitle;

  /// Main description for Warframe news notifications
  ///
  /// In en, this message translates to:
  /// **'News notifications for Prime Access, Streams and Updates.'**
  String get warframeNewsNotificationDescription;

  /// Main title for open world notifications
  ///
  /// In en, this message translates to:
  /// **'Open World Cycles'**
  String get planetCyclesNotificationTitle;

  /// Main description for open world notifications
  ///
  /// In en, this message translates to:
  /// **'Open world notifications for their given cycles.'**
  String get planetCyclesNotificationDescription;

  /// Main title for resource notifications
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resourcesNotificationTitle;

  /// Main description for resource notifications
  ///
  /// In en, this message translates to:
  /// **'Resources mostly found in invasions.'**
  String get resourcesNotificationDescription;

  /// Main title for fisssures notifications
  ///
  /// In en, this message translates to:
  /// **'Fissure Missions'**
  String get fissuresNotificationTitle;

  /// Main description for fissures notifications
  ///
  /// In en, this message translates to:
  /// **'Filter fissure notifications by prefered mission type.'**
  String get fissuresNotificationDescription;

  /// Earth cycle option
  ///
  /// In en, this message translates to:
  /// **'Earth Day'**
  String get earthDayOption;

  /// Earth cycle option
  ///
  /// In en, this message translates to:
  /// **'Earth Night'**
  String get earthNightOption;

  /// Cetus cycle option
  ///
  /// In en, this message translates to:
  /// **'Cetus Day'**
  String get cetusDayOption;

  /// Cetus cycle option
  ///
  /// In en, this message translates to:
  /// **'Cetus Night'**
  String get cetusNightOption;

  /// Orb vallis cycle option
  ///
  /// In en, this message translates to:
  /// **'Orb Vallis Warm'**
  String get vallisWarmOption;

  /// Orb vallis cycle option
  ///
  /// In en, this message translates to:
  /// **'Orb Vallis Cold'**
  String get vallisColdOption;

  /// Cambion Fass cycle option
  ///
  /// In en, this message translates to:
  /// **'Cambion Fass'**
  String get cambionFassOption;

  /// Cambion Fass cycle option
  ///
  /// In en, this message translates to:
  /// **'Cambion Vome'**
  String get cambionVomeOption;

  /// Warframe news option
  ///
  /// In en, this message translates to:
  /// **'Prime Access'**
  String get primeAccessNewsOption;

  /// Warframe news option
  ///
  /// In en, this message translates to:
  /// **'Stream Announcements'**
  String get streamNewsOption;

  /// Warframe news option
  ///
  /// In en, this message translates to:
  /// **'Warframe Update News'**
  String get updateNewsOption;

  /// No description provided for @reportBugsTitle.
  ///
  /// In en, this message translates to:
  /// **'Report Bugs'**
  String get reportBugsTitle;

  /// Description for bug report link
  ///
  /// In en, this message translates to:
  /// **'Report bugs or request a feature.'**
  String get reportBugsDescription;

  /// Title for the about category of the settings page
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get aboutCategoryTitle;

  /// Title for the about app dialog
  ///
  /// In en, this message translates to:
  /// **'About app'**
  String get aboutAppTitle;

  /// Title for contribute translations link
  ///
  /// In en, this message translates to:
  /// **'Contribute Translations'**
  String get contributeTranslationsTitle;

  /// Description for contribute translations link
  ///
  /// In en, this message translates to:
  /// **'Volunteer to contribute translations'**
  String get contributeTranslationsDescription;

  /// Title for light theme
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get lightThemeTitle;

  /// Title for dark theme
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get darkThemeTitle;

  /// Title for system theme
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get systemThemeTitle;

  /// Cephalon Navis legalese
  ///
  /// In en, this message translates to:
  /// **'Warframe and the Warframe logo are registered trademarks of Digital Extremes Ltd. Cephalon Navis nor WFCD are affiliated with Digital Extremes Ltd. in any way.'**
  String get legalese;

  /// Displayes a link to Navis's homepage
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homePageTitle;

  /// Displayes a link to Navis's source code
  ///
  /// In en, this message translates to:
  /// **'Source code'**
  String get sourceCode;

  /// Description for Navis's issue tracker
  ///
  /// In en, this message translates to:
  /// **'Report issues or feature request for this project'**
  String get issueTrackerDescription;

  /// Display link to Navis's issue tracker
  ///
  /// In en, this message translates to:
  /// **'issues tracker'**
  String get issueTrackerTitle;

  /// Description for Warframe's main site link
  ///
  /// In en, this message translates to:
  /// **'More information on Warframe can be found on their official site'**
  String get warframeLinkTitle;

  /// Settings title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Title for daily reward timer
  ///
  /// In en, this message translates to:
  /// **'Daily Reward Reset Timer'**
  String get dailyRewardTitle;

  /// Nightwave Elite badge title
  ///
  /// In en, this message translates to:
  /// **'Elite'**
  String get eliteBadgeTitle;

  /// Nightwave daily title
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyNightwaveTitle;

  /// Nightwave weekly title
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get weeklyNightwaveTitle;

  /// Warframes passive title
  ///
  /// In en, this message translates to:
  /// **'Passive'**
  String get warframePassiveTitle;

  /// Aura polarity title for items
  ///
  /// In en, this message translates to:
  /// **'Aura Polarity'**
  String get auraTitle;

  /// Preinstalled polarites title for items
  ///
  /// In en, this message translates to:
  /// **'Preinstalled Polarities'**
  String get preinstalledPolarities;

  /// Title for shield value
  ///
  /// In en, this message translates to:
  /// **'Shield'**
  String get shieldTitle;

  /// Title for armor value
  ///
  /// In en, this message translates to:
  /// **'Armor'**
  String get armorTitle;

  /// Title for health value
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get healthTitle;

  /// Title for power value
  ///
  /// In en, this message translates to:
  /// **'Power'**
  String get powerTitle;

  /// Title for sprint speed value
  ///
  /// In en, this message translates to:
  /// **'Sprint Speed'**
  String get sprintSpeedTitle;

  /// Title for warframe, archwings, and Necromech abilites
  ///
  /// In en, this message translates to:
  /// **'Abilites'**
  String get abilitiesTitle;

  /// Title for item components
  ///
  /// In en, this message translates to:
  /// **'Components'**
  String get componentsTitle;

  /// Mastery requirement for item
  ///
  /// In en, this message translates to:
  /// **'Mastery Requirement'**
  String get masteryRequirementTitle;

  /// Weapon item type
  ///
  /// In en, this message translates to:
  /// **'Weapon Type'**
  String get weaponTypeTitle;

  /// Weapon accuracy title
  ///
  /// In en, this message translates to:
  /// **'Accuracy'**
  String get accuracyTitle;

  /// Weapon crictical chance
  ///
  /// In en, this message translates to:
  /// **'Critical Chance'**
  String get criticalChanceTitle;

  /// Weapon critical multiplier
  ///
  /// In en, this message translates to:
  /// **'Critcial Multiplier'**
  String get cricticalMultiplierTitle;

  /// Weapon fire rate
  ///
  /// In en, this message translates to:
  /// **'Fire Rate'**
  String get fireRateTitle;

  /// Weapon magazine size title
  ///
  /// In en, this message translates to:
  /// **'Magazine'**
  String get magazineTitle;

  /// Weapon multishot
  ///
  /// In en, this message translates to:
  /// **'Multishot'**
  String get multishotTitle;

  /// Weapon noise type
  ///
  /// In en, this message translates to:
  /// **'Noise'**
  String get noiseTitle;

  /// Weapon item type
  ///
  /// In en, this message translates to:
  /// **'Reload'**
  String get reloadTitle;

  /// Weapon's riven disposition
  ///
  /// In en, this message translates to:
  /// **'Riven Disposition'**
  String get rivenDispositionTitle;

  /// Weapon's status chance
  ///
  /// In en, this message translates to:
  /// **'Status Chance'**
  String get statusChanceTitle;

  /// Weapon item type
  ///
  /// In en, this message translates to:
  /// **'Trigger'**
  String get triggerTitle;

  /// Weapon's damage category
  ///
  /// In en, this message translates to:
  /// **'Damage'**
  String get damageTitle;

  /// Weapon's total damage'
  ///
  /// In en, this message translates to:
  /// **'Total Damage'**
  String get totalDamageTitle;

  /// Melee stance polarity title
  ///
  /// In en, this message translates to:
  /// **'Stance Polarity'**
  String get stancePolarityTitle;

  /// melee attack speed
  ///
  /// In en, this message translates to:
  /// **'Attack Speed'**
  String get attackSpeedTitle;

  /// Melee follow through title
  ///
  /// In en, this message translates to:
  /// **'Follow Through'**
  String get followThroughTitle;

  /// Melee's range title
  ///
  /// In en, this message translates to:
  /// **'Range'**
  String get rangeTitle;

  /// Melee's slam attack
  ///
  /// In en, this message translates to:
  /// **'Slam Attack'**
  String get slamAttackTitle;

  /// Melee's Slam Radial Damage
  ///
  /// In en, this message translates to:
  /// **'Slam Radial Damage'**
  String get slamRadialDamageTitle;

  /// Slam Radius title
  ///
  /// In en, this message translates to:
  /// **'Slam Radius'**
  String get slamRadiusTitle;

  /// Melee's slide attack
  ///
  /// In en, this message translates to:
  /// **'Slide Attack'**
  String get slideAttackTitle;

  /// Heavy attack title
  ///
  /// In en, this message translates to:
  /// **'Heavy Attack'**
  String get heavyAttackTitle;

  /// Heavy Slam attack title
  ///
  /// In en, this message translates to:
  /// **'Heavy Slam Attack'**
  String get heavySlamAttackTitle;

  /// Heavy Slam attack title
  ///
  /// In en, this message translates to:
  /// **'Heavy Slam Radial Damage'**
  String get heavySlamRadialDamageTitle;

  /// Heavy Slam attack title
  ///
  /// In en, this message translates to:
  /// **'Heavy Slam Radius'**
  String get heavySlamRadiusTitle;

  /// melee's heavy wind up time title
  ///
  /// In en, this message translates to:
  /// **'Wind Up'**
  String get windUpTitle;

  /// Discord support title
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get discordSupportTitle;

  /// Steel path card title
  ///
  /// In en, this message translates to:
  /// **'Steel Path'**
  String get steelPathTitle;

  /// User hint when under syndicate tabs using a tablet
  ///
  /// In en, this message translates to:
  /// **'Select Syndicate'**
  String get syndicateDualScreenTitle;

  /// Title opting out of analytics
  ///
  /// In en, this message translates to:
  /// **'Opt out of analytics'**
  String get optOutOfAnalyticsTitle;

  /// Description of the analytics opting buttong
  ///
  /// In en, this message translates to:
  /// **'Disable analytics.'**
  String get optOutOfAnalyticsDescription;

  /// Title for app language options
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get appLangTitle;

  /// Description for language options
  ///
  /// In en, this message translates to:
  /// **'Override default behavior for language detection.'**
  String get appLangDescription;

  /// The label shown to users as they slide the mod slider
  ///
  /// In en, this message translates to:
  /// **'Level {rank}'**
  String modLevelLabel(int rank);

  /// Codex description when a user enters the codex or when the search bar is empty
  ///
  /// In en, this message translates to:
  /// **'Search here...'**
  String get codexHint;

  /// Displayed when a search result in codex returns empty
  ///
  /// In en, this message translates to:
  /// **'No results'**
  String get codexNoResults;

  /// A label shown in codex items to detenote items that are vaulted
  ///
  /// In en, this message translates to:
  /// **'Vaulted'**
  String get codexVaultedLabel;

  /// Title for explore page
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get exploreTitle;

  /// Title for invasion constrcution progress
  ///
  /// In en, this message translates to:
  /// **'Construction Progress'**
  String get constructionProgressTitle;

  /// Title for synthtargets.
  ///
  /// In en, this message translates to:
  /// **'SynthTargets'**
  String get synthTargetTitle;

  /// Title for archon hunt notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Archon Hunt'**
  String get archonHuntTitle;

  /// Description for archon hunt notification toggle.
  ///
  /// In en, this message translates to:
  /// **'Archon hunt reset notification.'**
  String get archonHuntDescription;

  /// Button label for all fissures
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allFissuresButton;

  /// Button label for void storm fissures
  ///
  /// In en, this message translates to:
  /// **'Void Storms'**
  String get voidStormFissuresButton;

  /// Sale ends title for countdown timer
  ///
  /// In en, this message translates to:
  /// **'SALE ENDS'**
  String get saleEndsTitle;

  /// Displays the item's sale price for darvo sales
  ///
  /// In en, this message translates to:
  /// **'Sale price'**
  String get salePriceTitle;

  /// Displays the item's original price for darvo sales
  ///
  /// In en, this message translates to:
  /// **'Original Price'**
  String get originalPriceTitle;

  /// Displays the discount applied for a given darvo sale
  ///
  /// In en, this message translates to:
  /// **'{discount}% OFF!'**
  String discountTitle(Object discount);

  /// Displays the stock information for a darvo deal
  ///
  /// In en, this message translates to:
  /// **'Only {stock} left'**
  String inStockInformation(Object stock);

  /// Tells the user when darvo is out of stock for the current sale
  ///
  /// In en, this message translates to:
  /// **'OUT OF STOCK'**
  String get outOfStockTitle;

  /// Duviri joy state. If Duviri doesn't have a translatetion then only joy can be translated.
  ///
  /// In en, this message translates to:
  /// **'Duviri Joy'**
  String get duviriJoy;

  /// Duviri anger state. If Duviri doesn't have a translatetion then only joy can be translated.
  ///
  /// In en, this message translates to:
  /// **'Duviri Anger'**
  String get duviriAnger;

  /// Duviri envy state. If Duviri doesn't have a translatetion then only joy can be translated.
  ///
  /// In en, this message translates to:
  /// **'Duviri Envy'**
  String get duviriEnvy;

  /// Duviri sorrow state. If Duviri doesn't have a translatetion then only joy can be translated.
  ///
  /// In en, this message translates to:
  /// **'Duviri Sorrow'**
  String get duviriSorrow;

  /// Duviri Fear state. If Duviri doesn't have a translatetion then only joy can be translated.
  ///
  /// In en, this message translates to:
  /// **'Duviri Fear'**
  String get duviriFear;

  /// Map title
  ///
  /// In en, this message translates to:
  /// **'Maps'**
  String get mapTitle;

  /// Map card description
  ///
  /// In en, this message translates to:
  /// **'See region maps'**
  String get mapDescription;

  /// Fish title
  ///
  /// In en, this message translates to:
  /// **'Fish'**
  String get fishTitle;

  /// fish card description
  ///
  /// In en, this message translates to:
  /// **'See fish information by region'**
  String get fishDescription;

  /// Display a fish name along side it
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get fishName;

  /// Display time a day a fish can be caught in
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get fishTime;

  /// Display the type of spear used to catch fish
  ///
  /// In en, this message translates to:
  /// **'Spear'**
  String get fishSpear;

  /// Display rarity of a given fish
  ///
  /// In en, this message translates to:
  /// **'Rarity'**
  String get fishRarity;

  /// Display type of bait needed to catch fish
  ///
  /// In en, this message translates to:
  /// **'Bait'**
  String get fishBait;

  /// Display standing earned with fish
  ///
  /// In en, this message translates to:
  /// **'Standing'**
  String get fishStanding;

  /// Display a unique resources earned by given fish
  ///
  /// In en, this message translates to:
  /// **'Unique'**
  String get fishUnique;

  /// Displays how many bladders can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Bladders'**
  String get fishBladder;

  /// Displays how many gills can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Gills'**
  String get fishGills;

  /// Displays how many tumors can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Tumors'**
  String get fishTumors;

  /// Displays how many meat can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Meats'**
  String get fishMeat;

  /// Displays how many oils can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Oils'**
  String get fishOil;

  /// Displays how many scales can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Scales'**
  String get fishScales;

  /// Displays how many scraps can be earned with the given fish size
  ///
  /// In en, this message translates to:
  /// **'Scraps'**
  String get fishScrap;

  /// Displayed when a fish can be caught by any spear
  ///
  /// In en, this message translates to:
  /// **'Any'**
  String get fishAny;

  /// Drop chance percentage
  ///
  /// In en, this message translates to:
  /// **'Drop chance {chance}%'**
  String dropChance(Object chance);

  /// Codex stat title
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// Codex patchlogs title
  ///
  /// In en, this message translates to:
  /// **'Patchlogs'**
  String get patchlogsTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Impact'**
  String get impactDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Puncture'**
  String get punctureDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Slash'**
  String get slashDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Heat'**
  String get heatDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get coldDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Electricity'**
  String get electricityDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Toxin'**
  String get toxinDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Blast'**
  String get blastDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Radiation'**
  String get radiationDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Gas'**
  String get gasDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Magnetic'**
  String get magneticDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Viral'**
  String get viralDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Corrosive'**
  String get corrosiveDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Void'**
  String get voidDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Tau'**
  String get tauDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Cinematic'**
  String get cinematicDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Shield Drain'**
  String get shieldDrainDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Health Drain'**
  String get healthDrainDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Energy Drain'**
  String get energyDrainDamageTitle;

  /// Codex Weapon damage type title
  ///
  /// In en, this message translates to:
  /// **'Physical'**
  String get physicalDamageTitle;

  /// Text displayed next to the weekly reset time for the circuit
  ///
  /// In en, this message translates to:
  /// **'The Circuit resets in'**
  String get circuitResetTitle;

  /// Text displayed next to the weekly reset time for the Deep Archimedea
  ///
  /// In en, this message translates to:
  /// **'Deep Archimedea ends'**
  String get archimedeaTitle;

  /// Text displayed next to Deep Archimedea deviation name
  ///
  /// In en, this message translates to:
  /// **'Deviation'**
  String get archimedeaDeviationTitle;

  /// Text displayed next to Deep Archimedea risk variable name
  ///
  /// In en, this message translates to:
  /// **'Risk Variable'**
  String get archimedeaRiskTitle;

  /// Text displayed where a missions category is needed
  ///
  /// In en, this message translates to:
  /// **'Missions'**
  String get missionsCategoryTitle;

  /// Text displayed above to Deep Archimedea personal modifiers
  ///
  /// In en, this message translates to:
  /// **'Personal Modifiers'**
  String get archimedeaPersonalModifierTitle;

  /// Warning title displayed under Deep Archimedea timer
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get archimedeaWarningTitle;

  /// Warning text displayed under Deep Archimedea warning title
  ///
  /// In en, this message translates to:
  /// **'DE doesn\'t always update Deep Archimedea data after a weekly reset so consider this unstable.\nWarning will be removed when data rotation is more consistent'**
  String get archimedeaWarningSubtitle;

  /// Activities title
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activitiesTitle;
}

class _NavisLocalizationsDelegate extends LocalizationsDelegate<NavisLocalizations> {
  const _NavisLocalizationsDelegate();

  @override
  Future<NavisLocalizations> load(Locale locale) {
    return SynchronousFuture<NavisLocalizations>(lookupNavisLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'cs',
    'de',
    'en',
    'es',
    'fr',
    'it',
    'ko',
    'pl',
    'pt',
    'ru',
    'sr',
    'tr',
    'zh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_NavisLocalizationsDelegate old) => false;
}

NavisLocalizations lookupNavisLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'cs':
      return NavisLocalizationsCs();
    case 'de':
      return NavisLocalizationsDe();
    case 'en':
      return NavisLocalizationsEn();
    case 'es':
      return NavisLocalizationsEs();
    case 'fr':
      return NavisLocalizationsFr();
    case 'it':
      return NavisLocalizationsIt();
    case 'ko':
      return NavisLocalizationsKo();
    case 'pl':
      return NavisLocalizationsPl();
    case 'pt':
      return NavisLocalizationsPt();
    case 'ru':
      return NavisLocalizationsRu();
    case 'sr':
      return NavisLocalizationsSr();
    case 'tr':
      return NavisLocalizationsTr();
    case 'zh':
      return NavisLocalizationsZh();
  }

  throw FlutterError(
    'NavisLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
