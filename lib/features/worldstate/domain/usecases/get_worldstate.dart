import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class GetWorldstate extends Usecase<Worldstate, GamePlatforms> {
  const GetWorldstate(this.repository);

  final WarframestatRepository repository;

  @override
  Future<Worldstate> call(GamePlatforms platform) {
    return repository.getWorldstate(platform);
  }
}
