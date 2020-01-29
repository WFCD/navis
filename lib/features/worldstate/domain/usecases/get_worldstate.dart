import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class GetWorldstate {
  final WorldstateRepository repository;

  const GetWorldstate(this.repository);

  Future<Either<Failure, Worldstate>> call(Platforms platform) async {
    return repository.getWorldstate(platform);
  }
}
