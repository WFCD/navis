// ignore_for_file: experimental_member_use Arbitration is only experimental because there's no easy way of getting data for it

import 'dart:isolate';

import 'package:http/http.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:navis_settings/navis_settings.dart';
import 'package:profile_models/profile_models.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:warframe_repository/src/models/warframe_item.dart';
import 'package:warframe_repository/src/utils/utils.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart' hide Profile, SynthTarget, Worldstate;
import 'package:worldstate_models/worldstate_models.dart';

const __dropDataRefreshTime = Duration(days: 30);

/// How longe before the worldstate is considered expired
const worldstateRefreshTime = Duration(seconds: Duration.secondsPerMinute * 3);

/// Record that puts together any masterable [Item] with XP/mastery rank the user has in it.
typedef MasterableItem = ({CodexItem item, int xp});

/// Repository for all Warframe related calls
class WarframeRepository {
  ///
  WarframeRepository({
    required Client client,
    required CacheManager manager,
    required CodexDatabase codex,
    required AppConfigAccessor appconfig,
  }) : _client = client,
       _cacheManager = manager,
       _codexDatabase = codex,
       _appConfig = appconfig;

  final Client _client;
  final CacheManager _cacheManager;
  final CodexDatabase _codexDatabase;
  final AppConfigAccessor _appConfig;

  Future<AppConfig> get _settings => _appConfig.fetchSettings();

  Future<WorldstateDataLocale> get _wLocale async {
    final storedLocale = (await _settings).language;
    return WorldstateDataLocale.values.firstWhere((v) => v.name == storedLocale, orElse: () => .en);
  }

  /// Emits a worldstate every 3 mins
  Stream<Worldstate> worldstateEmitter() async* {
    yield* Stream<Future<Worldstate>>.periodic(
      worldstateRefreshTime,
      (_) async => fetchWorldstate(),
    ).asyncMap((future) async => future);
  }

  /// Fetches the worldstate
  Future<Worldstate> fetchWorldstate() async {
    final locale = await _wLocale;
    final key = 'worldstate_$locale';
    final data = await _cacheManager.get<Map<String, dynamic>>(key);
    if (data != null) return Worldstate.fromMap(data);

    final bountyRewardTable = await buildBountyRewardTable();
    final worldstate = await WarframeApi(_client).fetchWorldstate(bountyRewardTable, locale);
    await _cacheManager.set('worldstate', worldstate.toMap(), ttl: worldstateRefreshTime);

    return worldstate;
  }

  /// Builds and caches the bounty reward tables using the official drops source
  Future<List<BountyRewardTable>> buildBountyRewardTable() async {
    const suffix = 'bounty_rewards';
    final buildLabel = await fetchBuildLabel();
    final data = await _cacheManager.get<List<dynamic>>('${buildLabel}_$suffix');
    if (data != null) return List<Map<String, dynamic>>.from(data).map(BountyRewardTable.fromMap).toList();

    final dropData = await WarframeApi(_client).buildSyndicateRewardTable();

    await _cacheManager.set(
      '${buildLabel}_$suffix',
      dropData.map((t) => t.toMap()).toList(),
      ttl: __dropDataRefreshTime,
    );

    return dropData;
  }

  /// Fetches the worldstate parsing out only the build label
  Future<String> fetchBuildLabel() async {
    const key = 'build_label';
    final data = await _cacheManager.get<String>(key);
    if (data != null) return data;

    final raw = await WarframeApi(_client).fetchRawWorldstate();
    await _cacheManager.set(key, raw.buildLabel, ttl: __dropDataRefreshTime);

    return raw.buildLabel;
  }

  /// Whether or not the user data json is the one we want or not
  Future<UserData> updateAccountId(String userData) async {
    final json = jsonDecode(userData) as Map<String, dynamic>;
    final data = UserData.fromJson(json);

    await _appConfig.updateSettings(account: data.id);
    return data;
  }

  /// Fetch a user profile
  ///
  /// Will cache a copy for 1 hour
  Future<Profile?> fetchProfile() async {
    const key = 'profile';

    final data = await _cacheManager.get<Map<String, dynamic>>(key);
    if (data != null) return Profile.fromMap(data);

    final accountId = (await _settings).account;
    if (accountId == null) return null;

    final profile = await WarframeApi(_client).fetchProfile(accountId);
    await _cacheManager.set(key, profile.toMap(), ttl: const Duration(minutes: 60));

    return profile;
  }

