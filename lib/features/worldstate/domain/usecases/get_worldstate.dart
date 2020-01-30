import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class GetWorldstate extends Usecase<Worldstate, Platforms> {
  final WarframestatRepository repository;

  const GetWorldstate(this.repository);

  @override
  Future<Either<Failure, Worldstate>> call(Platforms platform) {
    return repository.getWorldstate(platform);
  }
}
