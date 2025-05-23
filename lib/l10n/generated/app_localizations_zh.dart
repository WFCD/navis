// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class NavisLocalizationsZh extends NavisLocalizations {
  NavisLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return '等級: $min - $max';
  }

  @override
  String get tapForMoreDetails => '點擊以查看更多詳細信息';

  @override
  String get seeDetails => '查看詳情';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => '介紹';

  @override
  String get eventStatus => '事件狀態';

  @override
  String get eventStatusNode => '節點';

  @override
  String get eventStatusProgress => '進度';

  @override
  String get eventStatusEta => '剩餘時間 (ETA)';

  @override
  String get eventRewards => '獎勵';

  @override
  String get bountyTitle => '賞金';

  @override
  String get errorTitle => '發生錯誤';

  @override
  String get errorDescription => '核心系統發生意外錯誤\n正在向系統管理員報告錯誤...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => '生成地點';

  @override
  String get baroLeavesOn => '離開在';

  @override
  String get baroArrivesOn => '到達在';

  @override
  String get baroInventory => 'Baro Ki\'Teeer Inventory';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return '完結於 $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva 將會刷新在';

  @override
  String get formorianTitle => '巨人战舰';

  @override
  String get razorbackTitle => '利刃豺狼';

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
  String get timersTitle => '計時器';

  @override
  String get fissuresTitle => '虛空裂縫';

  @override
  String get invasionsTitle => '入侵';

  @override
  String get syndicatesTitle => '集團';

  @override
  String get codexTitle => 'Codex';

  @override
  String get codexDescription => '搜尋全部 Warframe 物品';

  @override
  String get helpfulLinksTitle => '有用的連結';

  @override
  String get behaviorTitle => '喜好';

  @override
  String get themeTitle => '主題';

  @override
  String get themeDescription => '選擇主題';

  @override
  String get notificationsTitle => '通知';

  @override
  String get rareAlertsNotificationTitle => '稀有警報';

  @override
  String get rareAlertsNotificationDescription => '稀有警報通知，主要是Lotus的賞賜';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Baro Ki\'Teer 到達和離開的通知';

  @override
  String get darvoNotificationTitle => 'Darvo 的每天優惠';

  @override
  String get darvoNotificationDescription => 'Darvo 每天的新發現';

  @override
  String get sortieNotificationTitle => '突擊';

  @override
  String get sortieNotificationDescription => '新突襲通知';

  @override
  String get sentientOutpostNotificationTitle => 'Sentient 前哨';

  @override
  String get sentientOutpostNotificationDescription => '新 Sentient 威脅通知';

  @override
  String get warframeNewsTitle => '新聞';

  @override
  String get warframeNewsNotificationTitle => '新聞';

  @override
  String get warframeNewsNotificationDescription => 'Prime Access, Streams 和更新的通知';

  @override
  String get planetCyclesNotificationTitle => '開放世界循環';

  @override
  String get planetCyclesNotificationDescription => '開放世界循環通知';

  @override
  String get resourcesNotificationTitle => '資源';

  @override
  String get resourcesNotificationDescription => '主要在入侵中找到的資源';

  @override
  String get fissuresNotificationTitle => '裂縫任務';

  @override
  String get fissuresNotificationDescription => '通過喜好任務類型過濾裂縫通知';

  @override
  String get earthDayOption => '地球白天';

  @override
  String get earthNightOption => '地球黑夜';

  @override
  String get cetusDayOption => '希圖斯白天';

  @override
  String get cetusNightOption => '希圖斯黑夜';

  @override
  String get vallisWarmOption => '奥布山谷溫暖';

  @override
  String get vallisColdOption => '奥布山谷寒冷';

  @override
  String get cambionFassOption => '魔胎之境 Fass';

  @override
  String get cambionVomeOption => '魔胎之境 Vome';

  @override
  String get primeAccessNewsOption => 'Prime Access';

  @override
  String get streamNewsOption => 'Stream公告';

  @override
  String get updateNewsOption => 'Warframe 更新新聞';

  @override
  String get reportBugsTitle => '反饋問題';

  @override
  String get reportBugsDescription => '反饋問題或提交新功能請求';

  @override
  String get aboutCategoryTitle => '關於';

  @override
  String get aboutAppTitle => '關於應用程式';

  @override
  String get contributeTranslationsTitle => '提交翻譯';

  @override
  String get contributeTranslationsDescription => '志願者提交翻譯';

  @override
  String get lightThemeTitle => '淺色';

  @override
  String get darkThemeTitle => '深色';

  @override
  String get systemThemeTitle => '跟隨系統';

  @override
  String get legalese =>
      'Warframe 和 Warframe 標誌為 Digital Extremes Ltd. 的註冊商標。Cephalon Navis 和 WFCD 均不以任何方式隸屬於 Digital Extremes Ltd.。';

  @override
  String get homePageTitle => '主頁';

  @override
  String get sourceCode => '源代碼';

  @override
  String get issueTrackerDescription => 'Report issues or feature request for this project\'s';

  @override
  String get issueTrackerTitle => '問題追蹤器';

  @override
  String get warframeLinkTitle => '有關 Warframe 的更多資訊可以在其官方網站上找到';

  @override
  String get settingsTitle => '設定';

  @override
  String get dailyResetTitle => 'Daily Reset Timer';

  @override
  String get weeklyResetTitle => 'Weekly Reset Timer';

  @override
  String get eliteBadgeTitle => '精英';

  @override
  String get dailyNightwaveTitle => '每日';

  @override
  String get weeklyNightwaveTitle => '每週';

  @override
  String get warframePassiveTitle => '被動';

  @override
  String get auraTitle => '光環極性';

  @override
  String get preinstalledPolarities => '預先安裝的極性';

  @override
  String get shieldTitle => '護盾';

  @override
  String get armorTitle => '護甲';

  @override
  String get healthTitle => '生命值';

  @override
  String get powerTitle => '能量值';

  @override
  String get sprintSpeedTitle => '疾跑速度';

  @override
  String get abilitiesTitle => '技能';

  @override
  String get componentsTitle => '組件';

  @override
  String get masteryRequirementTitle => '段位等級要求';

  @override
  String get weaponTypeTitle => '武器類型';

  @override
  String get accuracyTitle => '精准度';

  @override
  String get criticalChanceTitle => '暴擊率';

  @override
  String get cricticalMultiplierTitle => '暴击倍率';

  @override
  String get fireRateTitle => '射速';

  @override
  String get magazineTitle => '彈夾';

  @override
  String get multishotTitle => '多重射擊';

  @override
  String get noiseTitle => '噪音';

  @override
  String get reloadTitle => '重裝子彈';

  @override
  String get rivenDispositionTitle => '裂罅倾向性';

  @override
  String get statusChanceTitle => '觸發機率';

  @override
  String get triggerTitle => '射擊類型';

  @override
  String get damageTitle => '傷害';

  @override
  String get totalDamageTitle => '總傷害';

  @override
  String get stancePolarityTitle => '架式極性';

  @override
  String get attackSpeedTitle => '攻速';

  @override
  String get followThroughTitle => '顺势';

  @override
  String get rangeTitle => '攻擊範圍';

  @override
  String get slamAttackTitle => '震地攻擊';

  @override
  String get slamRadialDamageTitle => '震地範圍傷害';

  @override
  String get slamRadiusTitle => '震地攻擊半徑';

  @override
  String get slideAttackTitle => '滑行攻擊';

  @override
  String get heavyAttackTitle => '重擊';

  @override
  String get heavySlamAttackTitle => '重震地攻擊';

  @override
  String get heavySlamRadialDamageTitle => '重震地範圍傷害';

  @override
  String get heavySlamRadiusTitle => '重震地攻擊範圍';

  @override
  String get windUpTitle => '畜力時間';

  @override
  String get discordSupportTitle => '技術支持';

  @override
  String get steelPathTitle => '鋼鐵之路';

  @override
  String get syndicateDualScreenTitle => '選擇集團';

  @override
  String get optOutOfAnalyticsTitle => '選擇退出分析計劃';

  @override
  String get optOutOfAnalyticsDescription => '停用分析';

  @override
  String get appLangTitle => '語言';

  @override
  String get appLangDescription => '覆寫預設語言檢測';

  @override
  String modLevelLabel(int rank) {
    return '等級 $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => '未能找到結果';

  @override
  String get codexVaultedLabel => '已入庫';

  @override
  String get exploreTitle => '探索';

  @override
  String get constructionProgressTitle => '建造進度';

  @override
  String get synthTargetTitle => '結合儀式';

  @override
  String get archonHuntTitle => '執政官狩獵';

  @override
  String get archonHuntDescription => '執政官狩獵重置通知';

  @override
  String get allFissuresButton => '全部';

  @override
  String get voidStormFissuresButton => '虛空風暴';

  @override
  String get saleEndsTitle => '销售结束';

  @override
  String get salePriceTitle => '售價';

  @override
  String get originalPriceTitle => '原價';

  @override
  String discountTitle(Object discount) {
    return '立省 $discount%';
  }

  @override
  String inStockInformation(Object stock) {
    return '只剩下 $stock';
  }

  @override
  String get outOfStockTitle => '售罄';

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
  String get mapTitle => '地圖';

  @override
  String get mapDescription => '查看地區地圖';

  @override
  String get fishTitle => '魚';

  @override
  String get fishDescription => '按区域查看鱼类信息';

  @override
  String get fishName => '名稱';

  @override
  String get fishTime => '時間';

  @override
  String get fishSpear => '種類';

  @override
  String get fishRarity => '稀有度';

  @override
  String get fishBait => '要求的魚餌';

  @override
  String get fishStanding => 'Standing';

  @override
  String get fishUnique => '獨一無二';

  @override
  String get fishBladder => 'Bladders';

  @override
  String get fishGills => '鱼鳃';

  @override
  String get fishTumors => 'Tumors';

  @override
  String get fishMeat => '肉类';

  @override
  String get fishOil => '油';

  @override
  String get fishScales => '大小';

  @override
  String get fishScrap => 'Scraps';

  @override
  String get fishAny => '任何';

  @override
  String dropChance(Object chance) {
    return '掉落機率: $chance%';
  }

  @override
  String get statsTitle => '属性';

  @override
  String get patchlogsTitle => '补丁日志';

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
