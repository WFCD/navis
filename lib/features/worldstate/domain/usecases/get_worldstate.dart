import 'package:oxidized/oxidized.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/worldstate_repository.dart';

class GetWorldstate extends Usecase<Worldstate, bool> {
  const GetWorldstate(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Result<Worldstate, Failure>> call(bool params) {
    return repository.getWorldstate(forceUpdate: params);
  }
}
