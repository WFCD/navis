import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:worldstate_api_model/entities.dart';

class GetWorldstate extends Usecase<Worldstate, NoParama> {
  const GetWorldstate(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Failure, Worldstate>> call(NoParama instance) {
    return repository.getWorldstate();
  }
}
