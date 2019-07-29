import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/drop_table_info.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_api_wrapper/wfcd_api_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';

class Repository {
  const Repository({
    @required this.storageService,
    @required this.packageInfo,
    @required this.notificationService,
  })  : assert(storageService != null),
        assert(packageInfo != null),
        assert(notificationService != null);

  static Future<Repository> initialize() async {
    final LocalStorageService _storageService =
        await LocalStorageService.getInstance();
    final PackageInfo _info = await PackageInfo.fromPlatform();

    return Repository(
      storageService: _storageService,
      packageInfo: _info,
      notificationService: NotificationService.initialize(),
    );
  }

  final LocalStorageService storageService;
  final PackageInfo packageInfo;
  final NotificationService notificationService;

  static const String dropTable = 'https://drops.warframestat.us';

  Future<Worldstate> getWorldstate([Platforms platform]) async {
    platform ??= storageService.platform;
    final response = await WorldstateApiWrapper.getInstance(platform);

    return response.worldstate;
  }

  Future<File> updateDropTable([File source]) async {
    final directory = await getApplicationDocumentsDirectory();
    source ??= File('${directory.path}/drop_table.json');

    try {
      final timestamp = await dropTableTimestamp();

      if (timestamp.isAfter(storageService.tableTimestamp) ||
          !source.existsSync()) {
        storageService.saveTimestamp(timestamp);
        final response = await http.get('$dropTable/drops');
        source.writeAsStringSync(response.body);

        return source;
      }

      return source;
    } catch (e) {
      final slim = await rootBundle.loadString('assets/slim.json');
      source.writeAsStringSync(slim);

      return source;
    }
  }

  Future<DateTime> dropTableTimestamp() async {
    Info info;

    try {
      final response = await http.get('$dropTable/data/info.json');
      info = Info.fromJson(json.decode(response.body));

      return info.timestamp;
    } catch (e) {
      return storageService.tableTimestamp;
    }
  }
}
