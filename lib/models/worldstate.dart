import 'package:codable/codable.dart';
import 'package:navis/models/export.dart';

class WorldState extends Coding {
  Cetus cetus;
  Earth earth;
  Sortie sortie;
  VoidTrader trader;
  List<Invasions> invasions;
  List<Events> events;
  List<PersistentEnemies> persistentEnemies;
  List<OrbiterNews> news;
  List<Alerts> alerts;
  List<Syndicates> syndicates;
  List<VoidFissures> voidFissures;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    cetus = object.decodeObject('cetusCycle', () => Cetus());
    earth = object.decodeObject('earthCycle', () => Earth());
    sortie = object.decodeObject('sortie', () => Sortie());
    trader = object.decodeObject('voidTrader', () => VoidTrader());
    invasions = object.decodeObjects('invasions', () => Invasions());
    events = object.decodeObjects('events', () => Events());
    persistentEnemies =
        object.decodeObjects('persistentEnemies', () => PersistentEnemies());
    news = object.decodeObjects('news', () => OrbiterNews());
    alerts = object.decodeObjects('alerts', () => Alerts());
    syndicates = object.decodeObjects('syndicateMissions', () => Syndicates());
    voidFissures = object.decodeObjects('fissures', () => VoidFissures());
  }

  @override
  void encode(KeyedArchive object) {
    object.encodeObject('cetusCycle', cetus);
    object.encodeObject('earthCycle', earth);
    object.encodeObject('sortie', sortie);
    object.encodeObject('voidTrader', trader);
    object.encodeObjects('invasions', invasions);
    object.encodeObjects('events', events);
    object.encodeObjects('persistentEnemies', persistentEnemies);
    object.encodeObjects('news', news);
    object.encodeObjects('alerts', alerts);
    object.encodeObjects('syndicateMission', syndicates);
    object.encodeObjects('fissures', voidFissures);
  }
}
