import 'package:http/http.dart' as http;
import 'package:navis/services/worldstate_service.dart';
import 'package:package_info/package_info.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  Repository(this.client);

  final http.Client client;

  Future<void> initRepository() async {
    _storage ??= await LocalStorageService.getInstance();
    _notifications ??= NotificationService.initialize();
    _packageInfo ??= await PackageInfo.fromPlatform();
    _worldstateService ??= WorldstateService(client, _storage);
  }

  LocalStorageService _storage;
  NotificationService _notifications;
  PackageInfo _packageInfo;
  WorldstateService _worldstateService;

  WorldstateService get worldstateService => _worldstateService;

  NotificationService get notifications => _notifications;

  PackageInfo get packageInfo => _packageInfo;

  LocalStorageService get storage => _storage;
}
