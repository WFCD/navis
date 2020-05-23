import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:worldstate_api_model/entities.dart';

import '../repositories/synth_target_repository.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  const GetSynthTargets(this.repository);

  final SynthRepository repository;

  @override
  Future<Either<Failure, List<SynthTarget>>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
