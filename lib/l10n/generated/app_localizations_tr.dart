// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class NavisLocalizationsTr extends NavisLocalizations {
  NavisLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String levelInfo(int min, int max) {
    return 'Seviye: $min - $max';
  }

  @override
  String get tapForMoreDetails => 'Daha fazla ayrıntı için tıklayın';

  @override
  String get seeDetails => 'Ayrıntıları gör';

  @override
  String get seeMore => 'See More';

  @override
  String get seeWiki => 'See Wiki';

  @override
  String get eventDescription => 'Açıklama';

  @override
  String get eventStatus => 'Etkinlik durumu';

  @override
  String get eventStatusNode => 'Düğüm';

  @override
  String get eventStatusProgress => 'İlerleme';

  @override
  String get eventStatusEta => 'Kalan zaman (ETA)';

  @override
  String get eventRewards => 'Ödüller';

  @override
  String get bountyTitle => 'Avlar';

  @override
  String get errorTitle => 'Bir uygulama hatası meydana geldi';

  @override
  String get errorDescription =>
      'Çekirdek sistemde beklenmeyen bir hata oluştu.\nHata, sistem yöneticisine bildiriliyor...';

  @override
  String get baroTitle => 'Baro Ki\'Teer';

  @override
  String get location => 'Konum';

  @override
  String get baroLeavesOn => 'Gidiş';

  @override
  String get baroArrivesOn => 'Varış';

  @override
  String get baroInventory => 'Baro Ki\'Teer Envanteri';

  @override
  String countdownTooltip(DateTime date) {
    final intl.DateFormat dateDateFormat = intl.DateFormat('HH:mm:ss yyyy-MM-dd', localeName);
    final String dateString = dateDateFormat.format(date);

    return 'Sonlanma tarihi $dateString';
  }

  @override
  String get kuvaBanner => 'Kuva yenilenecek';

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
  String get timersTitle => 'Zamanlayıcılar';

  @override
  String get fissuresTitle => 'Yarıklar';

  @override
  String get invasionsTitle => 'İşgaller';

  @override
  String get syndicatesTitle => 'Sendikalar';

  @override
  String get codexTitle => 'Kodeks';

  @override
  String get codexDescription => 'Tüm Warframe ögelerini ara';

  @override
  String get helpfulLinksTitle => 'Yararlı bağlantılar';

  @override
  String get behaviorTitle => 'Davranış';

  @override
  String get themeTitle => 'Tema';

  @override
  String get themeDescription => 'Uygulama temasını seçin.';

  @override
  String get notificationsTitle => 'Bildirimler';

  @override
  String get rareAlertsNotificationTitle => 'Nadir Uyarılar';

  @override
  String get rareAlertsNotificationDescription => 'Nadir uyarı bildirimleri, genellikle Lotus\'un hediyeleri.';

  @override
  String get operationAlertsNotificationTitle => 'Operation Alerts';

  @override
  String get operationAlertsNotificationDescription => 'Alert notifications for operations';

  @override
  String get baroNotificationTitle => 'Baro Ki\'Teer';

  @override
  String get baroNotificationDescription => 'Baro\'nun varışı ve ayrılışı için bildirimler.';

  @override
  String get darvoNotificationTitle => 'Darvo\'nun Günlük Teklifleri';

  @override
  String get darvoNotificationDescription => 'Darvo\'nun Günün Yeni Keşfi.';

  @override
  String get sortieNotificationTitle => 'Sorti';

  @override
  String get sortieNotificationDescription => 'Yeni sorti bildirimleri.';

  @override
  String get sentientOutpostNotificationTitle => 'Sentient Karakolu';

  @override
  String get sentientOutpostNotificationDescription => 'Yeni sentient tehditleri için bildirimler.';

  @override
  String get warframeNewsTitle => 'Haberler';

  @override
  String get warframeNewsNotificationTitle => 'Haberler';

  @override
  String get warframeNewsNotificationDescription => 'Prime Erişimi, Yayınlar ve Güncellemeler için haber bildirimleri.';

  @override
  String get planetCyclesNotificationTitle => 'Açık Dünya Döngüleri';

  @override
  String get planetCyclesNotificationDescription => 'Açık dünya döngülerine yönelik bildirimler.';

  @override
  String get resourcesNotificationTitle => 'Kaynaklar';

  @override
  String get resourcesNotificationDescription => 'Çoğunlukla işgallerde bulunan kaynaklar.';

  @override
  String get fissuresNotificationTitle => 'Yarık Görevleri';

  @override
  String get fissuresNotificationDescription => 'Yarık bildirimlerini tercih edilen görev türüne göre filtrele.';

  @override
  String get earthDayOption => 'Dünya Gündüz';

  @override
  String get earthNightOption => 'Dünya Gece';

  @override
  String get cetusDayOption => 'Cetus Gündüz';

  @override
  String get cetusNightOption => 'Cetus Gece';

  @override
  String get vallisWarmOption => 'Orb Vallis Ilık';

  @override
  String get vallisColdOption => 'Orb Vallis soğuk';

  @override
  String get cambionFassOption => 'Cambion Fass';

  @override
  String get cambionVomeOption => 'Cambion Vome';

  @override
  String get primeAccessNewsOption => 'Prime Erişimi';

  @override
  String get streamNewsOption => 'Yayın Duyuruları';

  @override
  String get updateNewsOption => 'Warframe Güncelleme Haberleri';

  @override
  String get reportBugsTitle => 'Hata Bildir';

  @override
  String get reportBugsDescription => 'Hata bildir veya bir özellik talep et.';

  @override
  String get aboutCategoryTitle => 'Hakkında';

  @override
  String get aboutAppTitle => 'Uygulama Hakkında';

  @override
  String get contributeTranslationsTitle => 'Çevirilere Katkıda Bulun';

  @override
  String get contributeTranslationsDescription => 'Çevirilere katkıda bulunmak için gönüllü ol';

  @override
  String get lightThemeTitle => 'Açık';

  @override
  String get darkThemeTitle => 'Koyu';

  @override
  String get systemThemeTitle => 'Sistem';

  @override
  String get legalese =>
      'Warframe ve Warframe logosu, Digital Extremes Ltd.\'nin tescilli ticari markalarıdır. Cephalon Navis ve WFCD, Digital Extremes Ltd. ile herhangi bir şekilde ilişkili değildir.';

  @override
  String get homePageTitle => 'Ana Sayfa';

  @override
  String get sourceCode => 'Kaynak kodu';

  @override
  String get issueTrackerDescription => 'Bu proje için sorun bildirme veya özellik talepleri';

  @override
  String get issueTrackerTitle => 'sorun izleyici';

  @override
  String get warframeLinkTitle => 'Warframe hakkında daha fazla bilgi, resmi sitelerinde bulunabilir';

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get dailyResetTitle => 'Daily Reset Timer';

  @override
  String get weeklyResetTitle => 'Weekly Reset Timer';

  @override
  String get eliteBadgeTitle => 'Elit';

  @override
  String get dailyNightwaveTitle => 'Günlük';

  @override
  String get weeklyNightwaveTitle => 'Haftalık';

  @override
  String get warframePassiveTitle => 'Pasif';

  @override
  String get auraTitle => 'Aura Polaritesi';

  @override
  String get preinstalledPolarities => 'Önceden Yüklü Polariteler';

  @override
  String get shieldTitle => 'Kalkan';

  @override
  String get armorTitle => 'Zırh';

  @override
  String get healthTitle => 'Sağlık';

  @override
  String get powerTitle => 'Güç';

  @override
  String get sprintSpeedTitle => 'Koşma Hızı';

  @override
  String get abilitiesTitle => 'Yetenekler';

  @override
  String get componentsTitle => 'Bileşenler';

  @override
  String get masteryRequirementTitle => 'Ustalık Gereksinimi';

  @override
  String get weaponTypeTitle => 'Silah Türü';

  @override
  String get accuracyTitle => 'İsabet';

  @override
  String get criticalChanceTitle => 'Kritik Vuruş Şansı';

  @override
  String get cricticalMultiplierTitle => 'Kritik Vuruş Çarpanı';

  @override
  String get fireRateTitle => 'Atış Hızı';

  @override
  String get magazineTitle => 'Şarjör';

  @override
  String get multishotTitle => 'Çoklu atış';

  @override
  String get noiseTitle => 'Gürültü';

  @override
  String get reloadTitle => 'Şarjör doldurma';

  @override
  String get rivenDispositionTitle => 'Riven Dağılımı';

  @override
  String get statusChanceTitle => 'Statü Şansı';

  @override
  String get triggerTitle => 'Tetikleyici';

  @override
  String get damageTitle => 'Hasar';

  @override
  String get totalDamageTitle => 'Toplam Hasar';

  @override
  String get stancePolarityTitle => 'Duruş Polaritesi';

  @override
  String get attackSpeedTitle => 'Saldırı Hızı';

  @override
  String get followThroughTitle => 'Takip Et';

  @override
  String get rangeTitle => 'Menzil';

  @override
  String get slamAttackTitle => 'Çarpma Hasarı';

  @override
  String get slamRadialDamageTitle => 'Çarpma Hasarı Çapı';

  @override
  String get slamRadiusTitle => 'Çarpma Çapı';

  @override
  String get slideAttackTitle => 'Kayma Saldırısı';

  @override
  String get heavyAttackTitle => 'Ağır Saldırı';

  @override
  String get heavySlamAttackTitle => 'Ağır Çarpma Saldırısı';

  @override
  String get heavySlamRadialDamageTitle => 'Ağır Çarpma Hasarı Çapı';

  @override
  String get heavySlamRadiusTitle => 'Ağır Çarpma Çapı';

  @override
  String get windUpTitle => 'Hazırlık';

  @override
  String get discordSupportTitle => 'Destek';

  @override
  String get steelPathTitle => 'Steel Path';

  @override
  String get syndicateDualScreenTitle => 'Sendika Seç';

  @override
  String get optOutOfAnalyticsTitle => 'Analitiklerden Çıkın';

  @override
  String get optOutOfAnalyticsDescription => 'Analizleri devre dışı bırak.';

  @override
  String get appLangTitle => 'Dil';

  @override
  String get appLangDescription => 'Dil tespiti için varsayılan davranışı geçersiz kıl.';

  @override
  String modLevelLabel(int rank) {
    return 'Seviye: $rank';
  }

  @override
  String get codexHint => 'Search the codex here...';

  @override
  String get codexNoResults => 'Sonuç bulunamadı';

  @override
  String get codexVaultedLabel => 'Depolanan';

  @override
  String get exploreTitle => 'Keşfet';

  @override
  String get constructionProgressTitle => 'İnşaat Devam ediyor';

  @override
  String get synthTargetTitle => 'SynthTargets';

  @override
  String get archonHuntTitle => 'Archon Avı';

  @override
  String get archonHuntDescription => 'Archon avı sıfırlanma bildirimi.';

  @override
  String get allFissuresButton => 'Tümü';

  @override
  String get voidStormFissuresButton => 'Void Fırtınaları';

  @override
  String get saleEndsTitle => 'SATIŞ BİTER';

  @override
  String get salePriceTitle => 'Satış fiyatı';

  @override
  String get originalPriceTitle => 'Orjinal Fiyat';

  @override
  String discountTitle(Object discount) {
    return '% $discount İNDİRİM!';
  }

  @override
  String inStockInformation(Object stock) {
    return 'Sadece $stock adet kaldı';
  }

  @override
  String get outOfStockTitle => 'STOKLAR TÜKENDİ';

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
  String get mapTitle => 'Haritalar';

  @override
  String get mapDescription => 'Bölge haritalarını gör';

  @override
  String get fishTitle => 'Balık';

  @override
  String get fishDescription => 'Bölgeye göre balık bilgilerini gör';

  @override
  String get fishName => 'Ad';

  @override
  String get fishTime => 'Zaman';

  @override
  String get fishSpear => 'Mızrak';

  @override
  String get fishRarity => 'Nadirlik';

  @override
  String get fishBait => 'Yem';

  @override
  String get fishStanding => 'Durum';

  @override
  String get fishUnique => 'Eşsiz';

  @override
  String get fishBladder => 'Mesaneler';

  @override
  String get fishGills => 'Solungaçlar';

  @override
  String get fishTumors => 'Tümörler';

  @override
  String get fishMeat => 'Etler';

  @override
  String get fishOil => 'Yağlar';

  @override
  String get fishScales => 'Pullar';

  @override
  String get fishScrap => 'Hurdalar';

  @override
  String get fishAny => 'Herhangi';

  @override
  String dropChance(Object chance) {
    return 'Düşüş şansı % $chance';
  }

  @override
  String get statsTitle => 'İstatistikler';

  @override
  String get patchlogsTitle => 'Yama notları';

  @override
  String get impactDamageTitle => 'Darbe';

  @override
  String get punctureDamageTitle => 'Delici';

  @override
  String get slashDamageTitle => 'Kesme';

  @override
  String get heatDamageTitle => 'Sıcaklık';

  @override
  String get coldDamageTitle => 'Soğuk';

  @override
  String get electricityDamageTitle => 'Elektrik';

  @override
  String get toxinDamageTitle => 'Zehir';

  @override
  String get blastDamageTitle => 'Patlama';

  @override
  String get radiationDamageTitle => 'Radyasyon';

  @override
  String get gasDamageTitle => 'Gaz';

  @override
  String get magneticDamageTitle => 'Manyetik';

  @override
  String get viralDamageTitle => 'Viral';

  @override
  String get corrosiveDamageTitle => 'Aşındırıcı';

  @override
  String get voidDamageTitle => 'Void';

  @override
  String get tauDamageTitle => 'Tau';

  @override
  String get cinematicDamageTitle => 'Sinematik';

  @override
  String get shieldDrainDamageTitle => 'Kalkan Tüketme';

  @override
  String get healthDrainDamageTitle => 'Sağlık Tüketme';

  @override
  String get energyDrainDamageTitle => 'Enerji Tüketme';

  @override
  String get physicalDamageTitle => 'Fiziksel';

  @override
  String get circuitResetTitle => 'Devre Sıfırlanacak';

  @override
  String get circuitResetSubtitle => 'Tap to see current offerings';

  @override
  String get archimedeaResetTitle => 'Resets in';

  @override
  String get deepArchimedeaTitle => 'Deep Archimedea';

  @override
  String get temporalArchimedeaTitle => 'Temporal Archimedea';

  @override
  String get archimedeaDeviationTitle => 'Sapma';

  @override
  String get archimedeaRiskTitle => 'Risk Değişkeni';

  @override
  String get missionsCategoryTitle => 'Görevler';

  @override
  String get archimedeaPersonalModifierTitle => 'Kişisel Düzenleyiciler';

  @override
  String get archimedeaWarningTitle => 'Uyarı';

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
