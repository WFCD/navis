import 'dart:convert';
import 'dart:io';

import 'package:catcher/catcher_plugin.dart';
import 'package:codable/codable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:path_provider/path_provider.dart';

const String baseUrl = 'https://drops.warframestat.us';

class DropTableService {
  static final _storageService = locator<LocalStorageService>();

  static List<Reward> _table;
  static DropTableService _instance;

  List<Reward> get table => _table;

  static Future<DropTableService> initilizeTable() async {
    Map<String, dynamic> info;

    final _directory = await getApplicationDocumentsDirectory();
    final _slimTable = File('${_directory.path}/drop_table.json');

    try {
      final response = await http.get('$baseUrl/data/info.json');
      info = json.decode(response.body);
    } on SocketException {
      info = {'timestamp': _storageService.tableTimestamp};
    }

    final timestamp = DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
    final localTimestamp =
        DateTime.fromMillisecondsSinceEpoch(_storageService.tableTimestamp);

    _instance ??= DropTableService();
    _table ??= await getManifest(_slimTable, timestamp, localTimestamp);

    return _instance;
  }

  static Future<List<Reward>> getManifest(
      File source, DateTime timestamp, DateTime local) async {
    if (timestamp.isAfter(local) || source.existsSync() != true) {
      try {
        final response = await http.get('$baseUrl/data/all.slim.json');
        source.writeAsString(response.body);
      } on SocketException {
        final slim = await rootBundle.loadString('assets/slim.json');

        source.writeAsStringSync(slim);
      }
    }

    _storageService.saveTimestamp(timestamp);
    return compute(jsonToRewards, await source.readAsString());
  }
}

List<Reward> jsonToRewards(String response) {
  final List<dynamic> drops = json.decode(response);
  return drops.map<Reward>((d) => mapToReward(d)).toList();
}

Reward mapToReward(Map<String, dynamic> drop) {
  final key = KeyedArchive.unarchive(drop);

  return Reward()..decode(key);
}
