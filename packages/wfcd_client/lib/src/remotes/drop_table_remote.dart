import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/remote/drop_table_remote_base.dart';
import '../constants/endpoints.dart';

class DropTableRemote implements DropTableRemoteBase {
  @override
  Future<DateTime> dropsTimestamp() async {
    final info = json.decode(await _warframestatDrops('info.json'))
        as Map<String, dynamic>;

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp'] as int);
  }

  @override
  Future<List<Map<String, dynamic>>> getDropTable() async {
    final response = await _warframestatDrops('all.slim.json');

    return (json.decode(response) as List<dynamic>)
        .cast<Map<String, dynamic>>();
  }

  Future<String> _warframestatDrops(String path) async {
    final response = await http.get('$warframestatDropsEndpoint/$path');

    return response.body;
  }
}
