import 'package:flutter/foundation.dart';
import 'package:oxidized/oxidized.dart';
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
  Future<Result<List<SynthTarget>, Failure>> getSynthTargets() async {
    if (await networkInfo.isConnected) {
      final targets = await compute(_getSynthTargets, NoParama());

      return Ok(targets);
    } else {
      return Err(OfflineFailure());
    }
  }

  static Future<List<SynthTarget>> _getSynthTargets(NoParama noparama) {
    final _warframestat = WarframestatClient();

    return _warframestat.getSynthTargets();
  }
}
