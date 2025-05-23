// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Czech (`cs`).
class NavisLocalizationsCs extends NavisLocalizations {
  NavisLocalizationsCs([String locale = 'cs']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Úroveň: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Klepnutím zde zobrazíte další podrobnosti';

  @override
  String get seeDetails => 'Zobrazit podrobnosti';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Popis';

  @override
  String get eventStatus => 'Stav události';

  @override
  String get eventStatusNode => 'Uzel';

  @override
  String get eventStatusProgress => 'Postup';

  @override
  String get eventStatusEta => 'Zbývající čas (ETA)';

  @override
  String get eventRewards => 'Odměny';

  @override
  String get bountyTitle => 'Bounty';

  @override
  String get errorTitle => 'Došlo k chybě aplikace';

  @override
  String get errorDescription => 'V systému došlo k neočekávané chybě.\nNahlašuji chybu správci systému...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Location';

  @override
  String get baroLeavesOn => 'Ochází za';

  @override
  String get baroArrivesOn => 'Objeví za';

  @override
  String get baroInventory => 'Inventář Baro Ki\'Teeera';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Končí $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva se obnoví za';

  @override
  String get formorianTitle => 'Fomorian';

  @override
  String get razorbackTitle => 'Razorback';

  @override
  String get cetusCycleTitle => 'Earth/Plains of Eidolon';

  @override
  String get vallisCycleTitle => 'Orb Vallis';

  @override
  String get cambionCycleTitle => 'Cambion Drift';

  @override
  String get zarimanCycleTitle => 'Zariman';

  @override
  String get duviriCycleTitle => 'Duviri';

  @override
  String get timersTitle => 'Časovače';

  @override
  String get fissuresTitle => 'Fissures';

  @override
  String get invasionsTitle => 'Invaze';

  @override
  String get syndicatesTitle => 'Syndikáty';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Search all warframe items';

  @override
  String get helpfulLinksTitle => 'Užitečné odkazy';

  @override
  String get behaviorTitle => 'Chování';

  @override
  String get themeTitle => 'Téma';

  @override
  String get themeDescription => 'Vybrat vzhled applikace.';

  @override
  String get notificationsTitle => 'Oznámení';

  @override
  String get rareAlertsNotificationTitle => 'Vzácná upozornění';

  @override
  String get rareAlertsNotificationDescription => 'Vzácná upozornění, zejména dary lotusu.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Oznámení jak o příjezdu Baro\'a, tak o odletu.';

  @override
  String get darvoNotificationTitle => 'Darvovy Denní Nabídky';

  @override
  String get darvoNotificationDescription => 'Darvo nový nález dne.';

  @override
  String get sortieNotificationTitle => 'Sortie';

  @override
  String get sortieNotificationDescription => 'Oznámení pro nové Sortie.';

  @override
  String get sentientOutpostNotificationTitle => 'Základna Sentientů';

  @override
  String get sentientOutpostNotificationDescription => 'Notifications for new sentient threats.';

  @override
  String get warframeNewsTitle => 'News';

  @override
  String get warframeNewsNotificationTitle => 'Novinky';

  @override
  String get warframeNewsNotificationDescription => 'Oznámení novinek o Prime Přístupu, Steamech a Aktualizacích.';

  @override
  String get planetCyclesNotificationTitle => 'Otevřít cykly světů';

  @override
  String get planetCyclesNotificationDescription => 'Oznámení otevřeného světa pro dané cykly.';

  @override
  String get resourcesNotificationTitle => 'Suroviny';

  @override
  String get resourcesNotificationDescription => 'Suroviny nalezené většinou v invazích.';

  @override
  String get fissuresNotificationTitle => 'Fissure Mise';

  @override
  String get fissuresNotificationDescription => 'Filter fissure notifications by prefered mission type.';

  @override
  String get earthDayOption => 'Země Den';

  @override
  String get earthNightOption => 'Země Noc';

  @override
  String get cetusDayOption => 'Cetus Den';

  @override
  String get cetusNightOption => 'Cetus Noc';

  @override
  String get vallisWarmOption => 'Orb Vallis Teplo';

  @override
  String get vallisColdOption => 'Orb Vallis Zima';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Přístup';

  @override
  String get streamNewsOption => 'Oznámení o Streamech';

  @override
  String get updateNewsOption => 'Warframe Novinky o Aktualizacích';

  @override
  String get reportBugsTitle => 'Nahlásit chyby';

  @override
  String get reportBugsDescription => 'Report bugs or request a feature.';

  @override
  String get aboutCategoryTitle => 'Informace';

  @override
  String get aboutAppTitle => 'About app';

  @override
  String get contributeTranslationsTitle => 'Contribute Translations';

  @override
  String get contributeTranslationsDescription => 'Volunteer to contribute translations';

  @override
  String get lightThemeTitle => 'Světlé téma';

  @override
  String get darkThemeTitle => 'Tmavé téma';

  @override
  String get systemThemeTitle => 'Systémové téma';

  @override
  String get legalese =>
      'Warframe a logo Warframe jsou registrované ochranné známky Digital Extremes Ltd. Cephalon Navis nor WFCD jsou přidruženy k Digital Extremes Ltd. v jakémkoli smyslu.';

  @override
  String get homePageTitle => 'Home';

  @override
  String get sourceCode => 'Source code';

  @override
  String get issueTrackerDescription => 'Nahlásit problémy nebo podat žádost o novou funkci pro tento projekt';

  @override
  String get issueTrackerTitle => 'sledování problémů';

  @override
  String get warframeLinkTitle => 'Více informací o hře Warframe lze nalézt na oficiálních stránkách';

  @override
  String get settingsTitle => 'Nastavení';

  @override
  String get dailyResetTitle => 'Daily Reset Timer';

  @override
  String get weeklyResetTitle => 'Weekly Reset Timer';

  @override
  String get eliteBadgeTitle => 'Elita';

  @override
  String get dailyNightwaveTitle => 'Denní';

  @override
  String get weeklyNightwaveTitle => 'Týdenní';

  @override
  String get warframePassiveTitle => 'Pasivní';

  @override
  String get auraTitle => 'Polarita Aury';

  @override
  String get preinstalledPolarities => 'Předinstalované polarity';

  @override
  String get shieldTitle => 'Štít';

  @override
  String get armorTitle => 'Brnění';

  @override
  String get healthTitle => 'Zdraví';

  @override
  String get powerTitle => 'Síla';

  @override
  String get sprintSpeedTitle => 'Rychlost sprintu';

  @override
  String get abilitiesTitle => 'Schopnosti';

  @override
  String get componentsTitle => 'Součástky';

  @override
  String get masteryRequirementTitle => 'Požadavek Mastery';

  @override
  String get weaponTypeTitle => 'Typ zbraně';

  @override
  String get accuracyTitle => 'Přesnost';

  @override
  String get criticalChanceTitle => 'Critical Chance';

  @override
  String get cricticalMultiplierTitle => 'Multiplikátor Kritéria';

  @override
  String get fireRateTitle => 'Rychlost Střelby';

  @override
  String get magazineTitle => 'Zásobník';

  @override
  String get multishotTitle => 'Multishot';

  @override
  String get noiseTitle => 'Hluk';

  @override
  String get reloadTitle => 'Přebít';

  @override
  String get rivenDispositionTitle => 'Dispozice Rivenu';

  @override
  String get statusChanceTitle => 'Šance Stavu';

  @override
  String get triggerTitle => 'Spoušť';

  @override
  String get damageTitle => 'Poškození';

  @override
  String get totalDamageTitle => 'Celkové Poškození';

  @override
  String get stancePolarityTitle => 'Postavení Polarity';

  @override
  String get attackSpeedTitle => 'Rychlost Útoku';

  @override
  String get followThroughTitle => 'Follow Through';

  @override
  String get rangeTitle => 'Dosah';

  @override
  String get slamAttackTitle => 'Útok Bouchnutí';

  @override
  String get slamRadialDamageTitle => 'Radiální Poškození Bouchnutí';

  @override
  String get slamRadiusTitle => 'Radius Bouchnutí';

  @override
  String get slideAttackTitle => 'Útok Sklouznutí';

  @override
  String get heavyAttackTitle => 'Těžký Útok';

  @override
  String get heavySlamAttackTitle => 'Těžký Útok Bouchnutí';

  @override
  String get heavySlamRadialDamageTitle => 'Radiální Poškození Bouchnutí';

  @override
  String get heavySlamRadiusTitle => 'Těžký Radius Bouchnutí';

  @override
  String get windUpTitle => 'Vítr Nahoru';

  @override
  String get discordSupportTitle => 'Podpora';

  @override
  String get steelPathTitle => 'Steel Path';

  @override
  String get syndicateDualScreenTitle => 'Vybrat Syndikát';

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
  String get duviriJoy => 'Joy';

  @override
  String get duviriAnger => 'Anger';

  @override
  String get duviriEnvy => 'Envy';

  @override
  String get duviriSorrow => 'Sorrow';

  @override
  String get duviriFear => 'Fear';

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
  String get archimedeaResetTitle => 'Resets in';

  @override
  String get deepArchimedeaTitle => 'Deep Archimedea';

  @override
  String get temporalArchimedeaTitle => 'Temporal Archimedea';

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
  String get archimedeaWarningSubtitle =>
      'DE doesn\'t always update Deep/Temporal Archimedea data after a weekly reset so consider this unstable.\nWarning will be removed when data rotation is more consistent';

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
