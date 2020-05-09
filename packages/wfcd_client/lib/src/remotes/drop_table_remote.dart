import 'dart:convert';

import 'package:http/http.dart' as http;

import '../base/remote/drop_table_remote_base.dart';
import '../constants/endpoints.dart';

class DropTableRemote implements DropTableRemoteBase {
  DropTableRemote(this._client);

  final http.Client _client;

  @override
  Future<DateTime> dropsTimestamp() async {
    final info = json.decode(await _warframestatDrops('info.json'))
        as Map<String, dynamic>;

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp'] as int);
  }

  @override
  Future<String> getDropTable() {
    return _warframestatDrops('all.slim.json');
  }

  Future<String> _warframestatDrops(String path) async {
    final response = await _client.get('$warframestatDropsEndpoint/$path');

    return response.body;
  }
}
