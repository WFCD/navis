import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/utils/client.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  Repository({
    @required this.api,
    @required this.storageService,
    @required this.packageInfo,
    @required this.notificationService,
  })  : assert(storageService != null),
        assert(packageInfo != null),
        assert(notificationService != null);

  static Future<Repository> initialize([http.Client client]) async {
    final LocalStorageService _storageService =
        await LocalStorageService.getInstance();
    final PackageInfo _info = await PackageInfo.fromPlatform();

    return Repository(
      api: WorldstateApiWrapper(client ?? MetricHttpClient(http.Client())),
      storageService: _storageService,
      packageInfo: _info,
      notificationService: NotificationService.initialize(),
    );
  }

  final WorldstateApiWrapper api;
  final LocalStorageService storageService;
  final PackageInfo packageInfo;
  final NotificationService notificationService;

  static const String dropTable = 'https://drops.warframestat.us';

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    Worldstate worldstate;

    try {
      platform ??= storageService.platform ?? Platforms.pc;
      final response = await api.getWorldstate(platform);

      worldstate = cleanState(response);
    } catch (e) {
      if (await _checkFile('/worldstate.json')) {
        final cached = await _getFile('/worldstate.json');
        final state =
            Worldstate.fromJson(json.decode(cached.readAsStringSync()));

        worldstate = cleanState(state);
      }
    }

    _saveFile('/worldstate.json', json.encode(worldstate.toJson()));

    return worldstate;
  }

  Future<dynamic> searchItem(String searchTerm) async {
    final response =
        await http.get('https://api.warframestat.us/items/search/$searchTerm');
    final data = json.decode(response.body);

    return data;
  }

  Future<File> updateItems([String path]) async {
    final timestamp = storageService.tableTimestamp;

    if (timestamp.difference(storageService.tableTimestamp) <
            const Duration(days: 7) ||
        !await _checkFile('/drop_table.json')) {
      final response = await api.client.get('$dropTable/data/all.slim.json');

      if (response?.statusCode != 200)
        throw Exception(
            'Drop table failed to download: ${response?.statusCode}');

      storageService.saveTimestamp(DateTime.now());

      return await _saveFile('/drop_table.json', response.body);
    }

    return _getFile('/drop_table.json');
  }

  Future<bool> _checkFile(String path) async =>
      File(await _tempDirectory() + path).existsSync();

  Future<File> _getFile(String path) async =>
      File(await _tempDirectory() + path);

  Future<File> _saveFile(String path, String data) async {
    final file = File(await _tempDirectory() + path);

    return file.writeAsString(data);
  }

  Future<String> _tempDirectory() async {
    final directory = await getTemporaryDirectory();

    return directory.path;
  }
}
