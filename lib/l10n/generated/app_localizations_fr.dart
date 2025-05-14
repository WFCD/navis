// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class NavisLocalizationsFr extends NavisLocalizations {
  NavisLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Niveau : $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Appuyez pour plus de détails';

  @override
  String get seeDetails => 'Voir les détails';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Description';

  @override
  String get eventStatus => 'Statut de l\'événement';

  @override
  String get eventStatusNode => 'Nœud';

  @override
  String get eventStatusProgress => 'Progression';

  @override
  String get eventStatusEta => 'Temps restant (estimé)';

  @override
  String get eventRewards => 'Récompenses';

  @override
  String get bountyTitle => 'Mises à Prix';

  @override
  String get errorTitle => 'Une erreur inattendue s’est produite';

  @override
  String get errorDescription => 'Il y a eu une erreur inattendue au sein du système.\nSignalement de l\'erreur à l\'administrateur du système...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Localisation';

  @override
  String get baroLeavesOn => 'Se retire le';

  @override
  String get baroArrivesOn => 'Arrive le';

  @override
  String get baroInventory => 'Baro Ki\'Teeer Inventory';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Se termine le $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva va s\'actualiser dans';

  @override
  String get formorianTitle => 'Fomorien';

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
  String get timersTitle => 'Minuteurs';

  @override
  String get fissuresTitle => 'Fissures';

  @override
  String get invasionsTitle => 'Invasions';

  @override
  String get syndicatesTitle => 'Syndicats';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Chercher parmi tous les Objets';

  @override
  String get helpfulLinksTitle => 'Liens utiles';

  @override
  String get behaviorTitle => 'Comportement';

  @override
  String get themeTitle => 'Thème';

  @override
  String get themeDescription => 'Choisir le thème de l\'application.';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get rareAlertsNotificationTitle => 'Alertes Rares';

  @override
  String get rareAlertsNotificationDescription => 'Notifications d\'alertes rares, principalement des cadeaux du Lotus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Notifications du départ & de l\'arrivée de Baro.';

  @override
  String get darvoNotificationTitle => 'Offres du jour de Darvo';

  @override
  String get darvoNotificationDescription => 'Nouvelle trouvaille de Darvo.';

  @override
  String get sortieNotificationTitle => 'Sortie';

  @override
  String get sortieNotificationDescription => 'Notifications de nouvelles sorties.';

  @override
  String get sentientOutpostNotificationTitle => 'Avant-poste Sentient';

  @override
  String get sentientOutpostNotificationDescription => 'Notifications de nouvelles menaces sentient.';

  @override
  String get warframeNewsTitle => 'Actualités';

  @override
  String get warframeNewsNotificationTitle => 'Actualités';

  @override
  String get warframeNewsNotificationDescription => 'Nouvelles notifications pour le Prime Access, les directs et les mises à jour.';

  @override
  String get planetCyclesNotificationTitle => 'Cycles des mondes ouverts';

  @override
  String get planetCyclesNotificationDescription => 'Ouvrir les notifications des mondes ouverts pour leurs cycles respectifs.';

  @override
  String get resourcesNotificationTitle => 'Ressources';

  @override
  String get resourcesNotificationDescription => 'Ressources principalement trouvées dans les invasions.';

  @override
  String get fissuresNotificationTitle => 'Missions de fissures';

  @override
  String get fissuresNotificationDescription => 'Filtrer les notifications de fissure par type de mission préféré.';

  @override
  String get earthDayOption => 'Jour Terrestre';

  @override
  String get earthNightOption => 'Nuit Terrestre';

  @override
  String get cetusDayOption => 'Cetus - Jour';

  @override
  String get cetusNightOption => 'Cetus - Nuit';

  @override
  String get vallisWarmOption => 'Vallée Orbis - Chaud';

  @override
  String get vallisColdOption => 'Vallée Orbis - Froid';

  @override
  String get cambionFassOption => 'Cambion - Fass';

  @override
  String get cambionVomeOption => 'Cambion - Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Annonces de Diff. en direct';

  @override
  String get updateNewsOption => 'Actualités des MAJ de Warframe';

  @override
  String get reportBugsTitle => 'Signaler un bug';

  @override
  String get reportBugsDescription => 'Signaler un bug ou proposer une fonctionnalité.';

  @override
  String get aboutCategoryTitle => 'À propos';

  @override
  String get aboutAppTitle => 'A propos de l\'application';

  @override
  String get contributeTranslationsTitle => 'Contribuer à la traduction';

  @override
  String get contributeTranslationsDescription => 'Soumettre sa candidature pour traduction';

  @override
  String get lightThemeTitle => 'Clair';

  @override
  String get darkThemeTitle => 'Sombre';

  @override
  String get systemThemeTitle => 'Automatique';

  @override
  String get legalese => 'Warframe et le logo Warframe sont des marques déposées de Digital Extremes Ltd. Cephalon Navis et WFCD ne sont en aucune façon affiliés à Digital Extremes Ltd.';

  @override
  String get homePageTitle => 'Accueil';

  @override
  String get sourceCode => 'Code source';

  @override
  String get issueTrackerDescription => 'Signaler un bug ou proposer une fonctionnalité';

  @override
  String get issueTrackerTitle => 'Suivi des incidents';

  @override
  String get warframeLinkTitle => 'Plus d\'informations sur le jeu Warframe peuvent être trouvées sur leur site officiel';

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get dailyResetTitle => 'Daily Reset Timer';

  @override
  String get weeklyResetTitle => 'Weekly Reset Timer';

  @override
  String get eliteBadgeTitle => 'Élite';

  @override
  String get dailyNightwaveTitle => 'Quotidien';

  @override
  String get weeklyNightwaveTitle => 'Hebdomadaire';

  @override
  String get warframePassiveTitle => 'Passif';

  @override
  String get auraTitle => 'Polarité d\'Aura';

  @override
  String get preinstalledPolarities => 'Polarités préinstallées';

  @override
  String get shieldTitle => 'Bouclier';

  @override
  String get armorTitle => 'Armure';

  @override
  String get healthTitle => 'Santé';

  @override
  String get powerTitle => 'Pouvoir';

  @override
  String get sprintSpeedTitle => 'Vitesse de course';

  @override
  String get abilitiesTitle => 'Capacités';

  @override
  String get componentsTitle => 'Composants';

  @override
  String get masteryRequirementTitle => 'Prérequis de niveau de maîtrise';

  @override
  String get weaponTypeTitle => 'Type d\'arme';

  @override
  String get accuracyTitle => 'Précision';

  @override
  String get criticalChanceTitle => 'Chances de critique';

  @override
  String get cricticalMultiplierTitle => 'Multiplicateur de dégâts critiques';

  @override
  String get fireRateTitle => 'Cadence de tir';

  @override
  String get magazineTitle => 'Chargeur';

  @override
  String get multishotTitle => 'Tir multiple';

  @override
  String get noiseTitle => 'Bruit';

  @override
  String get reloadTitle => 'Rechargement';

  @override
  String get rivenDispositionTitle => 'Disposition de Riven';

  @override
  String get statusChanceTitle => 'Chance de statut';

  @override
  String get triggerTitle => 'Déclencheur';

  @override
  String get damageTitle => 'Dégâts';

  @override
  String get totalDamageTitle => 'Dégâts totaux';

  @override
  String get stancePolarityTitle => 'Polarité de posture';

  @override
  String get attackSpeedTitle => 'Vitesse d\'attaque';

  @override
  String get followThroughTitle => 'Répercussion';

  @override
  String get rangeTitle => 'Portée';

  @override
  String get slamAttackTitle => 'Frappe au Sol';

  @override
  String get slamRadialDamageTitle => 'Dégâts radiaux de la Frappe au Sol';

  @override
  String get slamRadiusTitle => 'Rayon de la Frappe au Sol';

  @override
  String get slideAttackTitle => 'Attaque Glissée';

  @override
  String get heavyAttackTitle => 'Attaque Lourde';

  @override
  String get heavySlamAttackTitle => 'Frappe au Sol Lourde';

  @override
  String get heavySlamRadialDamageTitle => 'Dégâts radiaux de la Frappe au Sol Lourde';

  @override
  String get heavySlamRadiusTitle => 'Rayon de la Frappe au Sol Lourde';

  @override
  String get windUpTitle => 'Attaque Chargée';

  @override
  String get discordSupportTitle => 'Assistance';

  @override
  String get steelPathTitle => 'Route de l\'Acier';

  @override
  String get syndicateDualScreenTitle => 'Sélectionner un Syndicat';

  @override
  String get optOutOfAnalyticsTitle => 'Désactiver les traceurs d\'analyse';

  @override
  String get optOutOfAnalyticsDescription => 'Désactiver les traceurs d\'analyse.';

  @override
  String get appLangTitle => 'Langue';

  @override
  String get appLangDescription => 'Outrepasser le comportement par défaut de la détection de langue.';

  @override
  String modLevelLabel(int rank) {
    return 'Niveau $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'Pas de résultat';

  @override
  String get codexVaultedLabel => 'Vaulté';

  @override
  String get exploreTitle => 'Explorer';

  @override
  String get constructionProgressTitle => 'Avancement de la construction';

  @override
  String get synthTargetTitle => 'Cible de synthèse';

  @override
  String get archonHuntTitle => 'Chasse d\'Archonte';

  @override
  String get archonHuntDescription => 'Notification de réinitialisation de la chasse d\'Archonte.';

  @override
  String get allFissuresButton => 'Toutes';

  @override
  String get voidStormFissuresButton => 'Tempête du Néant';

  @override
  String get saleEndsTitle => 'Fin des Soldes';

  @override
  String get salePriceTitle => 'Prix soldé';

  @override
  String get originalPriceTitle => 'Prix de départ';

  @override
  String discountTitle(Object discount) {
    return '$discount% DE REDUCTION !';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Plus que $stock en stock !';
  }

  @override
  String get outOfStockTitle => 'EPUISÉ';

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
  String get mapTitle => 'Cartes';

  @override
  String get mapDescription => 'Voir la Carte des Régions';

  @override
  String get fishTitle => 'Poisson';

  @override
  String get fishDescription => 'Voir les informations des poissons par région';

  @override
  String get fishName => 'Nom';

  @override
  String get fishTime => 'Fen. de Capture';

  @override
  String get fishSpear => 'Lance';

  @override
  String get fishRarity => 'Rareté';

  @override
  String get fishBait => 'Appât';

  @override
  String get fishStanding => 'Gain de Standing';

  @override
  String get fishUnique => 'Ress. Unique';

  @override
  String get fishBladder => 'Vessie de Fermentation';

  @override
  String get fishGills => 'Branchies';

  @override
  String get fishTumors => 'Tumeur Bénigne Infestée';

  @override
  String get fishMeat => 'Viande de Poisson';

  @override
  String get fishOil => 'Huile de Poisson';

  @override
  String get fishScales => 'Écailles';

  @override
  String get fishScrap => 'Ferraille';

  @override
  String get fishAny => 'Peu importe';

  @override
  String dropChance(Object chance) {
    return '$chance% de chance de drop';
  }

  @override
  String get statsTitle => 'Stats';

  @override
  String get patchlogsTitle => 'Notes de Patch';

  @override
  String get impactDamageTitle => 'Impact';

  @override
  String get punctureDamageTitle => 'Perforation';

  @override
  String get slashDamageTitle => 'Tranchant';

  @override
  String get heatDamageTitle => 'Feu';

  @override
  String get coldDamageTitle => 'Glace';

  @override
  String get electricityDamageTitle => 'Electricité';

  @override
  String get toxinDamageTitle => 'Poison';

  @override
  String get blastDamageTitle => 'Explosif';

  @override
  String get radiationDamageTitle => 'Radiation';

  @override
  String get gasDamageTitle => 'Gaz';

  @override
  String get magneticDamageTitle => 'Magnétique';

  @override
  String get viralDamageTitle => 'Viral';

  @override
  String get corrosiveDamageTitle => 'Corrosif';

  @override
  String get voidDamageTitle => 'Néant';

  @override
  String get tauDamageTitle => 'Tau';

  @override
  String get cinematicDamageTitle => 'Brut';

  @override
  String get shieldDrainDamageTitle => 'Drain de Bouclier';

  @override
  String get healthDrainDamageTitle => 'Drain de Vie';

  @override
  String get energyDrainDamageTitle => 'Drain d\'Énergie';

  @override
  String get physicalDamageTitle => 'Dégâts de Mêlée';

  @override
  String get circuitResetTitle => 'Le circuit se réinitialise dans';

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
  String get archimedeaWarningTitle => 'Attention';

  @override
  String get archimedeaWarningSubtitle => 'DE doesn\'t always update Deep/Temporal Archimedea data after a weekly reset so consider this unstable.\nWarning will be removed when data rotation is more consistent';

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
