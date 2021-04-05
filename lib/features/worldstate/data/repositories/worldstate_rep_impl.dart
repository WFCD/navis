import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local/user_settings.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/worldstate_repository.dart';
import '../datasources/warframestate_local.dart';

class WorldstateRepositoryImpl implements WorldstateRepository {
  const WorldstateRepositoryImpl(
    this.networkInfo,
    this.cache,
    this.usersettings,
  );

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
  Future<Either<Failure, Worldstate>> getWorldstate(
      {bool forceUpdate = false}) async {
    const refresh = Duration(minutes: 1);

    final now = DateTime.now();
    final cached = cache.getCachedState();
    final age = cached?.timestamp.difference(now).abs() ?? Duration.zero;
    final request = WorldstateRequest(
        usersettings.platform ?? GamePlatforms.pc, Platform.localeName);

    if (cached == null || age >= refresh || forceUpdate) {
      if (await networkInfo.isConnected) {
        try {
          final state = await compute(_getWorldstate, request);

          if (state == null && cached == null) {
            return Left(CacheFailure());
          } else if (state == null && cached != null) {
            return Right(cached);
          } else {
            cache.cacheWorldstate(state!);
            return Right(state);
          }
        } catch (e) {
          return Right(cached!);
        }
      } else {
        return Right(cached!);
      }
    } else {
      return Right(cached);
    }
  }

  @override
  Future<Either<Failure, Item>> getDealInfo(String id, String name) async {
    final cachedId = cache.getCachedDealId();

    Either<Failure, Item> getCached() {
      try {
        final _id = cache.getCachedDeal(id);

        if (_id == null) return Left(CacheFailure());

        return Right(_id);
      } catch (e) {
        return Left(CacheFailure());
      }
    }

    if (cachedId != id) {
      if (await networkInfo.isConnected) {
        try {
          final deal = await compute(_getDealInfo, name);

          if (deal == null) return getCached();

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

  static Future<Worldstate?> _getWorldstate(WorldstateRequest request) {
    final locale = request.locale.split('_').first;
    final supportedLocale = SupportedLocaleX.fromLocaleCode(locale);

    return _warframestat.getWorldstate(request.platform,
        language: supportedLocale);
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    return _warframestat.getSynthTargets();
  }

  static Future<Item?> _getDealInfo(String name) async {
    final results = List<Item?>.from(await _warframestat.searchItems(name));

    return results.firstWhere(
      (r) => r?.name.toLowerCase() == name.toLowerCase(),
      orElse: () => null,
    );
  }
}

class DealRequest {
  const DealRequest(this.id, this.name);

  final String id;
  final String name;
}

class WorldstateRequest {
  const WorldstateRequest(this.platform, this.locale);

  final GamePlatforms platform;
  final String locale;
}
