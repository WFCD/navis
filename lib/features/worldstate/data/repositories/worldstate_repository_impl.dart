import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:navis/core/data/datasources/wfcd_local_data_source.dart';
import 'package:navis/core/data/datasources/wfcd_remote_data_source.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/network/network_info.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

typedef ContactEndpoint<T> = Future<T> Function();
typedef CacheEndpoint<T> = Future<void> Function(T toCache);
typedef RestoreEndpoint<T> = T Function();

class WorldstateRepositoryImpl implements WorldstateRepository {
  final WfcdCacheDataSource localDataSource;
  final WfcdRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  const WorldstateRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
  })  : assert(localDataSource != null),
        assert(remoteDataSource != null),
        assert(networkInfo != null);

  @override
  Future<Either<Failure, List<SynthTarget>>> getSynthTargets() async {
    return _execute<List<SynthTarget>>(
      () => remoteDataSource.getSynthTargets(),
      cacheEndpoint: localDataSource.cacheSynthTargets,
      restoreEndpoint: localDataSource.getCachedTargets,
    );
  }

  @override
  Future<Either<Failure, Worldstate>> getWorldstate(Platforms platform) async {
    return _execute<Worldstate>(
      () => remoteDataSource.getWorldstate(platform),
      cacheEndpoint: localDataSource.cacheWorldstate,
      restoreEndpoint: localDataSource.getCachedState,
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
