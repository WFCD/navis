import 'package:equatable/equatable.dart';

import 'alert.dart';
import 'arbitration.dart';
import 'construction_progress.dart';
import 'darvo_deal.dart';
import 'earth.dart';
import 'event.dart';
import 'fissure.dart';
import 'invasion.dart';
import 'kuva.dart';
import 'news.dart';
import 'nigthwave.dart';
import 'persistent_enemy.dart';
import 'sentient_outpost.dart';
import 'sortie.dart';
import 'syndicate.dart';
import 'vallis.dart';
import 'void_trader.dart';

class Worldstate extends Equatable {
  const Worldstate({
    this.timestamp,
    this.news,
    this.events,
    this.alerts,
    this.sortie,
    this.syndicateMissions,
    this.fissures,
    this.invasions,
    this.voidTrader,
    this.dailyDeals,
    this.persistentEnemies,
    this.earthCycle,
    this.cetusCycle,
    this.constructionProgress,
    this.vallisCycle,
    this.nightwave,
    this.sentientOutposts,
    this.kuva,
    this.arbitration,
  });

  final DateTime timestamp;

  final List<OrbiterNews> news;
  final List<Event> events;
  final List<Alert> alerts;
  final Sortie sortie;
  final List<Syndicate> syndicateMissions;
  final List<VoidFissure> fissures;
  final List<Invasion> invasions;
  final VoidTrader voidTrader;
  final List<DarvoDeal> dailyDeals;
  final List<PersistentEnemy> persistentEnemies;
  final Earth earthCycle, cetusCycle;
  final ConstructionProgress constructionProgress;
  final Vallis vallisCycle;
  final Nightwave nightwave;
  final SentientOutpost sentientOutposts;
  final List<Kuva> kuva;
  final Arbitration arbitration;

  bool get activeAlerts => alerts?.isNotEmpty ?? false;
  bool get activeArbitration => arbitration.node != null;
  bool get activeEvents => events?.isNotEmpty ?? false;
  bool get activeKuva => kuva?.isNotEmpty ?? false;
  bool get anomalyDetected => sentientOutposts.active ?? false;
  bool get isSaleActive => dailyDeals?.isNotEmpty ?? false;
  bool get enemyActive => persistentEnemies?.isNotEmpty ?? false;

  @override
  List<Object> get props {
    return [
      timestamp,
      news,
      events,
      alerts,
      sortie,
      syndicateMissions,
      fissures,
      invasions,
      voidTrader,
      dailyDeals,
      persistentEnemies,
      earthCycle,
      cetusCycle,
      constructionProgress,
      vallisCycle,
      nightwave,
      sentientOutposts,
      kuva,
      arbitration
    ];
  }
}
