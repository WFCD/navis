import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/utils/file_utils.dart';
import 'package:navis/utils/metric_client.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  Repository({
    @required this.worldstateApi,
    @required this.storageService,
    @required this.packageInfo,
    @required this.notificationService,
  })  : assert(storageService != null),
        assert(packageInfo != null),
        assert(notificationService != null);

  static Future<Repository> initialize({http.Client client}) async {
    WidgetsFlutterBinding.ensureInitialized();

    final metricClient = MetricHttpClient(http.Client());

    final LocalStorageService _storageService =
        await LocalStorageService.getInstance();
    final PackageInfo _info = await PackageInfo.fromPlatform();

    return Repository(
      worldstateApi: WorldstateApiWrapper(client ?? metricClient),
      storageService: _storageService,
      packageInfo: _info,
      notificationService: NotificationService.initialize(),
    );
  }

  final WorldstateApiWrapper worldstateApi;
  final LocalStorageService storageService;
  final PackageInfo packageInfo;
  final NotificationService notificationService;

  Future<List<ItemObject>> searchItem(String searchTerm) async =>
      await worldstateApi.searchItems(searchTerm);

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    final worldstate = await worldstateApi
        .getWorldstate(platform ?? storageService.platform ?? Platforms.pc);

    return cleanState(worldstate);
  }

  Future<File> initializeDropTable() async {
    final doesFileExist = await checkFile('/drop_table.json');
    final timestamp = await _getDropTableTimestamp();

    if (doesFileExist != true) {
      try {
        await _downloadDropTable();
        storageService.saveTimestamp(timestamp);
      } catch (error) {
        storageService.saveTimestamp(DateTime.now());
      }

      return getFile('/drop_table.json');
    }

    return getFile('/drop_table.json');
  }

  Future<bool> updateDropTable() async {
    final timestamp = await _getDropTableTimestamp();

    if (timestamp != storageService.tableTimestamp) {
      await _downloadDropTable();

      storageService.saveTimestamp(timestamp);

      return true;
    }

    return false;
  }

  Future<DateTime> _getDropTableTimestamp() async {
    const infoUrl = 'https://drops.warframestat.us/data/info.json';
    final info = json.decode((await worldstateApi.client.get(infoUrl)).body);

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
  }

  Future<void> _downloadDropTable([String path]) async {
    const dropTable = 'https://drops.warframestat.us/data/all.slim.json';

    final response = await worldstateApi.client.get(dropTable);

    if (response?.statusCode != 200)
      throw Exception('Drop table failed to download: ${response?.statusCode}');

    await saveFile('/drop_table.json', response.body);
  }
}
