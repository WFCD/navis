import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class SynthRepository {
  const SynthRepository();

  Future<Either<Failure, List<SynthTarget>>> getSynthTargets();
}
