import 'package:codable/codable.dart';
import 'package:navis/models/export.dart';

class WorldState extends Coding {
  String timestamp;
  List<OrbiterNews> news;
  List<Event> events;
  Sortie sortie;
  List<Syndicate> syndicates;
  List<VoidFissures> voidFissures;
  List<Invasions> invasions;
  VoidTrader trader;
  List<PersistentEnemies> persistentEnemies;
  Earth earth;
  Earth cetus;
  Vallis vallis;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    timestamp = object.decode('timestamp');
    cetus = object.decodeObject('cetusCycle', () => Earth());
    earth = object.decodeObject('earthCycle', () => Earth());
    vallis = object.decodeObject('vallisCycle', () => Vallis());
    sortie = object.decodeObject('sortie', () => Sortie());
    trader = object.decodeObject('voidTrader', () => VoidTrader());
    invasions = object.decodeObjects('invasions', () => Invasions());
    events = object.decodeObjects('events', () => Event());
    persistentEnemies =
        object.decodeObjects('persistentEnemies', () => PersistentEnemies());
    news = object.decodeObjects('news', () => OrbiterNews());
    syndicates = object.decodeObjects('syndicateMissions', () => Syndicate());
    voidFissures = object.decodeObjects('fissures', () => VoidFissures());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('timestamp', timestamp);
    object.encodeObject('cetusCycle', cetus);
    object.encodeObject('earthCycle', earth);
    object.encodeObject('vallisCycle', vallis);
    object.encodeObject('sortie', sortie);
    object.encodeObject('voidTrader', trader);
    object.encodeObjects('invasions', invasions);
    object.encodeObjects('events', events);
    object.encodeObjects('persistentEnemies', persistentEnemies);
    object.encodeObjects('news', news);
    object.encodeObjects('syndicateMission', syndicates);
    object.encodeObjects('fissures', voidFissures);
  }
}
