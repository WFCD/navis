import 'package:dartz/dartz.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:worldstate_api_model/entities.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  const GetSynthTargets(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Exception, List<SynthTarget>>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
