//import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:navis/models/export.dart';

abstract class WorldStates extends Equatable {
  WorldStates([List props = const []]) : super(props);

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

class WorldstateLoaded extends WorldStates {
  WorldstateLoaded(this._worldstate) : super([_worldstate.timestamp]);

  final WorldState _worldstate;

  @override
  String get timestamp => _worldstate.timestamp;

  @override
  List<OrbiterNews> get news => _worldstate.news;

  @override
  List<Event> get events => _worldstate.events;

  @override
  List<Alert> get alerts => _worldstate.alerts;

  @override
  Sortie get sortie => _worldstate.sortie;

  @override
  List<Syndicate> get syndicates => _worldstate.syndicates;

  @override
  List<VoidFissure> get fissures => _worldstate.voidFissures;

  @override
  List<Invasion> get invasions => _worldstate.invasions;

  @override
  VoidTrader get trader => _worldstate.trader;

  @override
  List<DarvoDeal> get dailyDeals => _worldstate.dailyDeals;

  @override
  List<PersistentEnemie> get acolytes => _worldstate.persistentEnemies;

  @override
  Earth get earth => _worldstate.earth;

  @override
  Earth get cetus => _worldstate.cetus;

  @override
  Vallis get vallis => _worldstate.vallis;

  @override
  Nightwave get nightwave => _worldstate?.nightwave;
}
