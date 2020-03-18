import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

abstract class WarframestatRepository {
  Future<Worldstate> getWorldstate(GamePlatforms platform,
      {String locale = 'en'});

  Future<List<SynthTarget>> getSynthTargets();

  Future<BaseItem> getDealInfo(String id, String itemName);
}
