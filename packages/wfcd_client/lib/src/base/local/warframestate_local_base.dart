import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/entities.dart';

abstract class WarframestateCacheBase {
  void cacheDealInfo(String id, BaseItem item);

  void cacheSynthTargets(List<SynthTarget> targets);

  void cacheWorldstate(Worldstate state);

  String getCachedDealId();

  BaseItem getCachedDeal(String id);

  Worldstate getCachedState();

  List<SynthTarget> getCachedTargets();
}
