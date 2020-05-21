import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:navis/core/local/warframestate_local.dart';
import 'package:navis/core/network/warframestat_remote.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/worldstate_repository.dart';

class WorldstateRepositoryImpl implements WorldstateRepository {
  WorldstateRepositoryImpl(this.networkInfo, this.cache);

  final NetworkInfo networkInfo;
  final WarframestatCache cache;

  static final _warframestat = WarframestatClient(http.Client())
    ..platform = GamePlatforms.pc
    ..language = Intl.getCurrentLocale().split('_').first;

  @override
  Future<Either<Failure, List<SynthTarget>>> getSynthTargets() async {
    return run<List<SynthTarget>, void>(
      _getTargets,
      null,
      cache.cacheSynthTargets,
      cache.getCachedTargets,
    );
  }

  @override
  Future<Either<Failure, Worldstate>> getWorldstate() async {
    return run<Worldstate, NoParama>(
      _getWorldstate,
      NoParama(),
      cache.cacheWorldstate,
      cache.getCachedState,
    );
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

  static Future<Worldstate> _getWorldstate(NoParama noParama) {
    return _warframestat.getWorldstate();
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    return _warframestat.getSynthTargets();
  }

  static Future<BaseItem> _getDealInfo(String name) async {
    final results = await _warframestat.searchItems(name);

    return results.firstWhere(
      (r) => r.name.toLowerCase().contains(name.toLowerCase()),
      orElse: () => BaseItem(
        name: null,
        description: null,
        imageName: null,
        type: null,
      ),
    );
  }

  Future<Either<Failure, T>> run<T, P>(
    Future<T> Function(P) callback,
    P param,
    void Function(T) caching,
    T Function() restore,
  ) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await compute<P, T>(callback, param);
        caching(result);

        return Right(result);
      } on SocketException {
        return Left(OfflineFailure());
      }
    } else {
      try {
        return Right(restore());
      } catch (e) {
        return Left(CacheFailure());
      }
    }
  }

  @override
  void updateGamePlatform(GamePlatforms platform) {
    _warframestat.platform = platform;
  }

  @override
  void updateLanguage() {
    _warframestat.language = Intl.getCurrentLocale();
  }
}

class DealRequest {
  const DealRequest(this.id, this.name);

  final String id;
  final String name;
}
