import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WarframestatRepository {
  Future<Either<Failure, Worldstate>> getWorldstate(GamePlatforms platform);

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();
}
