import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../../core/usecases/usecases.dart';
import '../../domain/repositories/synth_target_repository.dart';

class SynthRepositoryImpl extends SynthRepository {
  const SynthRepositoryImpl(this.networkInfo);

  final NetworkInfo networkInfo;

  @override
  Future<Either<Failure, List<SynthTarget>>> getSynthTargets() async {
    if (await networkInfo.isConnected) {
      final targets = await compute(_getSynthTargets, NoParama());

      return Right(targets);
    } else {
      return Left(OfflineFailure());
    }
  }

  static Future<List<SynthTarget>> _getSynthTargets(NoParama noparama) {
    final _warframestat = WarframestatClient();

    return _warframestat.getSynthTargets();
  }
}
