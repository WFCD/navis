import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';

abstract class WorldstateRepository {
  Future<Result<Worldstate, Failure>> getWorldstate({bool forceUpdate});

  Future<Result<List<SynthTarget>, Failure>> getSynthTargets();

  Future<Result<Item, Failure>> getDealInfo(String id, String name);
}
