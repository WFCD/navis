import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/drop_table_info.dart';
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
    @required this.client,
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

  static const String dropTable = 'https://drops.warframestat.us';

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/drop_table.json';

    Worldstate worldstate;

    try {
      platform ??= storageService.platform;
      final response = await WorldstateApiWrapper.getInstance(platform, client);

      worldstate = cleanState(response.worldstate);
    } catch (e) {
      if (_checkFile(path)) {
        final cached = _getFile(path).readAsStringSync();
        final state = Worldstate.fromJson(json.decode(cached));

        worldstate = cleanState(state);
      }
    }

    try {
      _saveFile(path, json.encode(worldstate.toJson()));
    } catch (e) {
      debugPrint(e.toString());
    }

    return worldstate;
  }

  Future<File> updateDropTable([String path]) async {
    final directory = await getApplicationDocumentsDirectory();
    final _path = path ?? '${directory.path}/drop_table.json';

    final timestamp = await dropTableTimestamp();

    if (timestamp.isAfter(storageService.tableTimestamp) ||
        !_checkFile(_path)) {
      final response = await client.get('$dropTable/data/all.slim.json');

      if (response?.statusCode != 200)
        throw Exception(
            'Drop table failed to download: ${response?.statusCode}');

      storageService.saveTimestamp(timestamp);

      return await _saveFile(_path, response.body);
    }

    return _getFile(_path);
  }

  Future<DateTime> dropTableTimestamp() async {
    Info info;

    try {
      final response = await client.get('$dropTable/data/info.json');
      info = Info.fromJson(json.decode(response.body));

      return info.timestamp;
    } catch (e) {
      return storageService.tableTimestamp;
    }
  }

  bool _checkFile(String path) => File(path).existsSync();

  File _getFile(String path) => File(path);

  Future<File> _saveFile(String path, String data) async {
    final file = File(path);

    return file.writeAsString(data);
  }
}
