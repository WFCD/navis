import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WarframestatRepository {
  Future<Either<Failure, Worldstate>> getWorldstate(Platforms platform);

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();
}
