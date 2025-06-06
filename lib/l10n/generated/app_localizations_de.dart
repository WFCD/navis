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
  String get seeMore => 'Mehr anzeigen';

  @override
  String get seeWiki => 'Wiki durchsuchen';

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
  String get errorDescription =>
      'Es gab einen unerwarteten Fehler im Kernsystem.\nFehler wird an den Systemadministrator gemeldet...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Ort';

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
  String get cetusCycleTitle => 'Erde/Ebenen des Eidolons';

  @override
  String get vallisCycleTitle => 'Orbis-Tal';

  @override
  String get cambionCycleTitle => 'Cambion Drift';

  @override
  String get zarimanCycleTitle => 'Zariman';

  @override
  String get duviriCycleTitle => 'Duviri';

  @override
  String get timersTitle => 'Alarme';

  @override
  String get fissuresTitle => 'Void-Risse';

  @override
  String get invasionsTitle => 'Invasionen';

  @override
  String get syndicatesTitle => 'Syndikate';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Alle Warframe-Objekte durchsuchen';

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
  String get rareAlertsNotificationDescription => 'Seltene Alarmierungsbenachrichtigung, meist Geschenke von Lotus.';

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
  String get warframeNewsTitle => 'Neuigkeiten';

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
  String get vallisWarmOption => 'Orbis-Tal: Warm';

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
  String get aboutAppTitle => 'Über diese App';

  @override
  String get contributeTranslationsTitle => 'Übersetzungen beisteuern';

  @override
  String get contributeTranslationsDescription => 'Trage zur Übersetzung bei';

  @override
  String get lightThemeTitle => 'Hell';

  @override
  String get darkThemeTitle => 'Dunkel';

  @override
  String get systemThemeTitle => 'System';

  @override
  String get legalese =>
      'Warframe und das Warframe Logo sind eingetragene Warenzeichen von Digital Extremes Ltd. Weder Cephalon Navis oder WFCD sind in irgendeiner Weise mit Digital Extremes Ltd. verbunden.';

  @override
  String get homePageTitle => 'Startseite';

  @override
  String get sourceCode => 'Quellcode';

  @override
  String get issueTrackerDescription => 'Melde Probleme oder stelle Anfragen für dieses Projekt';

  @override
  String get issueTrackerTitle => 'Fehler-Tracker';

  @override
  String get warframeLinkTitle => 'Weitere Informationen zu Warframe finden Sie auf ihrer offiziellen Webseite';

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get dailyResetTitle => 'Tägliche Aktualiseriung';

  @override
  String get weeklyResetTitle => 'Wöchentliche Aktualiseriung';

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
  String get criticalChanceTitle => 'Krit. Chance';

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
  String get rivenDispositionTitle => 'Riven-Disposition';

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
  String get slamRadiusTitle => 'Schmetter-Radius';

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
  String get discordSupportTitle => 'Hilfe';

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
  String get codexHint => 'Durchsuche den Codex hier …';

  @override
  String get codexNoResults => 'Keine Treffer';

  @override
  String get codexVaultedLabel => 'Vaulted (verschlossen)';

  @override
  String get exploreTitle => 'Entdecken';

  @override
  String get constructionProgressTitle => 'Baufortschritt';

  @override
  String get synthTargetTitle => 'Synthese-Ziele';

  @override
  String get archonHuntTitle => 'Archonenjagd';

  @override
  String get archonHuntDescription => 'Archon Jagd Aktualisierungsbenachrichtigung.';

  @override
  String get allFissuresButton => 'Alle';

  @override
  String get voidStormFissuresButton => 'Void-Stürme';

  @override
  String get saleEndsTitle => 'VERKAUF ENDET';

  @override
  String get salePriceTitle => 'Verkaufspreis';

  @override
  String get originalPriceTitle => 'Ursprünglicher Preis';

  @override
  String discountTitle(Object discount) {
    return '$discount% Rabatt!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Nur noch $stock übrig';
  }

  @override
  String get outOfStockTitle => 'AUSVERKAUFT';

  @override
  String get duviriJoy => 'Freude';

  @override
  String get duviriAnger => 'Anger';

  @override
  String get duviriEnvy => 'Neid';

  @override
  String get duviriSorrow => 'Trauer';

  @override
  String get duviriFear => 'Angst';

  @override
  String get mapTitle => 'Karten';

  @override
  String get mapDescription => 'Regionskarten ansehen';

  @override
  String get fishTitle => 'Fische';

  @override
  String get fishDescription => 'Fischinformationen nach Region filtern';

  @override
  String get fishName => 'Name';

  @override
  String get fishTime => 'Zeitraum';

  @override
  String get fishSpear => 'Harpune';

  @override
  String get fishRarity => 'Seltenheitsgrad';

  @override
  String get fishBait => 'Köder';

  @override
  String get fishStanding => 'Ansehen';

  @override
  String get fishUnique => 'Besonderheit';

  @override
  String get fishBladder => 'Blase';

  @override
  String get fishGills => 'Kiemen';

  @override
  String get fishTumors => 'Tumore';

  @override
  String get fishMeat => 'Fleisch';

  @override
  String get fishOil => 'Öl';

  @override
  String get fishScales => 'Schuppen';

  @override
  String get fishScrap => 'Schrott';

  @override
  String get fishAny => 'Beliebig';

  @override
  String dropChance(Object chance) {
    return 'Beute-/Ressourcenchance $chance%';
  }

  @override
  String get statsTitle => 'Stats';

  @override
  String get patchlogsTitle => 'Patchlogs';

  @override
  String get impactDamageTitle => 'Einschlag';

  @override
  String get punctureDamageTitle => 'Durchschlag';

  @override
  String get slashDamageTitle => 'Schnitt';

  @override
  String get heatDamageTitle => 'Hitze';

  @override
  String get coldDamageTitle => 'Kälte';

  @override
  String get electricityDamageTitle => 'Elektrizität';

  @override
  String get toxinDamageTitle => 'Gift';

  @override
  String get blastDamageTitle => 'Explosion';

  @override
  String get radiationDamageTitle => 'Strahlung';

  @override
  String get gasDamageTitle => 'Gas';

  @override
  String get magneticDamageTitle => 'Magnetismus';

  @override
  String get viralDamageTitle => 'Virus';

  @override
  String get corrosiveDamageTitle => 'Korrosion';

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
  String get energyDrainDamageTitle => 'Energieentzug';

  @override
  String get physicalDamageTitle => 'Physisch';

  @override
  String get circuitResetTitle => 'Der Rundkurs aktualisiert sich in';

  @override
  String get circuitResetSubtitle => 'Tippen, um aktuelle Angebote zu sehen';

  @override
  String get archimedeaResetTitle => 'Aktualisierung in';

  @override
  String get deepArchimedeaTitle => 'Tiefe Archimede';

  @override
  String get temporalArchimedeaTitle => 'Temporale Archimede';

  @override
  String get archimedeaDeviationTitle => 'Abweichung';

  @override
  String get archimedeaRiskTitle => 'Risikovariable';

  @override
  String get missionsCategoryTitle => 'Missionen';

  @override
  String get archimedeaPersonalModifierTitle => 'Persönliche Modifikatoren';

  @override
  String get archimedeaWarningTitle => 'Warnung';

  @override
  String get archimedeaWarningSubtitle =>
      'DE aktualisiert die Daten für die tiefe bzw. temporale Archimede nicht immer nach einem wöchentlichen Reset; betrachte diese Informationen unter Vorbehalt.\nWarnung wird gelöscht, wenn die Datenrotation konsistenter ist';

  @override
  String get activitiesTitle => 'Aktivitäten';

  @override
  String nightwaveSeasonSubtitle(Object season) {
    return 'Saison $season';
  }

  @override
  String get calendar1999Title => '1999 Kalender';

  @override
  String get traderItemHeaderTitle => 'Item';

  @override
  String get traderDucatsHeaderTitle => 'Item';

  @override
  String get traderCreditsHeaderTitle => 'Item';

  @override
  String itemRankSubtitle(Object rank) {
    return 'Rang $rank';
  }

  @override
  String get syncingInfoText => 'Synchronisiere XP-Info';

  @override
  String get enterUsernameHintText => 'Inventar einrichten';

  @override
  String get clearUsernameButtonLabel => 'Benutzernamen löschen';

  @override
  String get cancelText => 'Abbrechen';

  @override
  String inventoriaSteps(String url) {
    return 'Cephalon Navis kann deine schreibgeschützten Profildaten verwenden, um deine Arsenal-XP und Meisterschafts-Auflistung zu verfolgen.\n\n1. Öffne $url auf einem Computer\n\n2. Lade deine EE.log oder Konto-ID von Cookies hoch\n\n3. Tippe auf \"Weiter\" und scannen Sie den generierten QR-Code';
  }

  @override
  String get profileSyncError => 'A problem occurred fetching your profile, you should file a bug report';
}
