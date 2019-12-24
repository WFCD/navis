import 'package:equatable/equatable.dart';
import 'package:navis/utils/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WorldstateEvent extends Equatable {
  const WorldstateEvent();
}

class UpdatedPlatform extends WorldstateEvent {
  const UpdatedPlatform(this.platform);

  final Platforms platform;

  @override
  List<Object> get props => [platform];
}

class Updated extends WorldstateEvent {
  const Updated(this.worldstate);

  final Worldstate worldstate;

  @override
  List<Object> get props => [worldstate];
}

class Failed extends WorldstateEvent {
  const Failed(this.error);

  final Object error;

  @override
  List<Object> get props => [];
}
