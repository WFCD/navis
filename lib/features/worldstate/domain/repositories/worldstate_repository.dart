import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class WorldstateRepository {
  Future<Either<Failure, Worldstate>> getWorldstate();

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();

  Future<Either<Failure, Item>> getDealInfo(String id, String name);
}
