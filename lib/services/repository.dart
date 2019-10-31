import 'package:http/http.dart';
import 'package:navis/services/storage/cache_storage.service.dart';
import 'package:navis/services/wfcd_api/drop_table_api.service.dart';
import 'package:package_info/package_info.dart';

import 'notification_service.dart';
import 'storage/persistent_storage.service.dart';
import 'wfcd_api/worldstate_api.service.dart';

class Repository {
  Repository(
    this.persistent,
    this.cache,
    this.notifications,
    this.packageInfo,
    this.worldstateService,
    this.dropTableApiService,
  );

  final PersistentStorageService persistent;
  final CacheStorageService cache;
  final NotificationService notifications;
  final PackageInfo packageInfo;
  final WorldstateApiService worldstateService;
  final DropTableApiService dropTableApiService;

  static Future<Repository> initRepository({Client client}) async {
    final _persistent = PersistentStorageService();
    final _cache = CacheStorageService();

    await _persistent.startInstance();
    await _cache.startInstance();

    final _packageInfo = await PackageInfo.fromPlatform();

    return Repository(
      _persistent,
      _cache,
      NotificationService.initialize(),
      _packageInfo,
      WorldstateApiService(),
      DropTableApiService(),
    );
  }
}
