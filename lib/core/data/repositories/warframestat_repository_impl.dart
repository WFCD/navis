import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:lumberdash/lumberdash.dart';
import 'package:navis/core/data/datasources/warframestat_local.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

typedef CacheCallback<T> = void Function(T toCache);
typedef ExecuteCallback<T> = Future<T> Function();
typedef RestoreCallback<T> = T Function();

class WarframestatRepositoryImpl implements WarframestatRepository {
  final WarframestatCache local;
  final WarframestatRemote remote;
  final NetworkInfo networkInfo;

  WarframestatRepositoryImpl({
    @required this.local,
    @required this.remote,
    @required this.networkInfo,
  })  : assert(local != null),
        assert(remote != null),
        assert(networkInfo != null);

  final _memoizer = AsyncMemoizer<BaseItem>();

  @override
  Future<BaseItem> getDealInfo(String id, String itemName) async {
    return _memoizer.runOnce(() async => _getDealInfo(id, itemName));
  }

  Future<BaseItem> _getDealInfo(String id, String itemName) async {
    logMessage(itemName);
    final cachedId = local.getCachedDealId();

    if (id != cachedId || id == null) {
      final results = await remote.searchItems(itemName);
      final item = results
          .firstWhere((i) => i.name.toLowerCase() == itemName.toLowerCase());

      local.cacheDealInfo(id, item);
      return item;
    } else {
      final cached = local.getCachedDeal();

      if (cached == null) throw CacheException();

      return cached;
    }
  }

  @override
  Future<List<SynthTarget>> getSynthTargets() async {
    return _execute<List<SynthTarget>>(
      () => remote.getSynthTargets(),
      executeCaching: local.cacheSynthTargets,
      executeCacheRestore: local.getCachedTargets,
    );
  }

  @override
  Future<Worldstate> getWorldstate(GamePlatforms platform) async {
    return _execute<Worldstate>(
      () => remote.getWorldstate(platform),
      executeCaching: local.cacheWorldstate,
      executeCacheRestore: local.getCachedState,
    );
  }

  Future<T> _execute<T>(
    ExecuteCallback<T> execute, {
    CacheCallback<T> executeCaching,
    RestoreCallback<T> executeCacheRestore,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final state = await execute();
        if (executeCaching != null) executeCaching(state);

        return state;
      } on ServerException {
        throw ServerFailure();
      }
    } else {
      if (executeCacheRestore != null) {
        try {
          return executeCacheRestore();
        } on CacheException {
          throw CacheFailure();
        }
      } else {
        throw CacheFailure();
      }
    }
  }
}
