import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:navis/core/data/datasources/warframestat_local.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

typedef ExecuteCallback<T> = Future<T> Function();
typedef CacheCallback<T> = Future<void> Function(T toCache);
typedef RestoreCallback<T> = T Function();

class WarframestatRepositoryImpl implements WarframestatRepository {
  final WarframestatCache local;
  final WarframestatRemote remote;
  final NetworkInfo networkInfo;

  const WarframestatRepositoryImpl({
    @required this.local,
    @required this.remote,
    @required this.networkInfo,
  })  : assert(local != null),
        assert(remote != null),
        assert(networkInfo != null);

  @override
  Future<Either<Failure, List<SynthTarget>>> getSynthTargets() async {
    return _execute<List<SynthTarget>>(
      () => remote.getSynthTargets(),
      executeCaching: local.cacheSynthTargets,
      executeCacheRestore: local.getCachedTargets,
    );
  }

  @override
  Future<Either<Failure, Worldstate>> getWorldstate(
      GamePlatforms platform) async {
    return _execute<Worldstate>(
      () => remote.getWorldstate(platform),
      executeCaching: local.cacheWorldstate,
      executeCacheRestore: local.getCachedState,
    );
  }

  Future<Either<Failure, T>> _execute<T>(
    ExecuteCallback<T> execute, {
    CacheCallback<T> executeCaching,
    RestoreCallback<T> executeCacheRestore,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final state = await execute();
        if (executeCaching != null) await executeCaching(state);

        return Right(state);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      if (executeCacheRestore != null) {
        try {
          return Right(executeCacheRestore());
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(CacheFailure());
      }
    }
  }
}
