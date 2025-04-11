// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class NavisLocalizationsPt extends NavisLocalizations {
  NavisLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Nível: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Toque para mais detalhes';

  @override
  String get seeDetails => 'Ver detalhes';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Descrição';

  @override
  String get eventStatus => 'Status do Evento';

  @override
  String get eventStatusNode => 'Nó';

  @override
  String get eventStatusProgress => 'Progresso';

  @override
  String get eventStatusEta => 'Tempo restante (ETA)';

  @override
  String get eventRewards => 'Recompensas';

  @override
  String get bountyTitle => 'Contratos';

  @override
  String get errorTitle => 'Ocorreu um erro na aplicação';

  @override
  String get errorDescription => 'Houve um erro inesperado no sistema central.\nReportando erro ao administrador do sistema...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Local';

  @override
  String get baroLeavesOn => 'Partindo em';

  @override
  String get baroArrivesOn => 'Chegando em';

  @override
  String get baroInventory => 'Baro Ki\'Teeer Inventário';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Termina em $dateString';
  }

  @override
  String get kuvaBanner => 'O Kuva será atualizado em';

  @override
  String get formorianTitle => 'Fomorian';

  @override
  String get razorbackTitle => 'Razorback';

  @override
  String get cetusCycleTitle => 'Ciclo de Cetus';

  @override
  String get vallisCycleTitle => 'Ciclo de Vallis';

  @override
  String get cambionCycleTitle => 'Cambion Cycle';

  @override
  String get zarimanCycleTitle => 'Ciclo Zariman';

  @override
  String get duviriCycleTitle => 'Duviri';

  @override
  String get timersTitle => 'Cronômetros';

  @override
  String get fissuresTitle => 'Fendas';

  @override
  String get invasionsTitle => 'Invasões';

  @override
  String get syndicatesTitle => 'Sindicatos';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => 'Procurar todos os itens de warframe';

  @override
  String get helpfulLinksTitle => 'Links úteis';

  @override
  String get behaviorTitle => 'Comportamento';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeDescription => 'Escolha o tema do aplicativo.';

  @override
  String get notificationsTitle => 'Notificações';

  @override
  String get rareAlertsNotificationTitle => 'Alerta Raros';

  @override
  String get rareAlertsNotificationDescription => 'Notificações de alertas raros, principalmente as doações de Lótus.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Notificações tanto da chegada quanto da partida do Baro.';

  @override
  String get darvoNotificationTitle => 'Ofertas Diárias de Darvo';

  @override
  String get darvoNotificationDescription => 'A nova achada de Darvo do dia.';

  @override
  String get sortieNotificationTitle => 'Incursão';

  @override
  String get sortieNotificationDescription => 'Notificações para novas incursões.';

  @override
  String get sentientOutpostNotificationTitle => 'Posto Avançado Sentient';

  @override
  String get sentientOutpostNotificationDescription => 'Notificações de novas ameaças Sentients.';

  @override
  String get warframeNewsTitle => 'Notícias';

  @override
  String get warframeNewsNotificationTitle => 'Novidades';

  @override
  String get warframeNewsNotificationDescription => 'Notificações de notícias para Prime Access, Streams e Atualizações.';

  @override
  String get planetCyclesNotificationTitle => 'Ciclos do Mundo Aberto';

  @override
  String get planetCyclesNotificationDescription => 'Notificações do mundo aberto para seus ciclos determinados.';

  @override
  String get resourcesNotificationTitle => 'Recursos';

  @override
  String get resourcesNotificationDescription => 'Recursos encontrados principalmente em invasões.';

  @override
  String get fissuresNotificationTitle => 'Missões de Fendas';

  @override
  String get fissuresNotificationDescription => 'Filtrar notificações de fendas por tipo de missão preferida.';

  @override
  String get earthDayOption => 'Dia da Terra';

  @override
  String get earthNightOption => 'Noite da Terra';

  @override
  String get cetusDayOption => 'Dia de Cetus';

  @override
  String get cetusNightOption => 'Noite de Cetus';

  @override
  String get vallisWarmOption => 'Aquecimento de Orb Vallis';

  @override
  String get vallisColdOption => 'Resfriamento Orb Vallis';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Anúncios de transmissão';

  @override
  String get updateNewsOption => 'Notícias de Atualização Warframe';

  @override
  String get reportBugsTitle => 'Reportar Erros';

  @override
  String get reportBugsDescription => 'Relatar falhas ou solicitar recursos.';

  @override
  String get aboutCategoryTitle => 'Sobre';

  @override
  String get aboutAppTitle => 'Sobre o Aplicativo';

  @override
  String get contributeTranslationsTitle => 'Contribuir para a tradução';

  @override
  String get contributeTranslationsDescription => 'Voluntário para contribuir com traduções';

  @override
  String get lightThemeTitle => 'Claro';

  @override
  String get darkThemeTitle => 'Escuro';

  @override
  String get systemThemeTitle => 'Sistema';

  @override
  String get legalese => 'Warframe e o logotipo do Warframe são marcas registradas da Digital Extremes Ltd. Cephalon Navis ou WFCD não têm afiliação com a Digital Extremes Ltd. de nenhuma forma.';

  @override
  String get homePageTitle => 'Início';

  @override
  String get sourceCode => 'Código-fonte';

  @override
  String get issueTrackerDescription => 'Relate problemas ou solicite funcionalidades para este projeto';

  @override
  String get issueTrackerTitle => 'rastreador de problemas';

  @override
  String get warframeLinkTitle => 'Mais informações sobre Warframe podem ser encontradas em seu site oficial';

  @override
  String get settingsTitle => 'Configurações';

  @override
  String get dailyResetTitle => 'Daily Reset Timer';

  @override
  String get weeklyResetTitle => 'Weekly Reset Timer';

  @override
  String get eliteBadgeTitle => 'Elite';

  @override
  String get dailyNightwaveTitle => 'Diário';

  @override
  String get weeklyNightwaveTitle => 'Semanal';

  @override
  String get warframePassiveTitle => 'Passivo';

  @override
  String get auraTitle => 'Polaridade de Aura';

  @override
  String get preinstalledPolarities => 'Polaridades pré-instaladas';

  @override
  String get shieldTitle => 'Escudo';

  @override
  String get armorTitle => 'Armadura';

  @override
  String get healthTitle => 'Vida';

  @override
  String get powerTitle => 'Energia';

  @override
  String get sprintSpeedTitle => 'Velocidade de corrida';

  @override
  String get abilitiesTitle => 'Habilidades';

  @override
  String get componentsTitle => 'Componentes';

  @override
  String get masteryRequirementTitle => 'Requisito de Maestria';

  @override
  String get weaponTypeTitle => 'Tipo de Arma';

  @override
  String get accuracyTitle => 'Precisão';

  @override
  String get criticalChanceTitle => 'Chance Crítica';

  @override
  String get cricticalMultiplierTitle => 'Multiplicador de Crítico';

  @override
  String get fireRateTitle => 'Cadência de Tiro';

  @override
  String get magazineTitle => 'Carregador';

  @override
  String get multishotTitle => 'Tiro Múltiplo';

  @override
  String get noiseTitle => 'Ruído';

  @override
  String get reloadTitle => 'Recarregar';

  @override
  String get rivenDispositionTitle => 'Disposição do Riven';

  @override
  String get statusChanceTitle => 'Chance de Status';

  @override
  String get triggerTitle => 'Gatilho';

  @override
  String get damageTitle => 'Dano';

  @override
  String get totalDamageTitle => 'Dano Total';

  @override
  String get stancePolarityTitle => 'Polaridade da Estação';

  @override
  String get attackSpeedTitle => 'Velocidade de Ataque';

  @override
  String get followThroughTitle => 'Acompanhamento';

  @override
  String get rangeTitle => 'Alcance';

  @override
  String get slamAttackTitle => 'Ataque de Impacto';

  @override
  String get slamRadialDamageTitle => 'Dano Radial de Impacto';

  @override
  String get slamRadiusTitle => 'Raio de Impacto';

  @override
  String get slideAttackTitle => 'Ataque Deslizante';

  @override
  String get heavyAttackTitle => 'Ataque Pesado';

  @override
  String get heavySlamAttackTitle => 'Impacto do Ataque Pesado';

  @override
  String get heavySlamRadialDamageTitle => 'Dano Radial de Impacto Pesado';

  @override
  String get heavySlamRadiusTitle => 'Raio de Impacto Pesado';

  @override
  String get windUpTitle => 'Conclusão';

  @override
  String get discordSupportTitle => 'Suporte';

  @override
  String get steelPathTitle => 'Percurso de Aço';

  @override
  String get syndicateDualScreenTitle => 'Selecione o Sindicato';

  @override
  String get optOutOfAnalyticsTitle => 'Optar por não analisar';

  @override
  String get optOutOfAnalyticsDescription => 'Desativar o Analytics.';

  @override
  String get appLangTitle => 'Idioma';

  @override
  String get appLangDescription => 'Sobrescrever o comportamento padrão para detecção de idioma.';

  @override
  String modLevelLabel(int rank) {
    return 'Nível $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'Nenhum resultado';

  @override
  String get codexVaultedLabel => 'No Vault';

  @override
  String get exploreTitle => 'Explorar';

  @override
  String get constructionProgressTitle => 'Progresso da Construção';

  @override
  String get synthTargetTitle => 'Alvo de Sintetize';

  @override
  String get archonHuntTitle => 'Caçada Archon';

  @override
  String get archonHuntDescription => 'Notificação de reinício de caçada de Archon.';

  @override
  String get allFissuresButton => 'Todos';

  @override
  String get voidStormFissuresButton => 'Tempestades do Void';

  @override
  String get saleEndsTitle => 'OFERTA TERMINA EM';

  @override
  String get salePriceTitle => 'Preço em oferta';

  @override
  String get originalPriceTitle => 'Preço Original';

  @override
  String discountTitle(Object discount) {
    return '$discount% DESCONTO!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Somente $stock restantes';
  }

  @override
  String get outOfStockTitle => 'FORA DE ESTOQUE';

  @override
  String get duviriJoy => 'Duviri Alegria';

  @override
  String get duviriAnger => 'Duviri Raiva';

  @override
  String get duviriEnvy => 'Duviri Inveja';

  @override
  String get duviriSorrow => 'Duviri Tristeza';

  @override
  String get duviriFear => 'Duviri Medo';

  @override
  String get mapTitle => 'Mapas';

  @override
  String get mapDescription => 'Ver mapas regionais';

  @override
  String get fishTitle => 'Peixe';

  @override
  String get fishDescription => 'Ver informações de peixe por região';

  @override
  String get fishName => 'Nome';

  @override
  String get fishTime => 'Tempo';

  @override
  String get fishSpear => 'Lança';

  @override
  String get fishRarity => 'Raridade';

  @override
  String get fishBait => 'Isca';

  @override
  String get fishStanding => 'Reputação';

  @override
  String get fishUnique => 'Único';

  @override
  String get fishBladder => 'Bexigas';

  @override
  String get fishGills => 'Guelras';

  @override
  String get fishTumors => 'Tumores';

  @override
  String get fishMeat => 'Carnes';

  @override
  String get fishOil => 'Óleos';

  @override
  String get fishScales => 'Escamas';

  @override
  String get fishScrap => 'Sucatas';

  @override
  String get fishAny => 'Qualquer';

  @override
  String dropChance(Object chance) {
    return 'Chance de drop $chance%';
  }

  @override
  String get statsTitle => 'Estatísticas';

  @override
  String get patchlogsTitle => 'Registros';

  @override
  String get impactDamageTitle => 'Impacto';

  @override
  String get punctureDamageTitle => 'Perfuração';

  @override
  String get slashDamageTitle => 'Cortante';

  @override
  String get heatDamageTitle => 'Ígneo';

  @override
  String get coldDamageTitle => 'Glacial';

  @override
  String get electricityDamageTitle => 'Elétrico';

  @override
  String get toxinDamageTitle => 'Tóxico';

  @override
  String get blastDamageTitle => 'Colisivo';

  @override
  String get radiationDamageTitle => 'Radiação';

  @override
  String get gasDamageTitle => 'Gasoso';

  @override
  String get magneticDamageTitle => 'Magnético';

  @override
  String get viralDamageTitle => 'Viral';

  @override
  String get corrosiveDamageTitle => 'Corrosivo';

  @override
  String get voidDamageTitle => 'Void';

  @override
  String get tauDamageTitle => 'Tau';

  @override
  String get cinematicDamageTitle => 'Cinemática';

  @override
  String get shieldDrainDamageTitle => 'Dreno de Escudo';

  @override
  String get healthDrainDamageTitle => 'Dreno de Saúde';

  @override
  String get energyDrainDamageTitle => 'Dreno de Energia';

  @override
  String get physicalDamageTitle => 'Físico';

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
