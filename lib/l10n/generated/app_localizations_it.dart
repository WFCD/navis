// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class NavisLocalizationsIt extends NavisLocalizations {
  NavisLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Livello: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Tocca per maggiori dettagli';

  @override
  String get seeDetails => 'Vedi dettagli';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Descrizione';

  @override
  String get eventStatus => 'Stato evento';

  @override
  String get eventStatusNode => 'Nodo';

  @override
  String get eventStatusProgress => 'Progresso';

  @override
  String get eventStatusEta => 'Tempo rimanente';

  @override
  String get eventRewards => 'Ricompense';

  @override
  String get bountyTitle => 'Taglie';

  @override
  String get errorTitle => 'Si è verificato un errore dell\'applicazione';

  @override
  String get errorDescription => 'Si è verificato un errore imprevisto nel sistema centrale.\nSegnalando l\'errore all\'amministratore di sistema...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Location';

  @override
  String get baroLeavesOn => 'Parte';

  @override
  String get baroArrivesOn => 'Arriva';

  @override
  String get baroInventory => 'Inventario di Baro Ki\'Teer';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Termina $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva si aggiornerà in';

  @override
  String get formorianTitle => 'Fomorian';

  @override
  String get razorbackTitle => 'Razorback';

  @override
  String get earthCycleTitle => 'Ciclo Terra';

  @override
  String get cetusCycleTitle => 'Ciclo Cetus';

  @override
  String get vallisCycleTitle => 'Ciclo Vallis';

  @override
  String get cambionCycleTitle => 'Ciclo Cambion';

  @override
  String get zarimanCycleTitle => 'Ciclo Zariman';

  @override
  String get timersTitle => 'Timer';

  @override
  String get fissuresTitle => 'Fratture';

  @override
  String get invasionsTitle => 'Invasioni';

  @override
  String get syndicatesTitle => 'Associazioni';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Search all warframe items';

  @override
  String get helpfulLinksTitle => 'Link utili';

  @override
  String get behaviorTitle => 'Funzionalità';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeDescription => 'Scegli il tema dell\'app.';

  @override
  String get notificationsTitle => 'Notifiche';

  @override
  String get rareAlertsNotificationTitle => 'Allerte rare';

  @override
  String get rareAlertsNotificationDescription => 'Notifiche per allerte rare, solitamente doni di Lotus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Notifiche per gli arrivi e le partenze di Baro.';

  @override
  String get darvoNotificationTitle => 'Sconto giornaliero di Darvo';

  @override
  String get darvoNotificationDescription => 'La nuova offerta del giorno di Darvo.';

  @override
  String get sortieNotificationTitle => 'Incursione';

  @override
  String get sortieNotificationDescription => 'Notifiche per nuove incursioni.';

  @override
  String get sentientOutpostNotificationTitle => 'Avamposti senzienti';

  @override
  String get sentientOutpostNotificationDescription => 'Notifiche per nuove minacce senzienti.';

  @override
  String get warframeNewsTitle => 'Novità';

  @override
  String get warframeNewsNotificationTitle => 'Novità';

  @override
  String get warframeNewsNotificationDescription => 'Notifiche di notizie per Accesso Prime, stream e aggiornamenti.';

  @override
  String get planetCyclesNotificationTitle => 'Cicli dei mondi aperti';

  @override
  String get planetCyclesNotificationDescription => 'Notifiche per i cicli dei mondi aperti.';

  @override
  String get resourcesNotificationTitle => 'Risorse';

  @override
  String get resourcesNotificationDescription => 'Risorse trovate principalmente nelle invasioni.';

  @override
  String get fissuresNotificationTitle => 'Missioni delle fratture';

  @override
  String get fissuresNotificationDescription => 'Filtra le notifiche delle fratture in base al tipo di missione preferito.';

  @override
  String get earthDayOption => 'Terra giorno';

  @override
  String get earthNightOption => 'Terra notte';

  @override
  String get cetusDayOption => 'Cetus giorno';

  @override
  String get cetusNightOption => 'Cetus notte';

  @override
  String get vallisWarmOption => 'Orb Vallis caldo';

  @override
  String get vallisColdOption => 'Orb Vallis freddo';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Accesso Prime';

  @override
  String get streamNewsOption => 'Annunci di stream';

  @override
  String get updateNewsOption => 'Notizie degli aggiornamenti';

  @override
  String get reportBugsTitle => 'Segnala bug';

  @override
  String get reportBugsDescription => 'Segnala un bug o suggerisci nuove funzionalità.';

  @override
  String get aboutCategoryTitle => 'Informazioni';

  @override
  String get aboutAppTitle => 'About app';

  @override
  String get contributeTranslationsTitle => 'Contribute Translations';

  @override
  String get contributeTranslationsDescription => 'Volunteer to contribute translations';

  @override
  String get lightThemeTitle => 'Chiaro';

  @override
  String get darkThemeTitle => 'Scuro';

  @override
  String get systemThemeTitle => 'Sistema';

  @override
  String get legalese => 'Warframe e il logo Warframe sono marchi registrati di Digital Extremes Ltd. Cephalon Navis e WFCD non sono affiliati a Digital Extremes Ltd. in alcun modo.';

  @override
  String get homePageTitle => 'Home';

  @override
  String get sourceCode => 'Source code';

  @override
  String get issueTrackerDescription => 'Segnala problemi o suggerisci nuove funzionalità per questo progetto:';

  @override
  String get issueTrackerTitle => 'issue tracker';

  @override
  String get warframeLinkTitle => 'Maggiori informazioni su Warframe possono essere trovate sul sito ufficiale';

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get dailyRewardTitle => 'Reset delle ricompense giornaliere';

  @override
  String get eliteBadgeTitle => 'Elite';

  @override
  String get dailyNightwaveTitle => 'Giornaliera';

  @override
  String get weeklyNightwaveTitle => 'Settimanale';

  @override
  String get warframePassiveTitle => 'Passiva';

  @override
  String get auraTitle => 'Polarità aura';

  @override
  String get preinstalledPolarities => 'Polarità preinstallate';

  @override
  String get shieldTitle => 'Scudo';

  @override
  String get armorTitle => 'Armatura';

  @override
  String get healthTitle => 'Salute';

  @override
  String get powerTitle => 'Energia';

  @override
  String get sprintSpeedTitle => 'Velocità scatto';

  @override
  String get abilitiesTitle => 'Abilità';

  @override
  String get componentsTitle => 'Componenti';

  @override
  String get masteryRequirementTitle => 'Maestria richiesta';

  @override
  String get weaponTypeTitle => 'Tipologia arma';

  @override
  String get accuracyTitle => 'Precisione';

  @override
  String get criticalChanceTitle => 'Probabilità critico';

  @override
  String get cricticalMultiplierTitle => 'Moltiplicatore critico';

  @override
  String get fireRateTitle => 'Rateo di fuoco';

  @override
  String get magazineTitle => 'Caricatore';

  @override
  String get multishotTitle => 'Sparo multiplo';

  @override
  String get noiseTitle => 'Rumore';

  @override
  String get reloadTitle => 'Ricarica';

  @override
  String get rivenDispositionTitle => 'Propensione Riven';

  @override
  String get statusChanceTitle => 'Probabilità effetto';

  @override
  String get triggerTitle => 'Azione';

  @override
  String get damageTitle => 'Danno';

  @override
  String get totalDamageTitle => 'Danno totale';

  @override
  String get stancePolarityTitle => 'Polarità Stile';

  @override
  String get attackSpeedTitle => 'Velocità Attacco';

  @override
  String get followThroughTitle => 'Continuazione';

  @override
  String get rangeTitle => 'Portata';

  @override
  String get slamAttackTitle => 'Schianto A Terra';

  @override
  String get slamRadialDamageTitle => 'Danno Ad Area Schianto';

  @override
  String get slamRadiusTitle => 'Raggio Schianto A Terra';

  @override
  String get slideAttackTitle => 'Attacco In Scivolata';

  @override
  String get heavyAttackTitle => 'Attacco Pesante';

  @override
  String get heavySlamAttackTitle => 'Danno Schianto Pesante';

  @override
  String get heavySlamRadialDamageTitle => 'Danno Ad Area Schianto Pesante';

  @override
  String get heavySlamRadiusTitle => 'Raggio Schianto Pesante';

  @override
  String get windUpTitle => 'Recupero';

  @override
  String get discordSupportTitle => 'Assistenza';

  @override
  String get steelPathTitle => 'Percorso D\'Acciaio';

  @override
  String get syndicateDualScreenTitle => 'Scegli associazione';

  @override
  String get optOutOfAnalyticsTitle => 'Disabilita raccolta dati';

  @override
  String get optOutOfAnalyticsDescription => 'Disabilita raccolta dati statistici.';

  @override
  String get appLangTitle => 'Lingua';

  @override
  String get appLangDescription => 'Ignora la lingua rilevata come predefinita di sistema.';

  @override
  String modLevelLabel(int rank) {
    return 'Livello: $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'Nessun risultato';

  @override
  String get codexVaultedLabel => 'Nel vault';

  @override
  String get exploreTitle => 'Esplora';

  @override
  String get constructionProgressTitle => 'Progresso Costruzione';

  @override
  String get synthTargetTitle => 'Obiettivi Sintesi';

  @override
  String get archonHuntTitle => 'Caccia Archon';

  @override
  String get archonHuntDescription => 'Notifica di reset della caccia Archon.';

  @override
  String get allFissuresButton => 'Tutte';

  @override
  String get voidStormFissuresButton => 'Tempeste Void';

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
  String get enterUsernameHintText => 'Enter username';

  @override
  String get clearUsernameButtonLabel => 'Clear username';

  @override
  String get cancelText => 'Cancel';
}
