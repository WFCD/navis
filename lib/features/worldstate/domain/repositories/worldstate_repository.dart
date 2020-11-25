import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:warframestat_api_models/entities.dart';

abstract class WorldstateRepository {
  Future<Either<Failure, Worldstate>> getWorldstate();

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();

  Future<Either<Failure, Item>> getDealInfo(String id, String name);
}
