import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../constants/default_durations.dart';
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
  Future<Result<List<SynthTarget>, Failure>> getSynthTargets() async {
    final cached = cache.getCachedTargets();

    Result<List<SynthTarget>, Failure> fallback() {
      if (cached != null) {
        return Ok(cached);
      } else {
        return Err(CacheFailure());
      }
    }

    if (await networkInfo.isConnected) {
      try {
        final targets = await compute(_getTargets, null);

        cache.cacheSynthTargets(targets);

        return Ok(targets);
      } on SocketException {
        return fallback();
      }
    } else {
      return fallback();
    }
  }

  @override
  Future<Result<Worldstate, Failure>> getWorldstate(
      {bool forceUpdate = false}) async {
    final now = DateTime.now();
    final timestamp = cache.getCachedStateTimestamp();
    final age = timestamp?.difference(now).abs() ?? kRefreshTimer;
    final request = WorldstateRequest(
        usersettings.platform, usersettings.language?.languageCode ?? 'en');

    Result<Worldstate, Failure> getcached() {
      final cached = cache.getCachedState();

      if (cached != null) {
        return Ok(cached);
      } else {
        return Err(CacheFailure());
      }
    }

    if (age >= kRefreshTimer || forceUpdate) {
      if (await networkInfo.isConnected) {
        final state =
            await compute(_getWorldstate, request).catchError((dynamic e) {
          if (cache.getCachedState() != null) {
            return cache.getCachedState();
          } else {
            return null;
          }
        });

        if (state != null) {
          cache.cacheWorldstate(state);
          return Ok(state);
        } else {
          return Err(ServerFailure());
        }
      } else {
        return getcached();
      }
    } else {
      return getcached();
    }
  }

  @override
  Future<Result<Item, Failure>> getDealInfo(String id, String name) async {
    final cachedId = cache.getCachedDealId();

    Result<Item, Failure> getCached() {
      try {
        final _id = cache.getCachedDeal(id);

        if (_id == null) return Err(CacheFailure());

        return Ok(_id);
      } catch (e) {
        return Err(CacheFailure());
      }
    }

    if (cachedId != id) {
      if (await networkInfo.isConnected) {
        try {
          final deal = await compute(_getDealInfo, name);

          if (deal == null) {
            return getCached();
          } else {
            cache.cacheDealInfo(id, deal);
          }

          return Ok(deal);
        } on SocketException {
          return Err(OfflineFailure());
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
