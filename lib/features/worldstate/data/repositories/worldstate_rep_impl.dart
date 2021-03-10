import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/local/user_settings.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/worldstate_repository.dart';
import '../datasources/warframestate_local.dart';

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
  Future<Either<Failure, Worldstate>> getWorldstate({bool forceUpdate}) async {
    const refresh = Duration(minutes: 1);

    final now = DateTime.now();
    final cached = cache.getCachedState();
    final age = cached?.timestamp?.difference(now)?.abs();
    final request =
        WorldstateRequest(usersettings.platform, Platform.localeName);

    if (cached == null || age >= refresh || forceUpdate) {
      if (await networkInfo.isConnected) {
        try {
          final state =
              await compute(_getWorldstate, request).catchError((e, s) {
            Sentry.captureException(e, stackTrace: s);
            return cached;
          });

          if (state == null) return Right(cached);

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
  Future<Either<Failure, Item>> getDealInfo(String id, String name) async {
    final cachedId = cache.getCachedDealId();

    Either<Failure, Item> getCached() {
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

  static Future<Worldstate> _getWorldstate(WorldstateRequest request) {
    final locale = request.locale.split('_').first;
    final supportedLocale = SupportedLocaleX.fromLocaleCode(locale);

    return _warframestat.getWorldstate(request.platform,
        language: supportedLocale);
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    return _warframestat.getSynthTargets();
  }

  static Future<Item> _getDealInfo(String name) async {
    final results = await _warframestat.searchItems(name);

    return results.firstWhere(
      (r) => r.name.toLowerCase() == name.toLowerCase(),
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
