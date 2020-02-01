import 'package:dartz/dartz.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/data/datasources/warframestat_remote.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class GetWorldstate extends Usecase<Worldstate, GamePlatforms> {
  final WarframestatRepository repository;

  const GetWorldstate(this.repository);

  @override
  Future<Either<Failure, Worldstate>> call(GamePlatforms platform) {
    return repository.getWorldstate(platform);
  }
}
