import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:worldstate_api_model/misc.dart';

class GetSynthTargets extends Usecase<List<SynthTarget>, NoParama> {
  final WarframestatRepository repository;

  const GetSynthTargets(this.repository);

  @override
  Future<Either<Failure, List<SynthTarget>>> call(NoParama params) {
    return repository.getSynthTargets();
  }
}
