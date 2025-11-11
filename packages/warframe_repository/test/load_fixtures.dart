import 'dart:convert';
import 'dart:io';

/// A fixture loader for Warframe worldstate data.
///
/// Loads the complete worldstate JSON fixture and provides convenient
/// access to individual top-level keys. Assumes all keys exist in the fixture.
///
/// Usage:
/// ```dart
/// final fixture = WorldstateFixture.load();
/// final alerts = fixture.getAlerts();
/// final events = fixture.getEvents();
/// ```
class WorldstateFixture {
  WorldstateFixture._(this.json, this.data);

  /// Load the worldstate fixture from the default location
  factory WorldstateFixture.load({String path = './test/fixtures/worldstate.json'}) {
    final file = File(path);
    final json = file.readAsStringSync();
    final data = jsonDecode(json) as Map<String, dynamic>;
    return WorldstateFixture._(json, data);
  }

  final String json;
  final Map<String, dynamic> data;

  /// Get the Alerts array
  List<Map<String, dynamic>> get alerts {
    return (data['Alerts'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the Events array
  List<Map<String, dynamic>> get events {
    return (data['Events'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the Goals array
  List<Map<String, dynamic>> get goals {
    return (data['Goals'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the Sorties array
  List<Map<String, dynamic>> get sorties {
    return (data['Sorties'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the LiteSorties (Archon Hunts) array
  List<Map<String, dynamic>> get liteSorties {
    return (data['LiteSorties'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the SyndicateMissions array
  List<Map<String, dynamic>> get syndicateMissions {
    return (data['SyndicateMissions'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the ActiveMissions (Fissures) array
  List<Map<String, dynamic>> get activeMissions {
    return (data['ActiveMissions'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the Invasions array
  List<Map<String, dynamic>> get invasions {
    return (data['Invasions'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the VoidTraders array
  List<Map<String, dynamic>> get voidTraders {
    return (data['VoidTraders'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the PrimeVaultTraders array
  List<Map<String, dynamic>> get primeVaultTraders {
    return (data['PrimeVaultTraders'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the DailyDeals array
  List<Map<String, dynamic>> get dailyDeals {
    return (data['DailyDeals'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the FlashSales array
  List<Map<String, dynamic>> get flashSales {
    return (data['FlashSales'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the VoidStorms array
  List<Map<String, dynamic>> get voidStorms {
    return (data['VoidStorms'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the PersistentEnemies array
  List<Map<String, dynamic>> get persistentEnemies {
    return (data['PersistentEnemies'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the NodeOverrides array
  List<Map<String, dynamic>> get nodeOverrides {
    return (data['NodeOverrides'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the HubEvents array
  List<Map<String, dynamic>> get hubEvents {
    return (data['HubEvents'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the PVPChallengeInstances array
  List<Map<String, dynamic>> get pVPChallengeInstances {
    return (data['PVPChallengeInstances'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the GlobalUpgrades array
  List<Map<String, dynamic>> get globalUpgrades {
    return (data['GlobalUpgrades'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the ConstructionProjects array
  List<Map<String, dynamic>> get constructionProjects {
    return (data['ConstructionProjects'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the TwitchPromos array
  List<Map<String, dynamic>> get twitchPromos {
    return (data['TwitchPromos'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the FeaturedGuilds array
  List<Map<String, dynamic>> get featuredGuilds {
    return (data['FeaturedGuilds'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the PVPAlternativeModes array
  List<dynamic> get pVPAlternativeModes {
    return data['PVPAlternativeModes'] as List;
  }

  /// Get the PVPActiveTournaments array
  List<dynamic> get pVPActiveTournaments {
    return data['PVPActiveTournaments'] as List;
  }

  /// Get the ExperimentRecommended array
  List<dynamic> get experimentRecommended {
    return data['ExperimentRecommended'] as List;
  }

  /// Get the WorldSeed string
  String get worldSeed => data['WorldSeed'] as String;

  /// Get the Version number
  int get version => data['Version'] as int;

  /// Get the MobileVersion string
  String get mobileVersion => data['MobileVersion'] as String;

  /// Get the BuildLabel string
  String get buildLabel => data['BuildLabel'] as String;

  /// Get the Time timestamp
  int get time => data['Time'] as int;

  /// Get the PrimeAccessAvailability object
  Map<String, dynamic> get primeAccessAvailability {
    return data['PrimeAccessAvailability'] as Map<String, dynamic>;
  }

  /// Get the PrimeVaultAvailabilities array
  List<bool> get primeVaultAvailabilities {
    return (data['PrimeVaultAvailabilities'] as List).cast<bool>();
  }

  /// Get the PrimeTokenAvailability boolean
  bool get primeTokenAvailability => data['PrimeTokenAvailability'] as bool;

  /// Get the ProjectPct array
  List<double> get projectPct {
    return (data['ProjectPct'] as List).map((e) => (e as num).toDouble()).toList();
  }

  /// Get the LibraryInfo object
  Map<String, dynamic> get libraryInfo {
    return data['LibraryInfo'] as Map<String, dynamic>;
  }

  /// Get the SeasonInfo object
  Map<String, dynamic>? get seasonInfo {
    return data['SeasonInfo'] as Map<String, dynamic>?;
  }

  /// Get the InGameMarket object
  Map<String, dynamic> get inGameMarket {
    return data['InGameMarket'] as Map<String, dynamic>;
  }

  /// Get the EndlessXpChoices array
  List<Map<String, dynamic>> get endlessXpChoices {
    return (data['EndlessXpChoices'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the KnownCalendarSeasons array
  List<Map<String, dynamic>> get knownCalendarSeasons {
    return (data['KnownCalendarSeasons'] as List).cast<Map<String, dynamic>>();
  }

  List<Map<String, dynamic>> get conquests {
    return (data['Conquests'] as List).cast<Map<String, dynamic>>();
  }

  /// Get the ForceLogoutVersion number
  int get forceLogoutVersion => data['ForceLogoutVersion'] as int;

  /// Get the Tmp string
  String get tmp => data['Tmp'] as String;
}
