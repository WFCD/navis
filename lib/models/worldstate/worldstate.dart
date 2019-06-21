import 'package:codable/codable.dart';
import 'package:navis/models/export.dart';

class WorldState extends Coding {
  String timestamp;
  List<OrbiterNews> news;
  List<Event> events;
  List<Alert> alerts;
  Sortie sortie;
  List<Syndicate> syndicates;
  List<VoidFissure> voidFissures;
  List<Invasion> invasions;
  VoidTrader trader;
  List<DarvoDeal> dailyDeals;
  List<PersistentEnemie> persistentEnemies;
  Earth earth;
  Earth cetus;
  Vallis vallis;
  Nightwave nightwave;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    timestamp = object.decode('timestamp');
    cetus = object.decodeObject('cetusCycle', () => Earth());
    earth = object.decodeObject('earthCycle', () => Earth());
    vallis = object.decodeObject('vallisCycle', () => Vallis());
    nightwave = object.decodeObject('nightwave', () => Nightwave());
    sortie = object.decodeObject('sortie', () => Sortie());
    trader = object.decodeObject('voidTrader', () => VoidTrader());
    dailyDeals = object.decodeObjects('dailyDeals', () => DarvoDeal());
    invasions = object.decodeObjects('invasions', () => Invasion());
    events = object.decodeObjects('events', () => Event());
    persistentEnemies =
        object.decodeObjects('persistentEnemies', () => PersistentEnemie());
    news = object.decodeObjects('news', () => OrbiterNews());
    alerts = object.decodeObjects('alerts', () => Alert());
    syndicates = object.decodeObjects('syndicateMissions', () => Syndicate());
    voidFissures = object.decodeObjects('fissures', () => VoidFissure());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('timestamp', timestamp);
    object.encodeObject('cetusCycle', cetus);
    object.encodeObject('earthCycle', earth);
    object.encodeObject('vallisCycle', vallis);
    object.encodeObject('sortie', sortie);
    object.encodeObject('voidTrader', trader);
    object.encodeObject('nightwave', nightwave);
    object.encodeObjects('dailyDeals', dailyDeals);
    object.encodeObjects('invasions', invasions);
    object.encodeObjects('events', events);
    object.encodeObjects('persistentEnemies', persistentEnemies);
    object.encodeObjects('news', news);
    object.encodeObjects('alerts', alerts);
    object.encodeObjects('syndicateMissions', syndicates);
    object.encodeObjects('fissures', voidFissures);
  }
}
