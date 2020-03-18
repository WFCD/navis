import 'package:equatable/equatable.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

class GetWorldstate extends Usecase<Worldstate, GetWorldstateInstance> {
  const GetWorldstate(this.repository);

  final WarframestatRepository repository;

  @override
  Future<Worldstate> call(GetWorldstateInstance instance) {
    return repository.getWorldstate(instance.platform, locale: instance.locale);
  }
}

class GetWorldstateInstance extends Equatable {
  const GetWorldstateInstance(this.platform, {this.locale = 'en'});

  final GamePlatforms platform;
  final String locale;

  @override
  List<Object> get props => [platform, locale];
}
