import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:worldstate_api_model/entities.dart';

abstract class SynthRepository {
  const SynthRepository();

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();
}
