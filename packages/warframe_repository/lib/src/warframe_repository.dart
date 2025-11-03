import 'dart:isolate';

import 'package:collection/collection.dart';
import 'package:http/http.dart';
import 'package:http_client/http_client.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';
import 'package:worldstate_models/worldstate_models.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
// const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';

/// {@template warframe_repository}
/// Repository to interact and transform data straight from DE
/// {@endtemplate}
class WarframeRepository {
  /// {@macro warframe_repository}
  const WarframeRepository({required Client client}) : _client = client;

  final Client _client;

  /// Fetches and parses a worldstate
  Future<Worldstate> fetchWorldstate([String locale = 'en']) async {
    var cacheClient = await CacheClient.create(_client, cacheDuration: const Duration(days: 30));
    final dropData = await fetchWarframeDropData(cacheClient);

    cacheClient = cacheClient.setCacheDuration(const Duration(minutes: 3));
    final res = await cacheClient.get(Uri.parse(_worldstateApi));

    return Isolate.run(() {
      final bountyTables = [
        Syndicates.entrati,
        Syndicates.ostron,
        Syndicates.solaris,
      ].map((id) => parseBountyRewardTables(dropData, id)).nonNulls.flattenedToList;

      return RawWorldstate.fromJson(res.body).toWorldstate(Dependency(bountyTables));
    });
  }

  /// Emits a worldstate every 3 mins
  Stream<Worldstate> worldstateEmitter([String locale = 'en']) async* {
    yield* Stream<Future<Worldstate>>.periodic(
      const Duration(seconds: Duration.secondsPerMinute * 3),
      (_) async => fetchWorldstate(locale),
    ).asyncMap((future) async => future);
  }
}
