import 'package:warframestat_client/warframestat_client.dart';

extension WorldstateX on Worldstate {
  void clean() {
    alerts.retainWhere((e) => e.active);

    news.sort((a, b) => b.date.compareTo(a.date));

    syndicateMissions
      ..retainWhere((s) => s.jobs.isNotEmpty)
      ..retainWhere((s) => s.active)
      ..sort((a, b) => a.syndicate.compareTo(b.syndicate));

    fissures
      ..retainWhere((e) => !e.expired)
      ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

    invasions.retainWhere((e) => !e.completed);

    // Not sure why some items cost 1 plat when in-game they don't so best to filter those out until I understand why
    const platThreshold = 1;
    flashSales
      ..retainWhere((s) => s.isShownInMarket && s.premiumOverride > platThreshold && !s.expired)
      ..sort((a, b) => a.expiry.compareTo(b.expiry));

    for (final c in calendar) {
      c.days.removeWhere((d) => d.events.isEmpty);
    }
  }
}
