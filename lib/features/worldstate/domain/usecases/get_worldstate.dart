import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/worldstate_repository.dart';

class GetWorldstate extends Usecase<Worldstate, NoParama> {
  const GetWorldstate(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Failure, Worldstate>> call(NoParama instance) {
    return repository.getWorldstate();
  }
}
