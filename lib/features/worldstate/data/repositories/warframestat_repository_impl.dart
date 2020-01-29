import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_local.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

typedef ContactEndpoint<T> = Future<T> Function();
typedef CacheEndpoint<T> = Future<void> Function(T toCache);
typedef RestoreEndpoint<T> = T Function();

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
      cacheEndpoint: local.cacheSynthTargets,
      restoreEndpoint: local.getCachedTargets,
    );
  }

  @override
  Future<Either<Failure, Worldstate>> getWorldstate(Platforms platform) async {
    return _execute<Worldstate>(
      () => remote.getWorldstate(platform),
      cacheEndpoint: local.cacheWorldstate,
      restoreEndpoint: local.getCachedState,
    );
  }

  Future<Either<Failure, T>> _execute<T>(
    ContactEndpoint<T> function, {
    CacheEndpoint<T> cacheEndpoint,
    RestoreEndpoint<T> restoreEndpoint,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final state = await function();
        if (cacheEndpoint != null) await cacheEndpoint(state);

        return Right(state);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      if (restoreEndpoint != null) {
        try {
          return Right(restoreEndpoint());
        } on CacheException {
          return Left(CacheFailure());
        }
      } else {
        return Left(CacheFailure());
      }
    }
  }
}
