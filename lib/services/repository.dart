import 'package:http/http.dart';
import 'package:navis/services/worldstate_service.dart';
import 'package:navis/utils/metric_client.dart';
import 'package:package_info/package_info.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  Repository(
    this.storage,
    this.notifications,
    this.packageInfo,
    this.worldstateService,
  );

  final LocalStorageService storage;
  final NotificationService notifications;
  final PackageInfo packageInfo;
  final WorldstateService worldstateService;

  static Future<Repository> initRepository({Client client}) async {
    client ??= MetricHttpClient(Client());

    final _storage = await LocalStorageService.getInstance();
    final _notifications = NotificationService.initialize();
    final _packageInfo = await PackageInfo.fromPlatform();
    final _worldstateService = WorldstateService(client, _storage);

    return Repository(
      _storage,
      _notifications,
      _packageInfo,
      _worldstateService,
    );
  }
}
