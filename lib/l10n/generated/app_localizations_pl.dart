// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class NavisLocalizationsPl extends NavisLocalizations {
  NavisLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Poziom: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Dotknij, aby uzyskać więcej informacji';

  @override
  String get seeDetails => 'See details';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventStatus => 'Event Status';

  @override
  String get eventStatusNode => 'Node';

  @override
  String get eventStatusProgress => 'Progress';

  @override
  String get eventStatusEta => 'Time left (ETA)';

  @override
  String get eventRewards => 'Rewards';

  @override
  String get bountyTitle => 'Bounties';

  @override
  String get errorTitle => 'An application error has occurred';

  @override
  String get errorDescription => 'There was unexpected error in core system.\nReporting error to system admin...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Location';

  @override
  String get baroLeavesOn => 'Leaves on';

  @override
  String get baroArrivesOn => 'Arrives on';

  @override
  String get baroInventory => 'Baro Ki\'Teeer Inventory';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Ends on $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva will refresh in';

  @override
  String get formorianTitle => 'Fomorian';

  @override
  String get razorbackTitle => 'Razorback';

  @override
  String get cetusCycleTitle => 'Cetus Cycle';

  @override
  String get vallisCycleTitle => 'Vallis Cycle';

  @override
  String get cambionCycleTitle => 'Cambion Cycle';

  @override
  String get zarimanCycleTitle => 'Zariman Cycle';

  @override
  String get duviriCycleTitle => 'Duviri';

  @override
  String get timersTitle => 'Timers';

  @override
  String get fissuresTitle => 'Fissures';

  @override
  String get invasionsTitle => 'Invasions';

  @override
  String get syndicatesTitle => 'Syndicates';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Search all warframe items';

  @override
  String get helpfulLinksTitle => 'Helpful Links';

  @override
  String get behaviorTitle => 'Behavior';

  @override
  String get themeTitle => 'Theme';

  @override
  String get themeDescription => 'Choose app theme.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get rareAlertsNotificationTitle => 'Rare Alerts';

  @override
  String get rareAlertsNotificationDescription => 'Rare alert notifications, mainly gifts of the lotus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Notifications for both Baro\'s arrivial and departure.';

  @override
  String get darvoNotificationTitle => 'Darvo\'s Daily Deals';

  @override
  String get darvoNotificationDescription => 'Darvo\'s new find of the day.';

  @override
  String get sortieNotificationTitle => 'Sortie';

  @override
  String get sortieNotificationDescription => 'Notifications for new sorties.';

  @override
  String get sentientOutpostNotificationTitle => 'Sentient Outpost';

  @override
  String get sentientOutpostNotificationDescription => 'Notifications for new sentient threats.';

  @override
  String get warframeNewsTitle => 'News';

  @override
  String get warframeNewsNotificationTitle => 'News';

  @override
  String get warframeNewsNotificationDescription => 'News notifications for Prime Access, Streams and Updates.';

  @override
  String get planetCyclesNotificationTitle => 'Open World Cycles';

  @override
  String get planetCyclesNotificationDescription => 'Open world notifications for their given cycles.';

  @override
  String get resourcesNotificationTitle => 'Resources';

  @override
  String get resourcesNotificationDescription => 'Resources mostly found in invasions.';

  @override
  String get fissuresNotificationTitle => 'Fissure Missions';

  @override
  String get fissuresNotificationDescription => 'Filter fissure notifications by prefered mission type.';

  @override
  String get earthDayOption => 'Earth Day';

  @override
  String get earthNightOption => 'Earth Night';

  @override
  String get cetusDayOption => 'Cetus Day';

  @override
  String get cetusNightOption => 'Cetus Night';

  @override
  String get vallisWarmOption => 'Orb Vallis Warm';

  @override
  String get vallisColdOption => 'Orb Vallis Cold';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Stream Announcements';

  @override
  String get updateNewsOption => 'Warframe Update News';

  @override
  String get reportBugsTitle => 'Report Bugs';

  @override
  String get reportBugsDescription => 'Report bugs or request a feature.';

  @override
  String get aboutCategoryTitle => 'About';

  @override
  String get aboutAppTitle => 'About app';

  @override
  String get contributeTranslationsTitle => 'Contribute Translations';

  @override
  String get contributeTranslationsDescription => 'Volunteer to contribute translations';

  @override
  String get lightThemeTitle => 'Light';

  @override
  String get darkThemeTitle => 'Dark';

  @override
  String get systemThemeTitle => 'System';

  @override
  String get legalese => 'Warframe and the Warframe logo are registered trademarks of Digital Extremes Ltd. Cephalon Navis nor WFCD are affiliated with Digital Extremes Ltd. in any way.';

  @override
  String get homePageTitle => 'Home';

  @override
  String get sourceCode => 'Source code';

  @override
  String get issueTrackerDescription => 'Report issues or feature request for this project\'s';

  @override
  String get issueTrackerTitle => 'issues tracker';

  @override
  String get warframeLinkTitle => 'More information on Warframe can be found on their official site';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get dailyRewardTitle => 'Daily Reward Reset Timer';

  @override
  String get eliteBadgeTitle => 'Elite';

  @override
  String get dailyNightwaveTitle => 'Daily';

  @override
  String get weeklyNightwaveTitle => 'Weekly';

  @override
  String get warframePassiveTitle => 'Passive';

  @override
  String get auraTitle => 'Aura Polarity';

  @override
  String get preinstalledPolarities => 'Preinstalled Polarities';

  @override
  String get shieldTitle => 'Shield';

  @override
  String get armorTitle => 'Armor';

  @override
  String get healthTitle => 'Health';

  @override
  String get powerTitle => 'Power';

  @override
  String get sprintSpeedTitle => 'Sprint Speed';

  @override
  String get abilitiesTitle => 'Abilites';

  @override
  String get componentsTitle => 'Components';

  @override
  String get masteryRequirementTitle => 'Mastery Requirement';

  @override
  String get weaponTypeTitle => 'Weapon Type';

  @override
  String get accuracyTitle => 'Accuracy';

  @override
  String get criticalChanceTitle => 'Critical Chance';

  @override
  String get cricticalMultiplierTitle => 'Critcial Multiplier';

  @override
  String get fireRateTitle => 'Fire Rate';

  @override
  String get magazineTitle => 'Magazine';

  @override
  String get multishotTitle => 'Multishot';

  @override
  String get noiseTitle => 'Noise';

  @override
  String get reloadTitle => 'Reload';

  @override
  String get rivenDispositionTitle => 'Riven Disposition';

  @override
  String get statusChanceTitle => 'Status Chance';

  @override
  String get triggerTitle => 'Trigger';

  @override
  String get damageTitle => 'Damage';

  @override
  String get totalDamageTitle => 'Total Damage';

  @override
  String get stancePolarityTitle => 'Stance Polarity';

  @override
  String get attackSpeedTitle => 'Attack Speed';

  @override
  String get followThroughTitle => 'Follow Through';

  @override
  String get rangeTitle => 'Range';

  @override
  String get slamAttackTitle => 'Slam Attack';

  @override
  String get slamRadialDamageTitle => 'Slam Radial Damage';

  @override
  String get slamRadiusTitle => 'Slam Radius';

  @override
  String get slideAttackTitle => 'Slide Attack';

  @override
  String get heavyAttackTitle => 'Heavy Attack';

  @override
  String get heavySlamAttackTitle => 'Heavy Slam Attack';

  @override
  String get heavySlamRadialDamageTitle => 'Heavy Slam Radial Damage';

  @override
  String get heavySlamRadiusTitle => 'Heavy Slam Radius';

  @override
  String get windUpTitle => 'Wind Up';

  @override
  String get discordSupportTitle => 'Support';

  @override
  String get steelPathTitle => 'Steel Path';

  @override
  String get syndicateDualScreenTitle => 'Select Syndicate';

  @override
  String get optOutOfAnalyticsTitle => 'Opt out of analytics';

  @override
  String get optOutOfAnalyticsDescription => 'Disable analytics.';

  @override
  String get appLangTitle => 'Language';

  @override
  String get appLangDescription => 'Override default behavior for language detection.';

  @override
  String modLevelLabel(int rank) {
    return 'Level $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'No results';

  @override
  String get codexVaultedLabel => 'Vaulted';

  @override
  String get exploreTitle => 'Explore';

  @override
  String get constructionProgressTitle => 'Construction Progress';

  @override
  String get synthTargetTitle => 'SynthTargets';

  @override
  String get archonHuntTitle => 'Archon Hunt';

  @override
  String get archonHuntDescription => 'Archon hunt reset notification.';

  @override
  String get allFissuresButton => 'All';

  @override
  String get voidStormFissuresButton => 'Void Storms';

  @override
  String get saleEndsTitle => 'SALE ENDS';

  @override
  String get salePriceTitle => 'Sale price';

  @override
  String get originalPriceTitle => 'Original Price';

  @override
  String discountTitle(Object discount) {
    return '$discount% OFF!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Only $stock left';
  }

  @override
  String get outOfStockTitle => 'OUT OF STOCK';

  @override
  String get duviriJoy => 'Duviri Joy';

  @override
  String get duviriAnger => 'Duviri Anger';

  @override
  String get duviriEnvy => 'Duviri Envy';

  @override
  String get duviriSorrow => 'Duviri Sorrow';

  @override
  String get duviriFear => 'Duviri Fear';

  @override
  String get mapTitle => 'Maps';

  @override
  String get mapDescription => 'See region maps';

  @override
  String get fishTitle => 'Fish';

  @override
  String get fishDescription => 'See fish information by region';

  @override
  String get fishName => 'Name';

  @override
  String get fishTime => 'Time';

  @override
  String get fishSpear => 'Spear';

  @override
  String get fishRarity => 'Rarity';

  @override
  String get fishBait => 'Bait';

  @override
  String get fishStanding => 'Standing';

  @override
  String get fishUnique => 'Unique';

  @override
  String get fishBladder => 'Bladders';

  @override
  String get fishGills => 'Gills';

  @override
  String get fishTumors => 'Tumors';

  @override
  String get fishMeat => 'Meats';

  @override
  String get fishOil => 'Oils';

  @override
  String get fishScales => 'Scales';

  @override
  String get fishScrap => 'Scraps';

  @override
  String get fishAny => 'Any';

  @override
  String dropChance(Object chance) {
    return 'Drop chance $chance%';
  }

  @override
  String get statsTitle => 'Stats';

  @override
  String get patchlogsTitle => 'Patchlogs';

  @override
  String get impactDamageTitle => 'Impact';

  @override
  String get punctureDamageTitle => 'Puncture';

  @override
  String get slashDamageTitle => 'Slash';

  @override
  String get heatDamageTitle => 'Heat';

  @override
  String get coldDamageTitle => 'Cold';

  @override
  String get electricityDamageTitle => 'Electricity';

  @override
  String get toxinDamageTitle => 'Toxin';

  @override
  String get blastDamageTitle => 'Blast';

  @override
  String get radiationDamageTitle => 'Radiation';

  @override
  String get gasDamageTitle => 'Gas';

  @override
  String get magneticDamageTitle => 'Magnetic';

  @override
  String get viralDamageTitle => 'Viral';

  @override
  String get corrosiveDamageTitle => 'Corrosive';

  @override
  String get voidDamageTitle => 'Void';

  @override
  String get tauDamageTitle => 'Tau';

  @override
  String get cinematicDamageTitle => 'Cinematic';

  @override
  String get shieldDrainDamageTitle => 'Shield Drain';

  @override
  String get healthDrainDamageTitle => 'Health Drain';

  @override
  String get energyDrainDamageTitle => 'Energy Drain';

  @override
  String get physicalDamageTitle => 'Physical';

  @override
  String get circuitResetTitle => 'The Circuit resets in';

  @override
  String get circuitResetSubtitle => 'Tap to see current offerings';

  @override
  String get archimedeaTitle => 'Deep Archimedea ends';

  @override
  String get archimedeaDeviationTitle => 'Deviation';

  @override
  String get archimedeaRiskTitle => 'Risk Variable';

  @override
  String get missionsCategoryTitle => 'Missions';

  @override
  String get archimedeaPersonalModifierTitle => 'Personal Modifiers';

  @override
  String get archimedeaWarningTitle => 'Warning';

  @override
  String get archimedeaWarningSubtitle => 'DE doesn\'t always update Deep Archimedea data after a weekly reset so consider this unstable.\nWarning will be removed when data rotation is more consistent';

  @override
  String get activitiesTitle => 'Activities';

  @override
  String nightwaveSeasonSubtitle(Object season) {
    return 'Season $season';
  }

  @override
  String get calendar1999Title => '1999 Calendar';

  @override
  String get traderItemHeaderTitle => 'Item';

  @override
  String get traderDucatsHeaderTitle => 'Item';

  @override
  String get traderCreditsHeaderTitle => 'Item';

  @override
  String itemRankSubtitle(Object rank) {
    return 'Rank $rank';
  }

  @override
  String get syncingInfoText => 'Syncing XP info';

  @override
  String get enterUsernameHintText => 'Setup Inventoria';

  @override
  String get clearUsernameButtonLabel => 'Clear username';

  @override
  String get cancelText => 'Cancel';

  @override
  String inventoriaSteps(String url) {
    return 'Cephalon Navis can use your read-only profile data to help track your arsenal XP and mastery points.\n\n1. Go to $url on a computer\n\n2. Upload your EE.log or account ID from cookies\n\n3. Tap next and scan the generated QR code';
  }
}
