import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class SynthRepository {
  const SynthRepository();

  Future<Result<List<SynthTarget>, Failure>> getSynthTargets();
}
