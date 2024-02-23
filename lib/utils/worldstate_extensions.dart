import 'package:warframestat_client/warframestat_client.dart';

extension WorldstateX on Worldstate {
  void clean() {
    alerts.retainWhere((e) => e.active);

    news.sort((a, b) => b.date.compareTo(a.date));

    syndicateMissions
      ..retainWhere((s) => s.jobs.isNotEmpty)
      ..sort((a, b) => a.syndicate.compareTo(b.syndicate));

    fissures
      ..retainWhere((e) => !e.expired)
      ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

    invasions.retainWhere((e) => !e.completed);
  }
}
