import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:wfcd_client/base.dart';
import 'package:worldstate_api_model/entities.dart';

class GetWorldstate extends Usecase<Worldstate, GetWorldstateInstance> {
  const GetWorldstate(this.repository);

  final WorldstateRepository repository;

  @override
  Future<Either<Exception, Worldstate>> call(GetWorldstateInstance instance) {
    return repository.getWorldstate(instance.platform, lang: instance.lang);
  }
}

class GetWorldstateInstance extends Equatable {
  const GetWorldstateInstance(this.platform, {this.lang = 'en'});

  final GamePlatforms platform;
  final String lang;

  @override
  List<Object> get props => [platform, lang];
}
