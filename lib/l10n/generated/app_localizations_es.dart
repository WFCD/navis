// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class NavisLocalizationsEs extends NavisLocalizations {
  NavisLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Nivel: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Pulsa para más detalles';

  @override
  String get seeDetails => 'Ver detalles';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Descripción';

  @override
  String get eventStatus => 'Estado del evento';

  @override
  String get eventStatusNode => 'Nodo';

  @override
  String get eventStatusProgress => 'Progreso';

  @override
  String get eventStatusEta => 'Tiempo restante (estimado)';

  @override
  String get eventRewards => 'Recompensas';

  @override
  String get bountyTitle => 'Contratos';

  @override
  String get errorTitle => 'Ocurrió un error en la aplicación';

  @override
  String get errorDescription => 'Hubo un error inesperado en el sistema central.\nReportando el error al administrador del sistema...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Ubicación';

  @override
  String get baroLeavesOn => 'Se va en';

  @override
  String get baroArrivesOn => 'Llega en';

  @override
  String get baroInventory => 'Inventario de Baro Ki\'Teer';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Termina en $dateString';
  }

  @override
  String get kuvaBanner => 'El kuva se actualizará en';

  @override
  String get formorianTitle => 'Fomorian';

  @override
  String get razorbackTitle => 'Razorback';

  @override
  String get earthCycleTitle => 'Ciclo de la Tierra';

  @override
  String get cetusCycleTitle => 'Ciclo de Cetus';

  @override
  String get vallisCycleTitle => 'Ciclo de Vallis';

  @override
  String get cambionCycleTitle => 'Ciclo de Cambion';

  @override
  String get zarimanCycleTitle => 'Ciclo de Zariman';

  @override
  String get timersTitle => 'Contadores';

  @override
  String get fissuresTitle => 'Fisuras';

  @override
  String get invasionsTitle => 'Invasiones';

  @override
  String get syndicatesTitle => 'Sindicatos';

  @override
  String get codexTitle => 'Codice';

  @override
  String get codexDescription => 'Buscar en todos los objetos del juego';

  @override
  String get helpfulLinksTitle => 'Enlaces útiles';

  @override
  String get behaviorTitle => 'General';

  @override
  String get themeTitle => 'Aspecto';

  @override
  String get themeDescription => 'Elige el aspecto de la aplicación.';

  @override
  String get notificationsTitle => 'Notificaciones';

  @override
  String get rareAlertsNotificationTitle => 'Alertas raras';

  @override
  String get rareAlertsNotificationDescription => 'Notificaciones de alerta raras, principalmente regalos de lotus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Notificaciones de Baro de llegada y de salida.';

  @override
  String get darvoNotificationTitle => 'Oferta diaria de Darvo';

  @override
  String get darvoNotificationDescription => 'El nuevo hallazgo de Darvo del día.';

  @override
  String get sortieNotificationTitle => 'Incursión';

  @override
  String get sortieNotificationDescription => 'Notificaciones para nuevas incursiones.';

  @override
  String get sentientOutpostNotificationTitle => 'Puesto avanzado sentient';

  @override
  String get sentientOutpostNotificationDescription => 'Notificaciones para nuevas amenazas sentient.';

  @override
  String get warframeNewsTitle => 'Noticias';

  @override
  String get warframeNewsNotificationTitle => 'Noticias';

  @override
  String get warframeNewsNotificationDescription => 'Notificaciones de noticias del Prime Access, directos y actualizaciones.';

  @override
  String get planetCyclesNotificationTitle => 'Ciclos de los mundos abiertos';

  @override
  String get planetCyclesNotificationDescription => 'Notificaciones para ciclos del mundo abierto.';

  @override
  String get resourcesNotificationTitle => 'Recursos';

  @override
  String get resourcesNotificationDescription => 'Recursos que se encuentran principalmente en las invasiones.';

  @override
  String get fissuresNotificationTitle => 'Misiones de fisuras';

  @override
  String get fissuresNotificationDescription => 'Filtrar notificaciones de fisura por tipo de misión preferida.';

  @override
  String get earthDayOption => 'Tierra de día';

  @override
  String get earthNightOption => 'Tierra de noche';

  @override
  String get cetusDayOption => 'Cetus de día';

  @override
  String get cetusNightOption => 'Cetus de noche';

  @override
  String get vallisWarmOption => 'Valles del orbe calido';

  @override
  String get vallisColdOption => 'Valles del orbe frío';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Anuncios de directos';

  @override
  String get updateNewsOption => 'Noticias de Warframe';

  @override
  String get reportBugsTitle => 'Reportar errores';

  @override
  String get reportBugsDescription => 'Reportar errores o solicitar nuevas características.';

  @override
  String get aboutCategoryTitle => 'Acerca de';

  @override
  String get aboutAppTitle => 'Acerca de la app';

  @override
  String get contributeTranslationsTitle => 'Contribuir con la traducción';

  @override
  String get contributeTranslationsDescription => 'Ser voluntario para contribuir con las traducciones';

  @override
  String get lightThemeTitle => 'Claro';

  @override
  String get darkThemeTitle => 'Oscuro';

  @override
  String get systemThemeTitle => 'Sistema';

  @override
  String get legalese => 'El logotipo de Warframe y Warframe son marcas registradas de Digital Extremes Ltd. Cephalon Navis y WFCD están afiliados a Digital Extremes Ltd. de cualquier modo.';

  @override
  String get homePageTitle => 'Inicio';

  @override
  String get sourceCode => 'Código fuente';

  @override
  String get issueTrackerDescription => 'Reporta problemas o solicitudes para este proyecto';

  @override
  String get issueTrackerTitle => 'registros de problemas';

  @override
  String get warframeLinkTitle => 'Más información sobre Warframe se puede encontrar en su página oficial';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get dailyRewardTitle => 'Tiempo para el reinicio de las Recompensas Diarias';

  @override
  String get eliteBadgeTitle => 'Élite';

  @override
  String get dailyNightwaveTitle => 'Diario';

  @override
  String get weeklyNightwaveTitle => 'Semanal';

  @override
  String get warframePassiveTitle => 'Pasivo';

  @override
  String get auraTitle => 'Polaridad de Aura';

  @override
  String get preinstalledPolarities => 'Polaridades preinstaladas';

  @override
  String get shieldTitle => 'Escudo';

  @override
  String get armorTitle => 'Armadura';

  @override
  String get healthTitle => 'Salud';

  @override
  String get powerTitle => 'Poder';

  @override
  String get sprintSpeedTitle => 'Velocidad de Sprint';

  @override
  String get abilitiesTitle => 'Habilidades';

  @override
  String get componentsTitle => 'Componentes';

  @override
  String get masteryRequirementTitle => 'Requisito de maestría';

  @override
  String get weaponTypeTitle => 'Tipo de arma';

  @override
  String get accuracyTitle => 'Precisión';

  @override
  String get criticalChanceTitle => 'Probabilidad Crítica';

  @override
  String get cricticalMultiplierTitle => 'Multiplicador Crítico';

  @override
  String get fireRateTitle => 'Cadencia de disparo';

  @override
  String get magazineTitle => 'Capacidad de munición';

  @override
  String get multishotTitle => 'Multidisparo';

  @override
  String get noiseTitle => 'Ruido';

  @override
  String get reloadTitle => 'Recargar';

  @override
  String get rivenDispositionTitle => 'Disposición del Agrietado';

  @override
  String get statusChanceTitle => 'Probabilidad de Estado';

  @override
  String get triggerTitle => 'Disparador';

  @override
  String get damageTitle => 'Daño';

  @override
  String get totalDamageTitle => 'Daño Total';

  @override
  String get stancePolarityTitle => 'Polaridad de la Guardia';

  @override
  String get attackSpeedTitle => 'Velocidad de Ataque';

  @override
  String get followThroughTitle => 'Continuidad de Ataque';

  @override
  String get rangeTitle => 'Rango';

  @override
  String get slamAttackTitle => 'Golpe contra el suelo';

  @override
  String get slamRadialDamageTitle => 'Alcance de golpe contra el suelo';

  @override
  String get slamRadiusTitle => 'Radio de golpe contra el suelo';

  @override
  String get slideAttackTitle => 'Ataque Deslizante';

  @override
  String get heavyAttackTitle => 'Ataque Cargado';

  @override
  String get heavySlamAttackTitle => 'Ataque de golpe pesado contra el suelo';

  @override
  String get heavySlamRadialDamageTitle => 'Daño radial de golpe pesado contra el suelo';

  @override
  String get heavySlamRadiusTitle => 'Radio de golpe pesado contra el suelo';

  @override
  String get windUpTitle => 'Lanzamiento';

  @override
  String get discordSupportTitle => 'Soporte';

  @override
  String get steelPathTitle => 'Camino de Acero';

  @override
  String get syndicateDualScreenTitle => 'Seleccionar Sindicato';

  @override
  String get optOutOfAnalyticsTitle => 'Análisis de datos';

  @override
  String get optOutOfAnalyticsDescription => 'Deshabilitar análisis de datos.';

  @override
  String get appLangTitle => 'Idioma';

  @override
  String get appLangDescription => 'Sobreescribir la configuración predeterminada para la detección del idioma.';

  @override
  String modLevelLabel(int rank) {
    return 'Nivel $rank';
  }

  @override
  String get codexHint => 'Busque aquí...';

  @override
  String get codexNoResults => 'Sin resultados';

  @override
  String get codexVaultedLabel => 'En la Bóveda Prime';

  @override
  String get exploreTitle => 'Explorar';

  @override
  String get constructionProgressTitle => 'Progreso de Construcción';

  @override
  String get synthTargetTitle => 'Objetivos de Síntesis';

  @override
  String get archonHuntTitle => 'Cacería de Arcontes';

  @override
  String get archonHuntDescription => 'Notificación del reinicio de la Cacería de Arcontes.';

  @override
  String get allFissuresButton => 'Todo';

  @override
  String get voidStormFissuresButton => 'Fisuras del Vacío';

  @override
  String get saleEndsTitle => 'EL DESCUENTO TERMINA';

  @override
  String get salePriceTitle => 'Precio de venta';

  @override
  String get originalPriceTitle => 'Precio Original';

  @override
  String discountTitle(Object discount) {
    return '$discount% de descuento!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Solo queda $stock';
  }

  @override
  String get outOfStockTitle => 'AGOTADO';

  @override
  String get duviriJoy => 'Espiral: Alegría';

  @override
  String get duviriAnger => 'Espiral: Ira';

  @override
  String get duviriEnvy => 'Espiral: Envidia';

  @override
  String get duviriSorrow => 'Espiral: Tristeza';

  @override
  String get duviriFear => 'Espiral: Miedo';

  @override
  String get mapTitle => 'Mapas';

  @override
  String get mapDescription => 'Ver regiones del mapa';

  @override
  String get fishTitle => 'Pescado';

  @override
  String get fishDescription => 'Ver información de peces por región';

  @override
  String get fishName => 'Nombre';

  @override
  String get fishTime => 'Tiempo';

  @override
  String get fishSpear => 'Arpón';

  @override
  String get fishRarity => 'Rareza';

  @override
  String get fishBait => 'Carnada';

  @override
  String get fishStanding => 'Reputación';

  @override
  String get fishUnique => 'Único';

  @override
  String get fishBladder => 'Vejiga';

  @override
  String get fishGills => 'Branquias';

  @override
  String get fishTumors => 'Tumores';

  @override
  String get fishMeat => 'Carne';

  @override
  String get fishOil => 'Aceite';

  @override
  String get fishScales => 'Escamas';

  @override
  String get fishScrap => 'Chatarra';

  @override
  String get fishAny => 'Cualquiera';

  @override
  String dropChance(Object chance) {
    return 'Probabilidad de obtención: $chance%';
  }

  @override
  String get statsTitle => 'Estadísticas';

  @override
  String get patchlogsTitle => 'Nota de cambios';

  @override
  String get impactDamageTitle => 'Impacto';

  @override
  String get punctureDamageTitle => 'Perforación';

  @override
  String get slashDamageTitle => 'Cortante';

  @override
  String get heatDamageTitle => 'Calor';

  @override
  String get coldDamageTitle => 'Frio';

  @override
  String get electricityDamageTitle => 'Eléctrico';

  @override
  String get toxinDamageTitle => 'Toxina';

  @override
  String get blastDamageTitle => 'Explosivo';

  @override
  String get radiationDamageTitle => 'Radiación';

  @override
  String get gasDamageTitle => 'Gas';

  @override
  String get magneticDamageTitle => 'Magnético';

  @override
  String get viralDamageTitle => 'Viral';

  @override
  String get corrosiveDamageTitle => 'Corrosivo';

  @override
  String get voidDamageTitle => 'Vacío';

  @override
  String get tauDamageTitle => 'Tau';

  @override
  String get cinematicDamageTitle => 'Cinemática';

  @override
  String get shieldDrainDamageTitle => 'Drenaje de Escudo';

  @override
  String get healthDrainDamageTitle => 'Drenaje de Salud';

  @override
  String get energyDrainDamageTitle => 'Drenaje de Energía';

  @override
  String get physicalDamageTitle => 'Físico';

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
}
