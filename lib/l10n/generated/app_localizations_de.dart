// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class NavisLocalizationsDe extends NavisLocalizations {
  NavisLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Level: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Tippe für mehr Details';

  @override
  String get seeDetails => 'Details anzeigen';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Beschreibung';

  @override
  String get eventStatus => 'Event Fortschritt';

  @override
  String get eventStatusNode => 'Knoten';

  @override
  String get eventStatusProgress => 'Fortschritt';

  @override
  String get eventStatusEta => 'Verbleibende Zeit (ETA)';

  @override
  String get eventRewards => 'Belohnungen';

  @override
  String get bountyTitle => 'Aufträge';

  @override
  String get errorTitle => 'Ein Anwendungsfehler ist aufgetreten';

  @override
  String get errorDescription => 'Es gab einen unerwarteten Fehler im Kernsystem.\nFehler wird an den Systemadministrator gemeldet...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Location';

  @override
  String get baroLeavesOn => 'Reist ab am';

  @override
  String get baroArrivesOn => 'Ankunft am';

  @override
  String get baroInventory => 'Baro Ki\'Teer Inventar';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Endet am $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva wird aktualisiert in';

  @override
  String get formorianTitle => 'Formorian';

  @override
  String get razorbackTitle => 'Razerback';

  @override
  String get earthCycleTitle => 'Erde Zyklus';

  @override
  String get cetusCycleTitle => 'Cetus Zyklus';

  @override
  String get vallisCycleTitle => 'Vallis Zyklus';

  @override
  String get cambionCycleTitle => 'Cambion Zyklus';

  @override
  String get zarimanCycleTitle => 'Zariman Cycle';

  @override
  String get timersTitle => 'Timers';

  @override
  String get fissuresTitle => 'Void-Risse';

  @override
  String get invasionsTitle => 'Invasionen';

  @override
  String get syndicatesTitle => 'Syndikate';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Search all warframe items';

  @override
  String get helpfulLinksTitle => 'Hilfreiche Links';

  @override
  String get behaviorTitle => 'Verhalten';

  @override
  String get themeTitle => 'Thema';

  @override
  String get themeDescription => 'App-Theme auswählen.';

  @override
  String get notificationsTitle => 'Benachrichtigungen';

  @override
  String get rareAlertsNotificationTitle => 'Seltene Alarmierungen';

  @override
  String get rareAlertsNotificationDescription => 'Seltene Alarmierungsbeanachrichtigung, meist Geschenke von Lotus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Benachrichtigungen zu Baro\'s Ankunft und Abreise.';

  @override
  String get darvoNotificationTitle => 'Tägliche Deals von Darvo';

  @override
  String get darvoNotificationDescription => 'Darvo\'s neue Entdeckung des Tages.';

  @override
  String get sortieNotificationTitle => 'Einsatz';

  @override
  String get sortieNotificationDescription => 'Benachrichtigungen für neue Einsätze.';

  @override
  String get sentientOutpostNotificationTitle => 'Sentient Außenposten';

  @override
  String get sentientOutpostNotificationDescription => 'Benachrichtigungen für neue Sentient Bedrohungen.';

  @override
  String get warframeNewsTitle => 'News';

  @override
  String get warframeNewsNotificationTitle => 'Neuigkeiten';

  @override
  String get warframeNewsNotificationDescription => 'News-Benachrichtigungen für Prime Access, Streams und Updates.';

  @override
  String get planetCyclesNotificationTitle => 'Open World Zyklus';

  @override
  String get planetCyclesNotificationDescription => 'Open world Benachrichtigungen für den jeweiligen Zyklus.';

  @override
  String get resourcesNotificationTitle => 'Ressourcen';

  @override
  String get resourcesNotificationDescription => 'Ressourcen, die hauptsächlich in Invasionen gefunden werden.';

  @override
  String get fissuresNotificationTitle => 'Voidriss Missionen';

  @override
  String get fissuresNotificationDescription => 'Sortiere Voidrisse Benachrichtigungen nach bestimmten Missions Typ.';

  @override
  String get earthDayOption => 'Erde Tag';

  @override
  String get earthNightOption => 'Erde Nacht';

  @override
  String get cetusDayOption => 'Cetus Tag';

  @override
  String get cetusNightOption => 'Cetus Nacht';

  @override
  String get vallisWarmOption => 'Orb Vallis Warm';

  @override
  String get vallisColdOption => 'Orb Vallis Kalt';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Stream Bekannntgabungen';

  @override
  String get updateNewsOption => 'Warframe Update Neuigkeiten';

  @override
  String get reportBugsTitle => 'Fehler melden';

  @override
  String get reportBugsDescription => 'Fehler melden oder neue Funktionen vorschlagen.';

  @override
  String get aboutCategoryTitle => 'Über uns';

  @override
  String get aboutAppTitle => 'About app';

  @override
  String get contributeTranslationsTitle => 'Contribute Translations';

  @override
  String get contributeTranslationsDescription => 'Volunteer to contribute translations';

  @override
  String get lightThemeTitle => 'Hell';

  @override
  String get darkThemeTitle => 'Dunkel';

  @override
  String get systemThemeTitle => 'System';

  @override
  String get legalese => 'Warframe und das Warframe Logo sind eingetragene Warenzeichen von Digital Extremes Ltd. Weder Cephalon Navis oder WFCD sind in irgendeiner Weise mit Digital Extremes Ltd. verbunden.';

  @override
  String get homePageTitle => 'Home';

  @override
  String get sourceCode => 'Source code';

  @override
  String get issueTrackerDescription => 'Melde Probleme oder stelle Anfragen für dieses Projekt';

  @override
  String get issueTrackerTitle => 'Fehler-Tracker';

  @override
  String get warframeLinkTitle => 'Weitere Informationen zu Warframe finden Sie auf ihrer offiziellen Webseite';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get dailyRewardTitle => 'Reset Timer für Tägliche Belohnungen';

  @override
  String get eliteBadgeTitle => 'Elite';

  @override
  String get dailyNightwaveTitle => 'Täglich';

  @override
  String get weeklyNightwaveTitle => 'Wöchentlich';

  @override
  String get warframePassiveTitle => 'Passiv';

  @override
  String get auraTitle => 'Aura Polarität';

  @override
  String get preinstalledPolarities => 'Vorinstallierte Polaritäten';

  @override
  String get shieldTitle => 'Schild';

  @override
  String get armorTitle => 'Rüstung';

  @override
  String get healthTitle => 'Gesundheit';

  @override
  String get powerTitle => 'Kraft';

  @override
  String get sprintSpeedTitle => 'Sprintgeschwindigkeit';

  @override
  String get abilitiesTitle => 'Fähigkeiten';

  @override
  String get componentsTitle => 'Komponenten';

  @override
  String get masteryRequirementTitle => 'Meisterschaftsrang Anforderung';

  @override
  String get weaponTypeTitle => 'Waffentyp';

  @override
  String get accuracyTitle => 'Genauigkeit';

  @override
  String get criticalChanceTitle => 'Critical Chance';

  @override
  String get cricticalMultiplierTitle => 'Krit-Multiplikator';

  @override
  String get fireRateTitle => 'Feuerrate';

  @override
  String get magazineTitle => 'Magazin';

  @override
  String get multishotTitle => 'Mehrfachschuss';

  @override
  String get noiseTitle => 'Lärm';

  @override
  String get reloadTitle => 'Nachladen';

  @override
  String get rivenDispositionTitle => 'Riven Disposition';

  @override
  String get statusChanceTitle => 'Statuschance';

  @override
  String get triggerTitle => 'Auslöser';

  @override
  String get damageTitle => 'Schaden';

  @override
  String get totalDamageTitle => 'Gesamtschaden';

  @override
  String get stancePolarityTitle => 'Haltungs-Polarität';

  @override
  String get attackSpeedTitle => 'Angriffsgeschwindigkeit';

  @override
  String get followThroughTitle => 'Durchschlag';

  @override
  String get rangeTitle => 'Reichweite';

  @override
  String get slamAttackTitle => 'Slam Attacke';

  @override
  String get slamRadialDamageTitle => 'Slam Angriff Schaden';

  @override
  String get slamRadiusTitle => 'Slam Radius';

  @override
  String get slideAttackTitle => 'Slide Angriff';

  @override
  String get heavyAttackTitle => 'Schwerer Angriff';

  @override
  String get heavySlamAttackTitle => 'Schwerer Slam Angriff';

  @override
  String get heavySlamRadialDamageTitle => 'Schwerer Slam Angriff Schaden';

  @override
  String get heavySlamRadiusTitle => 'Schwerer Slam Radius';

  @override
  String get windUpTitle => 'Ausholen';

  @override
  String get discordSupportTitle => 'Support';

  @override
  String get steelPathTitle => 'Stählerner Pfad';

  @override
  String get syndicateDualScreenTitle => 'Syndikat auswählen';

  @override
  String get optOutOfAnalyticsTitle => 'Verlassen der Statistiken';

  @override
  String get optOutOfAnalyticsDescription => 'Statistiken deaktivieren.';

  @override
  String get appLangTitle => 'Sprache';

  @override
  String get appLangDescription => 'Standardverhalten für Spracherkennung überschreiben.';

  @override
  String modLevelLabel(int rank) {
    return 'Stufe $rank';
  }

  @override
  String get codexHint => 'Search here...';

  @override
  String get codexNoResults => 'Keine Treffer';

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
}
