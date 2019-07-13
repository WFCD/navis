import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/worldstate/worldstate.dart';
import 'package:navis/utils/api_base_helper.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

import 'localstorage_service.dart';
import 'notification_service.dart';
import 'permission_service.dart';

class Repository {
  const Repository({
    @required this.storageService,
    @required this.packageInfo,
    @required this.notificationService,
    @required this.permissionsService,
  })  : assert(storageService != null),
        assert(packageInfo != null),
        assert(notificationService != null),
        assert(permissionsService != null);

  static Future<Repository> initialize() async {
    final LocalStorageService _storageService =
        await LocalStorageService.getInstance();
    final PackageInfo _info = await PackageInfo.fromPlatform();

    return Repository(
      storageService: _storageService,
      packageInfo: _info,
      notificationService: NotificationService.initialize(),
      permissionsService: PermissionsService(),
    );
  }

  final LocalStorageService storageService;
  final PackageInfo packageInfo;
  final NotificationService notificationService;
  final PermissionsService permissionsService;

  static const _helper = ApiBaseHelper();
  static const String dropTable = 'https://drops.warframestat.us';

  Future<Worldstate> getWorldstate() async {
    final Platforms platform = storageService.platform;
    final response =
        await _helper.get('/${platform.toString().split('.').last}');

    return jsonToWorldstate(response);
  }

  Future<File> updateDropTable() async {
    final directory = await getApplicationDocumentsDirectory();
    final source = File('${directory.path}/drop_table.json');

    try {
      final timestamp = await dropTableTimestamp();

      if (timestamp.isAfter(storageService.tableTimestamp) ||
          !source.existsSync()) {
        storageService.saveTimestamp(timestamp);
        final response = await _helper.get('$dropTable/drops');
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
    Map<String, dynamic> info;

    try {
      final response = await http.get('$dropTable/data/info.json');
      info = json.decode(response.body);

      return DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
    } catch (e) {
      return storageService.tableTimestamp;
    }
  }
}
