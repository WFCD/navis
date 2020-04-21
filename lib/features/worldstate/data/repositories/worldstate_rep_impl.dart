import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/core/network/network_info.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/base.dart';
import 'package:wfcd_client/locals.dart';
import 'package:wfcd_client/remotes.dart';
import 'package:worldstate_api_model/entities.dart';

//TODO: replace Exceptions wiht custom ones
class WorldstateRepositoryImpl implements WorldstateRepository {
  WorldstateRepositoryImpl(this.networkInfo, this.cache);

  final NetworkInfo networkInfo;
  final WarframestatCache cache;

  @override
  Future<Either<Exception, List<SynthTarget>>> getSynthTargets() async {
    return run<List<SynthTarget>, void>(
      _getTargets,
      null,
      cache.cacheSynthTargets,
      cache.getCachedTargets,
    );
  }

  @override
  Future<Either<Exception, Worldstate>> getWorldstate(GamePlatforms platform,
      {String lang = 'en'}) async {
    final request = _WorldstateRequest(platform, lang: lang);

    return run<Worldstate, _WorldstateRequest>(
      _getWorldstate,
      request,
      cache.cacheWorldstate,
      cache.getCachedState,
    );
  }

  @override
  Future<Either<Exception, BaseItem>> getDealInfo(
      String id, String name) async {
    if (await networkInfo.isConnected) {
      try {
        final item = await compute(_getDealInfo, name);
        cache.cacheDealInfo(id, item);

        return Right(item);
      } on SocketException {
        return Left(Exception());
      }
    } else {
      try {
        return Right(cache.getCachedDeal());
      } catch (e) {
        return Left(Exception());
      }
    }
  }

  static Future<Worldstate> _getWorldstate(_WorldstateRequest request) {
    final warframestat = WarframestatRemote(http.Client());

    return warframestat.getWorldstate(request.platform, language: request.lang);
  }

  // Becasue compute needs an entry argument noParam can be anything
  static Future<List<SynthTarget>> _getTargets(dynamic noParam) {
    final warframestat = WarframestatRemote(http.Client());

    return warframestat.getSynthTargets();
  }

  static Future<BaseItem> _getDealInfo(String name) async {
    final warframestat = WarframestatRemote(http.Client());
    final results = await warframestat.searchItems(name);

    return results
        .firstWhere((r) => r.name.toLowerCase().contains(name.toLowerCase()));
  }

  Future<Either<Exception, T>> run<T, P>(
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
        return Left(Exception());
      }
    } else {
      try {
        return Right(restore());
      } catch (e) {
        return Left(Exception());
      }
    }
  }
}

class _WorldstateRequest {
  const _WorldstateRequest(this.platform, {this.lang = 'en'});

  final GamePlatforms platform;
  final String lang;
}
