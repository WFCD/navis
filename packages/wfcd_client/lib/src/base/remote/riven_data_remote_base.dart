import 'package:equatable/equatable.dart';
import 'package:worldstate_api_model/entities.dart';

import 'warframestate_remote_base.dart';

enum RivenType { archgun, kitgun, melee, pistol, rifle, shotgun, zaw }

abstract class RivenDataRemoteBase extends Equatable {
  const RivenDataRemoteBase({this.platform});

  final GamePlatforms platform;

  Future<Map<RivenType, Map<String, RivenData>>> getRivenData(
      {String language = 'en'});

  @override
  List<Object> get props => [platform];
}
