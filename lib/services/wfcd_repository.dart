import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/worldstate/worldstate.dart';
import 'package:navis/services/services.dart';
import 'package:navis/utils/api_base_helper.dart';
import 'package:navis/utils/utils.dart';
import 'package:navis/utils/worldstate_utils.dart';
import 'package:path_provider/path_provider.dart';

import 'localstorage_service.dart';

class WfcdRepository {
  static const _helper = ApiBaseHelper();
  static final _storageService = locator<LocalStorageService>();

  static const String dropTable = 'https://drops.warframestat.us';

  Future<Worldstate> getWorldstate(Platforms platform) async {
    platform ??= Platforms.pc;
    final response =
        await _helper.get('/${platform.toString().split('.').last}');

    return jsonToWorldstate(response);
  }

  Future<File> updateDropTable() async {
    final directory = await getApplicationDocumentsDirectory();
    final source = File('${directory.path}/drop_table.json');

    try {
      final timestamp = await dropTableTimestamp();

      if (timestamp.isAfter(_storageService.tableTimestamp) ||
          !source.existsSync()) {
        _storageService.saveTimestamp(timestamp);
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
      return _storageService.tableTimestamp;
    }
  }
}
