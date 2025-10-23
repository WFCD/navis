import 'package:warframestat_client/warframestat_client.dart' show Language;
import 'package:worldstate_models/worldstate_models.dart';

extension WorldstateX on Worldstate {
  void clean(Language language) {
    alerts.retainWhere((e) => e.isActive);

    news
      ..retainWhere((n) => !n.isCommunity)
      ..sort((a, b) => b.date.compareTo(a.date));

    syndicateMissions
      ..retainWhere((s) => s.bounties?.isNotEmpty ?? false)
      ..retainWhere((s) => s.isActive)
      ..sort((a, b) => a.name.compareTo(b.name));

    fissures
      ..retainWhere((e) => e.isActive)
      ..sort((a, b) => a.tierNum.compareTo(b.tierNum));

    invasions.retainWhere((e) => !e.isCompleted);

    // Not sure why some items cost 1 plat when in-game they don't so best to filter those out until I understand why
    const platThreshold = 1;
    flashSales
      ..retainWhere((s) => s.shownInMarket && s.premiumOverride > platThreshold)
      ..sort((a, b) => a.expiry.compareTo(b.expiry));

    calendar.days.removeWhere((d) => d.events.isEmpty);
  }
}
