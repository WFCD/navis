import 'package:warframestat_client/warframestat_client.dart';

extension WorldstateNavisX on Worldstate {
  // bool get activeAcolytes => worldstate.enemyActive;

  bool get activeAlerts => alerts.isNotEmpty;

  bool get activeSales => flashSales.isNotEmpty;

  bool get arbitrationActive => arbitration != null && !arbitration!.node.contains('000');

  bool get eventsActive => events.isNotEmpty;

  bool get outpostDetected => sentientOutposts != null;

  bool get deepArchimedeaActive => deepArchimedea != null;
}
