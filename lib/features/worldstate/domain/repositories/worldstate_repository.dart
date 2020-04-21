import 'package:dartz/dartz.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/base.dart';
import 'package:worldstate_api_model/entities.dart';

abstract class WorldstateRepository {
  Future<Either<Exception, Worldstate>> getWorldstate(GamePlatforms platform,
      {String lang = 'en'});

  Future<Either<Exception, List<SynthTarget>>> getSynthTargets();

  Future<Either<Exception, BaseItem>> getDealInfo(String id, String name);
}
