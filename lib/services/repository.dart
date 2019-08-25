import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/utils/client.dart';
import 'package:navis/utils/file_utils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  Repository({
    @required this.client,
    @required this.storageService,
    @required this.packageInfo,
    @required this.notificationService,
  })  : assert(storageService != null),
        assert(packageInfo != null),
        assert(notificationService != null);

  static Future<Repository> initialize([http.Client client]) async {
    WidgetsFlutterBinding.ensureInitialized();

    final LocalStorageService _storageService =
        await LocalStorageService.getInstance();
    final PackageInfo _info = await PackageInfo.fromPlatform();

    return Repository(
      client: client ?? MetricHttpClient(http.Client()),
      storageService: _storageService,
      packageInfo: _info,
      notificationService: NotificationService.initialize(),
    );
  }

  final http.Client client;
  final LocalStorageService storageService;
  final PackageInfo packageInfo;
  final NotificationService notificationService;

  static Future<dynamic> searchItem(String searchTerm) async {
    final response = await http.get(
        'https://api.warframestat.us/items/search/${searchTerm.toLowerCase()}');
    final List<dynamic> data = json.decode(response.body);

    return data;
  }

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    Worldstate worldstate;

    try {
      platform ??= storageService.platform ?? Platforms.pc;
      final response = await WorldstateApiWrapper.getInstance(platform, client);

      worldstate = cleanState(response.worldstate);
    } catch (e) {
      if (await checkFile('/worldstate.json')) {
        final cached = await getFile('/worldstate.json');
        final state =
            Worldstate.fromJson(json.decode(cached.readAsStringSync()));

        worldstate = cleanState(state);
      }
    }

    saveFile('/worldstate.json', json.encode(worldstate.toJson()));

    return worldstate;
  }

  Future<File> initializeDropTable() async {
    final doesFileExist = await checkFile('/drop_table.json');
    final timestamp = await _getDropTableTimestamp();

    if (doesFileExist != true) {
      await _downloadDropTable();

      storageService.saveTimestamp(timestamp);

      return getFile('/drop_table.json');
    }

    return getFile('drop_table.json');
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
    final info = json.decode((await client.get(infoUrl)).body);

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
  }

  Future<void> _downloadDropTable([String path]) async {
    const dropTable = 'https://drops.warframestat.us/data/all.slim.json';

    final response = await client.get(dropTable);

    if (response?.statusCode != 200)
      throw Exception('Drop table failed to download: ${response?.statusCode}');

    await saveFile('/drop_table.json', response.body);
  }
}
