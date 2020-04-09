// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'worldstate_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldstateModel _$WorldstateModelFromJson(Map<String, dynamic> json) {
  return WorldstateModel(
    timestamp: json['timestamp'] == null
        ? null
        : DateTime.parse(json['timestamp'] as String),
    orbiterNewsModels: (json['news'] as List)
        ?.map((e) => e == null
            ? null
            : OrbiterNewsModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    eventModels: (json['events'] as List)
        ?.map((e) =>
            e == null ? null : EventModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    alertModels: (json['alerts'] as List)
        ?.map((e) =>
            e == null ? null : AlertModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sortieModel: json['sortie'] == null
        ? null
        : SortieModel.fromJson(json['sortie'] as Map<String, dynamic>),
    syndicateMissionModels: (json['syndicateMissions'] as List)
        ?.map((e) => e == null
            ? null
            : SyndicateModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    fissureModels: (json['fissures'] as List)
        ?.map((e) => e == null
            ? null
            : VoidFissureModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    invasionModels: (json['invasions'] as List)
        ?.map((e) => e == null
            ? null
            : InvasionModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    voidTraderModel: json['voidTrader'] == null
        ? null
        : VoidTraderModel.fromJson(json['voidTrader'] as Map<String, dynamic>),
    dailyDealModels: (json['dailyDeals'] as List)
        ?.map((e) => e == null
            ? null
            : DarvoDealModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    persistentEnemyModels: (json['persistentEnemies'] as List)
        ?.map((e) => e == null
            ? null
            : PersistentEnemyModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    earthCycleModel: json['earthCycle'] == null
        ? null
        : EarthModel.fromJson(json['earthCycle'] as Map<String, dynamic>),
    cetusCycleModel: json['cetusCycle'] == null
        ? null
        : EarthModel.fromJson(json['cetusCycle'] as Map<String, dynamic>),
    constructionProgressModel: json['constructionProgress'] == null
        ? null
        : ConstructionProgressModel.fromJson(
            json['constructionProgress'] as Map<String, dynamic>),
    vallisCycleModel: json['vallisCycle'] == null
        ? null
        : VallisModel.fromJson(json['vallisCycle'] as Map<String, dynamic>),
    nightwaveModel: json['nightwave'] == null
        ? null
        : NightwaveModel.fromJson(json['nightwave'] as Map<String, dynamic>),
    kuvaModel: (json['kuva'] as List)
        ?.map((e) =>
            e == null ? null : KuvaModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    sentientOutpostModel: json['sentientOutposts'] == null
        ? null
        : SentientOutpostModel.fromJson(
            json['sentientOutposts'] as Map<String, dynamic>),
    arbitrationModel: json['arbitration'] == null
        ? null
        : ArbitrationModel.fromJson(
            json['arbitration'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WorldstateModelToJson(WorldstateModel instance) =>
    <String, dynamic>{
      'timestamp': instance.timestamp?.toIso8601String(),
      'news': instance.orbiterNewsModels,
      'events': instance.eventModels,
      'alerts': instance.alertModels,
      'sortie': instance.sortieModel,
      'syndicateMissions': instance.syndicateMissionModels,
      'fissures': instance.fissureModels,
      'invasions': instance.invasionModels,
      'voidTrader': instance.voidTraderModel,
      'dailyDeals': instance.dailyDealModels,
      'persistentEnemies': instance.persistentEnemyModels,
      'earthCycle': instance.earthCycleModel,
      'cetusCycle': instance.cetusCycleModel,
      'constructionProgress': instance.constructionProgressModel,
      'vallisCycle': instance.vallisCycleModel,
      'nightwave': instance.nightwaveModel,
      'sentientOutposts': instance.sentientOutpostModel,
      'kuva': instance.kuvaModel,
      'arbitration': instance.arbitrationModel,
    };
