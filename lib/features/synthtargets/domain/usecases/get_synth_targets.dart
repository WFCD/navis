import 'package:dartz/dartz.dart';
import 'package:wfcd_client/entities.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecases.dart';
import '../repositories/synth_target_repository.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  const GetSynthTargets(this.repository);

  final SynthRepository repository;

  @override
  Future<Either<Failure, List<SynthTarget>>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
