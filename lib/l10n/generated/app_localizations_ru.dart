// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class NavisLocalizationsRu extends NavisLocalizations {
  NavisLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Уровни: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Для получения более подробной информации';

  @override
  String get seeDetails => 'Подробнее';

  @override
  String get seeMore => 'Подробнее';

  @override
  String get seeWiki => 'Смотреть в Wiki';

  @override
  String get eventDescription => 'Описание';

  @override
  String get eventStatus => 'Статус события';

  @override
  String get eventStatusNode => 'Узел';

  @override
  String get eventStatusProgress => 'Прогресс';

  @override
  String get eventStatusEta => 'Осталось (приблизительно)';

  @override
  String get eventRewards => 'Награды';

  @override
  String get bountyTitle => 'Заказы';

  @override
  String get errorTitle => 'Произошла ошибка приложения';

  @override
  String get errorDescription => 'Произошла непредвиденная ошибка в системе ядра (операционной системы).\nОшибка при отправке системным администраторам...';

  @override
  String get baroTitle => 'Баро Ки\'Тиир';

  @override
  String get location => 'Расположение';

  @override
  String get baroLeavesOn => 'Отбывает в';

  @override
  String get baroArrivesOn => 'Прибывает в';

  @override
  String get baroInventory => 'Товары Баро Ки\'Тиира';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Завершится $dateString';
  }

  @override
  String get kuvaBanner => 'Кува обновится через';

  @override
  String get formorianTitle => 'Фоморианец';

  @override
  String get razorbackTitle => 'Армада Секачей';

  @override
  String get earthCycleTitle => 'Земля';

  @override
  String get cetusCycleTitle => 'Цетус';

  @override
  String get vallisCycleTitle => 'Долина Сфер';

  @override
  String get cambionCycleTitle => 'Камбионский Дрейф';

  @override
  String get zarimanCycleTitle => 'Цикл на Заримане';

  @override
  String get timersTitle => 'Таймеры';

  @override
  String get fissuresTitle => 'Разрывы Бездны';

  @override
  String get invasionsTitle => 'Вторжения';

  @override
  String get syndicatesTitle => 'Синдикаты';

  @override
  String get codexTitle => 'Кодекс';

  @override
  String get codexDescription => 'Поиск всех предметов';

  @override
  String get helpfulLinksTitle => 'Полезные ссылки';

  @override
  String get behaviorTitle => 'Оформление';

  @override
  String get themeTitle => 'Тема';

  @override
  String get themeDescription => 'Выбрать тему оформления.';

  @override
  String get notificationsTitle => 'Уведомления';

  @override
  String get rareAlertsNotificationTitle => 'Редкие Тревоги';

  @override
  String get rareAlertsNotificationDescription => 'Оповещение о редких Тревогах, в основном Дары Лотус.';

  @override
  String get operationAlertsNotificationTitle => 'Сигналы тревоги';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Баро Ки\'Тиир';

  @override
  String get baroNotificationDescription => 'Оповещения о прибытии и отбытии Торговца из Бездны.';

  @override
  String get darvoNotificationTitle => 'Ежедневные предложения Дарво';

  @override
  String get darvoNotificationDescription => 'Уведомляет о ежедневном товаре Дарво.';

  @override
  String get sortieNotificationTitle => 'Вылазка';

  @override
  String get sortieNotificationDescription => 'Уведомляет о новой Вылазке.';

  @override
  String get sentientOutpostNotificationTitle => 'Мюрекс';

  @override
  String get sentientOutpostNotificationDescription => 'Уведомляет о местоположении Мюрекса.';

  @override
  String get warframeNewsTitle => 'Новости';

  @override
  String get warframeNewsNotificationTitle => 'Новости';

  @override
  String get warframeNewsNotificationDescription => 'О Прайм Доступе, Стримах, Обновлениях.';

  @override
  String get planetCyclesNotificationTitle => 'Циклы открытых локаций';

  @override
  String get planetCyclesNotificationDescription => 'О циклах на открытых локациях.';

  @override
  String get resourcesNotificationTitle => 'Ресурсы';

  @override
  String get resourcesNotificationDescription => 'О наградах: чертежи и ресурсы.';

  @override
  String get fissuresNotificationTitle => 'Миссии Разрыва Бездны';

  @override
  String get fissuresNotificationDescription => 'Фильтруйте уведомления о Разрывах Бездны по предпочитаемому типу миссии.';

  @override
  String get earthDayOption => 'Земля - День';

  @override
  String get earthNightOption => 'Земля - Ночь';

  @override
  String get cetusDayOption => 'Цетус - День';

  @override
  String get cetusNightOption => 'Цетус - Ночь';

  @override
  String get vallisWarmOption => 'Долина Сфер - Тепло';

  @override
  String get vallisColdOption => 'Долина Сфер - Холод';

  @override
  String get cambionFassOption => 'Цикл Фэз';

  @override
  String get cambionVomeOption => 'Цикл Воум';

  @override
  String get primeAccessNewsOption => 'Прайм доступ';

  @override
  String get streamNewsOption => 'Анонсы стримов';

  @override
  String get updateNewsOption => 'Новости обновления Warframe';

  @override
  String get reportBugsTitle => 'Сообщить об ошибке';

  @override
  String get reportBugsDescription => 'Сообщите об ошибках или запросите функцию.';

  @override
  String get aboutCategoryTitle => 'О приложении';

  @override
  String get aboutAppTitle => 'О приложении';

  @override
  String get contributeTranslationsTitle => 'Внести вклад в перевод';

  @override
  String get contributeTranslationsDescription => 'Помочь с переводом';

  @override
  String get lightThemeTitle => 'Светлая';

  @override
  String get darkThemeTitle => 'Тёмная';

  @override
  String get systemThemeTitle => 'Системная';

  @override
  String get legalese => 'Warframe и логотип Warframe являются зарегистрированными торговыми марками Digital Extremes Ltd.\nCephalon Navis и WFCD никаким образом не связаны с Digital Extremes Ltd.';

  @override
  String get homePageTitle => 'Главная';

  @override
  String get sourceCode => 'Исходный код';

  @override
  String get issueTrackerDescription => 'Сообщить об ошибке или запросить новые функции для этого проекта';

  @override
  String get issueTrackerTitle => 'Баг-трекер';

  @override
  String get warframeLinkTitle => 'Больше информации о Warframe можно найти на их официальном сайте';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get dailyRewardTitle => 'Таймер сброса ежедневной награды';

  @override
  String get eliteBadgeTitle => 'Элитное';

  @override
  String get dailyNightwaveTitle => 'Ежедневные';

  @override
  String get weeklyNightwaveTitle => 'Еженедельные';

  @override
  String get warframePassiveTitle => 'Пассивка';

  @override
  String get auraTitle => 'Полярность Ауры';

  @override
  String get preinstalledPolarities => 'Предустановленные Полярности';

  @override
  String get shieldTitle => 'Щиты';

  @override
  String get armorTitle => 'Броня';

  @override
  String get healthTitle => 'Здоровье';

  @override
  String get powerTitle => 'Сила';

  @override
  String get sprintSpeedTitle => 'Скорость Бега';

  @override
  String get abilitiesTitle => 'Способности';

  @override
  String get componentsTitle => 'Компоненты';

  @override
  String get masteryRequirementTitle => 'Требуемый Ранг Мастерства';

  @override
  String get weaponTypeTitle => 'Тип оружия';

  @override
  String get accuracyTitle => 'Точность';

  @override
  String get criticalChanceTitle => 'Шанс крита';

  @override
  String get cricticalMultiplierTitle => 'Крит. Множитель';

  @override
  String get fireRateTitle => 'Скорострельность';

  @override
  String get magazineTitle => 'Магазин';

  @override
  String get multishotTitle => 'Мультивыстрел';

  @override
  String get noiseTitle => 'Шумность';

  @override
  String get reloadTitle => 'Перезарядка';

  @override
  String get rivenDispositionTitle => 'Синергия с Разломом';

  @override
  String get statusChanceTitle => 'Шанс статуса';

  @override
  String get triggerTitle => 'Режим';

  @override
  String get damageTitle => 'Урон';

  @override
  String get totalDamageTitle => 'Всего урона';

  @override
  String get stancePolarityTitle => 'Полярность Стойки';

  @override
  String get attackSpeedTitle => 'Скорость Атаки';

  @override
  String get followThroughTitle => 'Пронзание Навылет';

  @override
  String get rangeTitle => 'Зона Поражения';

  @override
  String get slamAttackTitle => 'Удар по земле';

  @override
  String get slamRadialDamageTitle => 'Радиальный урон по земле';

  @override
  String get slamRadiusTitle => 'Радиус Удара по земле';

  @override
  String get slideAttackTitle => 'Удар в скольжении';

  @override
  String get heavyAttackTitle => 'Тяжелая атака';

  @override
  String get heavySlamAttackTitle => 'Тяжелый удар по земле';

  @override
  String get heavySlamRadialDamageTitle => 'Тяжелый радиальный урон по земле';

  @override
  String get heavySlamRadiusTitle => 'Радиус тяжелого удара по земле';

  @override
  String get windUpTitle => 'Подготовка';

  @override
  String get discordSupportTitle => 'Discord';

  @override
  String get steelPathTitle => 'Стальной Путь';

  @override
  String get syndicateDualScreenTitle => 'Выбрать синдикат';

  @override
  String get optOutOfAnalyticsTitle => 'Отказ от аналитики';

  @override
  String get optOutOfAnalyticsDescription => 'Отключить аналитику.';

  @override
  String get appLangTitle => 'Язык';

  @override
  String get appLangDescription => 'Сменить язык приложения.';

  @override
  String modLevelLabel(int rank) {
    return 'Уровень $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'Ничего не найдено';

  @override
  String get codexVaultedLabel => 'В хранилище';

  @override
  String get exploreTitle => 'Исследовать';

  @override
  String get constructionProgressTitle => 'Статус Постройки';

  @override
  String get synthTargetTitle => 'Цели Синтеза';

  @override
  String get archonHuntTitle => 'Охота за Архонтом';

  @override
  String get archonHuntDescription => 'Уведомление о сбросе Охоты за Архонтом.';

  @override
  String get allFissuresButton => 'Все';

  @override
  String get voidStormFissuresButton => 'Разрывы Бездны';

  @override
  String get saleEndsTitle => 'ПРОДАЖИ ЗАВЕРШЕНЫ';

  @override
  String get salePriceTitle => 'Цена продажи';

  @override
  String get originalPriceTitle => 'Обычная цена';

  @override
  String discountTitle(Object discount) {
    return 'Скидка $discount%!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Осталось только $stock';
  }

  @override
  String get outOfStockTitle => 'НЕТ В НАЛИЧИИ';

  @override
  String get duviriJoy => 'Дувири Радость';

  @override
  String get duviriAnger => 'Дувири Злость';

  @override
  String get duviriEnvy => 'Дувири Зависть';

  @override
  String get duviriSorrow => 'Дувири Печаль';

  @override
  String get duviriFear => 'Дувири Страх';

  @override
  String get mapTitle => 'Карта';

  @override
  String get mapDescription => 'Посмотреть карты регионов';

  @override
  String get fishTitle => 'Название рыбы';

  @override
  String get fishDescription => 'Посмотреть информацию о рыбе по регионам';

  @override
  String get fishName => 'Название';

  @override
  String get fishTime => 'Фаза';

  @override
  String get fishSpear => 'Гарпун';

  @override
  String get fishRarity => 'Редкость';

  @override
  String get fishBait => 'Приманка';

  @override
  String get fishStanding => 'Репутация';

  @override
  String get fishUnique => 'Уникальный ресурс';

  @override
  String get fishBladder => 'Ферментный пузырь';

  @override
  String get fishGills => 'Жабры';

  @override
  String get fishTumors => 'Доброкачественная Заражённая Опухоль';

  @override
  String get fishMeat => 'Рыбье мясо';

  @override
  String get fishOil => 'Рыбий жир';

  @override
  String get fishScales => 'Рыбья чешуя';

  @override
  String get fishScrap => 'Хлам';

  @override
  String get fishAny => 'Любая';

  @override
  String dropChance(Object chance) {
    return 'Шанс выпадения $chance%';
  }

  @override
  String get statsTitle => 'Статистика';

  @override
  String get patchlogsTitle => 'Журнал исправлений';

  @override
  String get impactDamageTitle => 'Удар';

  @override
  String get punctureDamageTitle => 'Пронзание';

  @override
  String get slashDamageTitle => 'Разрез';

  @override
  String get heatDamageTitle => 'Огонь';

  @override
  String get coldDamageTitle => 'Холод';

  @override
  String get electricityDamageTitle => 'Электричество';

  @override
  String get toxinDamageTitle => 'Токсин';

  @override
  String get blastDamageTitle => 'Взрыв';

  @override
  String get radiationDamageTitle => 'Радиация';

  @override
  String get gasDamageTitle => 'Газ';

  @override
  String get magneticDamageTitle => 'Магнит';

  @override
  String get viralDamageTitle => 'Вирус';

  @override
  String get corrosiveDamageTitle => 'Коррозия';

  @override
  String get voidDamageTitle => 'Урон Бездны';

  @override
  String get tauDamageTitle => 'Тау';

  @override
  String get cinematicDamageTitle => 'Cinematic';

  @override
  String get shieldDrainDamageTitle => 'Истощение щита';

  @override
  String get healthDrainDamageTitle => 'Истощение здоровья';

  @override
  String get energyDrainDamageTitle => 'Истощение энергии';

  @override
  String get physicalDamageTitle => 'Физический урон';

  @override
  String get circuitResetTitle => 'Смена наград через';

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
  String get archimedeaWarningSubtitle => 'DE не всегда обновляет данные Deep Archimedea после еженедельного сброса, поэтому считайте это нестабильным.\nПредупреждение будет удалено, когда ротация данных станет более последовательной';

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
