import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/core/local/warframestate_local.dart';
import 'package:warframestat_api_models/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/worldstate_repository.dart';

class WorldstateRepositoryImpl implements WorldstateRepository {
  WorldstateRepositoryImpl(this.networkInfo, this.cache, this.usersettings);

  final NetworkInfo networkInfo;
  final WarframestatCache cache;
  final Usersettings usersettings;

  static final _warframestat = WarframestatClient();

  @override
  Future<Either<Failure, List<SynthTarget>>> getSynthTargets() async {
    final cached = cache.getCachedTargets();

    Either<Failure, List<SynthTarget>> fallback() {
      if (cached != null) {
        return Right(cached);
      } else {
        return Left(CacheFailure());
      }
    }

    if (await networkInfo.isConnected) {
      try {
        final targets = await compute(_getTargets, null);

        cache.cacheSynthTargets(targets);

        return Right(targets);
      } on SocketException {
        return fallback();
      }
    } else {
      return fallback();
    }
  }

  @override
  Future<Either<Failure, Worldstate>> getWorldstate() async {
    const newStateRefresh = Duration(minutes: 1);

    final now = DateTime.now();
    final cached = cache.getCachedState();

    if ((cached?.timestamp?.difference(now) ?? newStateRefresh) >=
        newStateRefresh) {
      if (await networkInfo.isConnected) {
        try {
          final state = await compute(_getWorldstate, usersettings.platform);

          cache.cacheWorldstate(state);

          return Right(state);
        } on SocketException {
          return Right(cached);
        }
      } else {
        return Right(cached);
      }
    } else {
      return Right(cached);
    }
  }

  @override
  Future<Either<Failure, BaseItem>> getDealInfo(String id, String name) async {
    final cachedId = cache.getCachedDealId();

    Either<Failure, BaseItem> getCached() {
      try {
        return Right(cache.getCachedDeal(id));
      } catch (e) {
        return Left(CacheFailure());
      }
    }

    if (cachedId != id) {
      if (await networkInfo.isConnected) {
        try {
          final deal = await compute(_getDealInfo, name);
          cache.cacheDealInfo(id, deal);

          return Right(deal);
        } on SocketException {
          return Left(OfflineFailure());
        }
      } else {
        return getCached();
      }
    } else {
      return getCached();
    }
  }

  static Future<Worldstate> _getWorldstate(GamePlatforms platform) {
    return _warframestat.getWorldstate(platform);
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    return _warframestat.getSynthTargets();
  }

  static Future<BaseItem> _getDealInfo(String name) async {
    final results = await _warframestat.searchItems(name);

    return results.firstWhere(
      (r) => r.name.toLowerCase().contains(name.toLowerCase()),
      orElse: () => null,
    );
  }
}

class DealRequest {
  const DealRequest(this.id, this.name);

  final String id;
  final String name;
}
