import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:warframestat_api_models/entities.dart';

abstract class SynthRepository {
  const SynthRepository();

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();
}