  /// Builds a [List<Masterable>] using the cached profile from [fetchProfile()] or fetches it if the cache is invalid
  Future<List<MasterableItem>> buildXpInfo() async {
    // Don't need to spam non founder users with things they can't have
    const founderItems = <String>['Excalibur Prime', 'Lato Prime', 'Skana Prime'];

    final profile = await fetchProfile();
    if (profile == null) return [];

    final lookup = {for (final i in profile.loadout.xpInfo) i.uniqueName: i.xp};
    final items = await _codexDatabase.fetchMasterable();

    return items.map<MasterableItem>((i) => (item: i, xp: lookup[i.uniqueName] ?? 0)).toList()
      ..removeWhere((i) => founderItems.contains(i.item.name) && i.xp == 0)
      ..sort((a, b) => a.xp.compareTo(b.xp));
  }

  /// Gets all warframe-items and stores them in the [CodexDatabase]
  Future<void> syncCodex() async {
    final storedLocale = (await _settings).language;
    final locale = Language.values.firstWhere((v) => v.name == storedLocale, orElse: () => .en);
    final buildLabel = await fetchBuildLabel();
    final timestamp = await _cacheManager.get<String>('${buildLabel}_codex');
    if (timestamp != null && DateTime.timestamp().difference(DateTime.parse(timestamp)) > __dropDataRefreshTime) {
      return;
    }

    List<WarframeItem> items;

    try {
      final itemClient = WarframeItemsClient(client: _client, language: locale);
      items =
          await itemClient.fetchAllItems<WarframeItem>(props: codexProps, encoder: WarframeItem.fromJson)
              as List<WarframeItem>;
    } on Exception {
      return;
    }

    await _codexDatabase.computeWithDatabase(
      connect: CodexDatabase.new,
      computation: (codex) async {
        final codexItems = items.map((i) => i.toCodexItem()).toList();
        await codex.addItems(codexItems);
      },
    );
  }

  /// Will query [CodexDatabase] for a matching name or fall back to pulling from warframe-items API
  ///
  /// Any results from warframe-items will be stored in the [CodexDatabase] if any are returned
  Future<List<CodexItem>> searchItem(String name) async {
    final results = await _codexDatabase.search(name);
    if (results.isNotEmpty) return results;

    final storedLocale = (await _settings).language;
    final locale = Language.values.firstWhere((v) => v.name == storedLocale, orElse: () => .en);

    final itemClient = WarframeItemsClient(client: _client, language: locale);
    final warframeItemResults = await itemClient.search(name, props: codexProps, encoder: WarframeItem.fromJson);
    final codexItems = warframeItemResults.map((i) => i.toCodexItem()).toList();

    // Helps keep the codex partially up-to-date when it comes to new items
    await _codexDatabase.addItems(codexItems);

    return codexItems;
  }

  /// Pulls a full [Item] from the warframe-items API
  ///
  /// The [CodexDatabase] only stores the bare minimum to display items
  Future<ItemCommon?> fetchItem(String uniqueName) async {
    final storedLocale = (await _settings).language;
    final locale = Language.values.firstWhere((v) => v.name == storedLocale, orElse: () => .en);
    final itemClient = WarframeItemsClient(client: _client, language: locale);

    return itemClient.fetchItem(uniqueName);
  }

  /// Get locally stored list of [SynthTarget]s
  Future<List<SynthTarget>> fetchTargets() async {
    return synthTargets(await _wLocale);
  }

  /// Fetches the currently know arbitration schedule from https://browse.wf/
  Future<Arbitration> fetchArbitrations() async {
    const key = 'arbis';
    bool isActive(Arbitration a) {
      final now = DateTime.timestamp();
      return now.isAfter(a.activation) && now.isBefore(a.expiry);
    }

    final data = await _cacheManager.get<List<dynamic>>(key);
    if (data != null) {
      final arbis = List<Map<String, dynamic>>.from(data).map(Arbitration.fromJson).toList();
      return arbis.firstWhere(isActive);
    }

    final res = await _client.get(Uri.parse('https://browse.wf/arbys.txt'));
    final csv = res.body;
    final arbis = await Isolate.run(() => parseArbitration(csv));
    final ttl = DateTime.timestamp().difference(arbis.last.expiry);

    await _cacheManager.set(key, arbis.map((a) => a.toJson()).toList(), ttl: ttl);
    return arbis.firstWhere(isActive);
  }
}
