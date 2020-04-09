import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';

class DropTableClient {
  const DropTableClient(this.path);

  final String path;

  static const _baseUrl = 'https://drops.warframestat.us/data';

  File get dropTable {
    return File(p.join(path, 'drop_table.json'));
  }

  Future<DateTime> dropsTimestamp() async {
    final info = json.decode(await _warframestatDrops('info.json'))
        as Map<String, dynamic>;

    return DateTime.fromMillisecondsSinceEpoch(info['timestamp'] as int);
  }

  Future<void> downloadDropTable() async {
    final response = await _warframestatDrops('all.slim.json');

    await dropTable.writeAsString(response);
  }

  Future<List<SlimDrop>> getDropTable() async {
    final table = json.decode(await dropTable.readAsString()) as List<dynamic>;

    return table
        .map<SlimDrop>(
            (dynamic d) => SlimDropModel.fromJson(d as Map<String, dynamic>))
        .toList();
  }

  Future<String> _warframestatDrops(String path) async {
    final response = await http.get('$_baseUrl/$path');

    return response.body;
  }
}
