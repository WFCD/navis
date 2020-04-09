import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/worldstate.dart';

import 'alert_model.dart';
import 'arbitration_model.dart';
import 'construction_progress_model.dart';
import 'darvo_deal_model.dart';
import 'earth_model.dart';
import 'event_model.dart';
import 'fissure_model.dart';
import 'invasion_model.dart';
import 'kuva_model.dart';
import 'news_model.dart';
import 'nightwave_model.dart';
import 'persistent_enemy_model.dart';
import 'sentient_outpost_model.dart';
import 'sortie_model.dart';
import 'syndicate_model.dart';
import 'vallis_model.dart';
import 'void_trader_model.dart';

part 'worldstate_model.g.dart';

@JsonSerializable()
class WorldstateModel extends Worldstate {
  const WorldstateModel({
    DateTime timestamp,
    this.orbiterNewsModels,
    this.eventModels,
    this.alertModels,
    this.sortieModel,
    this.syndicateMissionModels,
    this.fissureModels,
    this.invasionModels,
    this.voidTraderModel,
    this.dailyDealModels,
    this.persistentEnemyModels,
    this.earthCycleModel,
    this.cetusCycleModel,
    this.constructionProgressModel,
    this.vallisCycleModel,
    this.nightwaveModel,
    this.kuvaModel,
    this.sentientOutpostModel,
    this.arbitrationModel,
  }) : super(
          timestamp: timestamp,
          news: orbiterNewsModels,
          events: eventModels,
          alerts: alertModels,
          sortie: sortieModel,
          syndicateMissions: syndicateMissionModels,
          fissures: fissureModels,
          invasions: invasionModels,
          voidTrader: voidTraderModel,
          dailyDeals: dailyDealModels,
          persistentEnemies: persistentEnemyModels,
          earthCycle: earthCycleModel,
          cetusCycle: cetusCycleModel,
          constructionProgress: constructionProgressModel,
          vallisCycle: vallisCycleModel,
          nightwave: nightwaveModel,
          kuva: kuvaModel,
          sentientOutposts: sentientOutpostModel,
          arbitration: arbitrationModel,
        );

  factory WorldstateModel.fromJson(Map<String, dynamic> json) {
    return _$WorldstateModelFromJson(json);
  }

  @JsonKey(name: 'news')
  final List<OrbiterNewsModel> orbiterNewsModels;

  @JsonKey(name: 'events')
  final List<EventModel> eventModels;

  @JsonKey(name: 'alerts')
  final List<AlertModel> alertModels;

  @JsonKey(name: 'sortie')
  final SortieModel sortieModel;

  @JsonKey(name: 'syndicateMissions')
  final List<SyndicateModel> syndicateMissionModels;

  @JsonKey(name: 'fissures')
  final List<VoidFissureModel> fissureModels;

  @JsonKey(name: 'invasions')
  final List<InvasionModel> invasionModels;

  @JsonKey(name: 'voidTrader')
  final VoidTraderModel voidTraderModel;

  @JsonKey(name: 'dailyDeals')
  final List<DarvoDealModel> dailyDealModels;

  @JsonKey(name: 'persistentEnemies')
  final List<PersistentEnemyModel> persistentEnemyModels;

  @JsonKey(name: 'earthCycle')
  final EarthModel earthCycleModel;

  @JsonKey(name: 'cetusCycle')
  final EarthModel cetusCycleModel;

  @JsonKey(name: 'constructionProgress')
  final ConstructionProgressModel constructionProgressModel;

  @JsonKey(name: 'vallisCycle')
  final VallisModel vallisCycleModel;

  @JsonKey(name: 'nightwave')
  final NightwaveModel nightwaveModel;

  @JsonKey(name: 'sentientOutposts')
  final SentientOutpostModel sentientOutpostModel;

  @JsonKey(name: 'kuva')
  final List<KuvaModel> kuvaModel;

  @JsonKey(name: 'arbitration')
  final ArbitrationModel arbitrationModel;

  Map<String, dynamic> toJson() => _$WorldstateModelToJson(this);
}
