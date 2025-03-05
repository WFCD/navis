// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class NavisLocalizationsKo extends NavisLocalizations {
  NavisLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return '레벨: $min - $max';
  }

  @override
  String get tapForMoreDetails => '자세히 알아보려면 탭하세요';

  @override
  String get seeDetails => '자세히';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => '설명';

  @override
  String get eventStatus => '이벤트 상태';

  @override
  String get eventStatusNode => '노드';

  @override
  String get eventStatusProgress => '진행도';

  @override
  String get eventStatusEta => '남은 시간 (ETA)';

  @override
  String get eventRewards => '보상';

  @override
  String get bountyTitle => '의뢰';

  @override
  String get errorTitle => '애플리케이션에 오류가 발생했습니다';

  @override
  String get errorDescription => '코어 시스템에 알 수 없는 오류가 발생했습니다.\n시스템 관리자에게 오류를 보고하는 중입니다...';

  @override
  String get baroTitle => '바로 키 티어';

  @override
  String get location => 'Location';

  @override
  String get baroLeavesOn => '출발 시간';

  @override
  String get baroArrivesOn => '도착 시간';

  @override
  String get baroInventory => '바로 키 티어 인벤토리';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return '종료까지 $dateString 남음';
  }

  @override
  String get kuvaBanner => '쿠바 갱신까지';

  @override
  String get formorianTitle => 'Formorian';

  @override
  String get razorbackTitle => 'Razerback';

  @override
  String get earthCycleTitle => '지구 주기';

  @override
  String get cetusCycleTitle => '시터스 주기';

  @override
  String get vallisCycleTitle => '협곡 주기';

  @override
  String get cambionCycleTitle => '캠비온 주기';

  @override
  String get zarimanCycleTitle => '자리만 주기';

  @override
  String get timersTitle => '타이머';

  @override
  String get fissuresTitle => '균열';

  @override
  String get invasionsTitle => '침공';

  @override
  String get syndicatesTitle => '신디케이트';

  @override
  String get codexTitle => '코덱스';

  @override
  String get codexDescription => 'Search all warframe items';

  @override
  String get helpfulLinksTitle => '도움되는 링크';

  @override
  String get behaviorTitle => '동작';

  @override
  String get themeTitle => '테마';

  @override
  String get themeDescription => '앱 테마를 선택해주세요.';

  @override
  String get notificationsTitle => '알림';

  @override
  String get rareAlertsNotificationTitle => '레어 얼럿';

  @override
  String get rareAlertsNotificationDescription => '주로 로터스의 선물같은 레어 얼럿 알림입니다.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => '바로 키 티어';

  @override
  String get baroNotificationDescription => '바로의 도착과 출발 모두에 대한 알림을 받습니다.';

  @override
  String get darvoNotificationTitle => '다르보의 제안';

  @override
  String get darvoNotificationDescription => '다르보의 일일 제안입니다.';

  @override
  String get sortieNotificationTitle => '출격';

  @override
  String get sortieNotificationDescription => '새 출격이 나오면 알림을 받습니다.';

  @override
  String get sentientOutpostNotificationTitle => '센티언트 전초 기지';

  @override
  String get sentientOutpostNotificationDescription => '새 센티언트 위협에 대한 알림을 받습니다.';

  @override
  String get warframeNewsTitle => '새로운 소식';

  @override
  String get warframeNewsNotificationTitle => '새 소식';

  @override
  String get warframeNewsNotificationDescription => '프라임 엑세스, 방송, 업데이트에 대한 소식 알림을 받습니다.';

  @override
  String get planetCyclesNotificationTitle => '오픈 월드 주기';

  @override
  String get planetCyclesNotificationDescription => '오픈 월드의 주기에 대한 알림을 받습니다.';

  @override
  String get resourcesNotificationTitle => '자원';

  @override
  String get resourcesNotificationDescription => '자원은 대부분 침공에서 찾을 수 있습니다.';

  @override
  String get fissuresNotificationTitle => '균열 미션';

  @override
  String get fissuresNotificationDescription => '균열 알림을 선호하는 미션 유형으로 필터하기.';

  @override
  String get earthDayOption => '지구 낮';

  @override
  String get earthNightOption => '지구 저녁';

  @override
  String get cetusDayOption => '시터스 낮';

  @override
  String get cetusNightOption => '시터스 저녁';

  @override
  String get vallisWarmOption => '오브 협곡 따듯함';

  @override
  String get vallisColdOption => '오브 협곡 추움';

  @override
  String get cambionFassOption => '캠비온 Fass';

  @override
  String get cambionVomeOption => '캠비온 Vome';

  @override
  String get primeAccessNewsOption => '프라임 액세스';

  @override
  String get streamNewsOption => '방송 공지';

  @override
  String get updateNewsOption => 'Warframe 업데이트 소식';

  @override
  String get reportBugsTitle => '버그 제보';

  @override
  String get reportBugsDescription => '버그 제보 또는 기능 제안.';

  @override
  String get aboutCategoryTitle => '소개';

  @override
  String get aboutAppTitle => 'About app';

  @override
  String get contributeTranslationsTitle => 'Contribute Translations';

  @override
  String get contributeTranslationsDescription => 'Volunteer to contribute translations';

  @override
  String get lightThemeTitle => '라이트';

  @override
  String get darkThemeTitle => '다크';

  @override
  String get systemThemeTitle => '시스템 설정';

  @override
  String get legalese => 'Warframe과 Warframe 로고는 Digital Extremes Ltd.의 등록 상표입니다. Cephalon Navis 및 WFCD 역시 Digital Extremes Ltd.와 관계 없습니다.';

  @override
  String get homePageTitle => '홈';

  @override
  String get sourceCode => 'Source code';

  @override
  String get issueTrackerDescription => '이 프로젝트의 이슈를 제보하거나 기능 제안하기';

  @override
  String get issueTrackerTitle => '이슈 트래커';

  @override
  String get warframeLinkTitle => 'Warframe에 관한 더 많은 정보는 공식 사이트에서 찾을 수 있습니다';

  @override
  String get settingsTitle => '설정';

  @override
  String get dailyRewardTitle => '일일 보상 초기화 타이머';

  @override
  String get eliteBadgeTitle => '엘리트';

  @override
  String get dailyNightwaveTitle => '일일';

  @override
  String get weeklyNightwaveTitle => '주간';

  @override
  String get warframePassiveTitle => '패시브';

  @override
  String get auraTitle => '오라 극성';

  @override
  String get preinstalledPolarities => '미리 설치된 극성';

  @override
  String get shieldTitle => '방어력';

  @override
  String get armorTitle => '아머';

  @override
  String get healthTitle => '체력';

  @override
  String get powerTitle => '파워';

  @override
  String get sprintSpeedTitle => '달리기 속도';

  @override
  String get abilitiesTitle => '어빌리티';

  @override
  String get componentsTitle => '자원';

  @override
  String get masteryRequirementTitle => '마스터리 요구 사항';

  @override
  String get weaponTypeTitle => '무기 유형';

  @override
  String get accuracyTitle => '정확도';

  @override
  String get criticalChanceTitle => '치명타 확률';

  @override
  String get cricticalMultiplierTitle => '치명타 배수';

  @override
  String get fireRateTitle => '연사율';

  @override
  String get magazineTitle => '탄창';

  @override
  String get multishotTitle => '멀티샷';

  @override
  String get noiseTitle => '소음';

  @override
  String get reloadTitle => '재장전';

  @override
  String get rivenDispositionTitle => '리벤 성질';

  @override
  String get statusChanceTitle => '상태이상 확률';

  @override
  String get triggerTitle => '발사';

  @override
  String get damageTitle => '피해량';

  @override
  String get totalDamageTitle => '총 피해량';

  @override
  String get stancePolarityTitle => '스텐스 극성';

  @override
  String get attackSpeedTitle => '공격 속도';

  @override
  String get followThroughTitle => '팔로우 쓰루';

  @override
  String get rangeTitle => '범위';

  @override
  String get slamAttackTitle => '폭발 공격';

  @override
  String get slamRadialDamageTitle => '폭발 방사능 피해량';

  @override
  String get slamRadiusTitle => '폭발 범위';

  @override
  String get slideAttackTitle => '슬라이드 공격';

  @override
  String get heavyAttackTitle => '강공격';

  @override
  String get heavySlamAttackTitle => '강공격 폭발';

  @override
  String get heavySlamRadialDamageTitle => '강공격 방사능 피해량';

  @override
  String get heavySlamRadiusTitle => '강공격 피해 범위';

  @override
  String get windUpTitle => '윈드 업';

  @override
  String get discordSupportTitle => '지원';

  @override
  String get steelPathTitle => '강철의 길';

  @override
  String get syndicateDualScreenTitle => '신디케이트 선택';

  @override
  String get optOutOfAnalyticsTitle => '분석에서 제외';

  @override
  String get optOutOfAnalyticsDescription => '분석을 비활성화합니다.';

  @override
  String get appLangTitle => '언어';

  @override
  String get appLangDescription => '언어를 수동으로 설정합니다.';

  @override
  String modLevelLabel(int rank) {
    return '레벨 $rank';
  }

  @override
  String get codexHint => 'Search here...';

  @override
  String get codexNoResults => '결과 없음';

  @override
  String get codexVaultedLabel => '볼트에 들어감';

  @override
  String get exploreTitle => '탐색';

  @override
  String get constructionProgressTitle => '건설 진행도';

  @override
  String get synthTargetTitle => '신디시스 목표';

  @override
  String get archonHuntTitle => '집정관 사냥';

  @override
  String get archonHuntDescription => '집정관 사냥 초기화 알림.';

  @override
  String get allFissuresButton => '모두';

  @override
  String get voidStormFissuresButton => '보이드 폭풍';

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
}
