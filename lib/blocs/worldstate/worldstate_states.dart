//import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/export.dart';

abstract class WorldStates extends Equatable {
  WorldStates([List props = const [], this.worldstate]) : super(props);

  Worldstate worldstate;

  String timestamp;
  List<OrbiterNews> news;
  List<Event> events;
  List<Alert> alerts;
  Sortie sortie;
  List<Syndicate> syndicates;
  List<VoidFissure> fissures;
  List<Invasion> invasions;
  VoidTrader trader;
  List<DarvoDeal> dailyDeals;
  List<PersistentEnemie> acolytes;
  Earth earth;
  Earth cetus;
  Vallis vallis;
  Nightwave nightwave;
}

class WorldstateUninitialized extends WorldStates {}

class WorldstateError extends WorldStates {
  WorldstateError(this.error) : super([error]);

  final String error;
}

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded(Worldstate worldstate)
      : super([worldstate.timestamp], worldstate);

  @override
  String get timestamp => worldstate.timestamp;

  @override
  List<OrbiterNews> get news => worldstate.news;

  @override
  List<Event> get events => worldstate.events;

  @override
  List<Alert> get alerts => worldstate.alerts;

  @override
  Sortie get sortie => worldstate.sortie;

  @override
  List<Syndicate> get syndicates => worldstate.syndicates;

  @override
  List<VoidFissure> get fissures => worldstate.voidFissures;

  @override
  List<Invasion> get invasions => worldstate.invasions;

  @override
  VoidTrader get trader => worldstate.trader;

  @override
  List<DarvoDeal> get dailyDeals => worldstate.dailyDeals;

  @override
  List<PersistentEnemie> get acolytes => worldstate.persistentEnemies;

  @override
  Earth get earth => worldstate.earth;

  @override
  Earth get cetus => worldstate.cetus;

  @override
  Vallis get vallis => worldstate.vallis;

  @override
  Nightwave get nightwave => worldstate?.nightwave;
}
