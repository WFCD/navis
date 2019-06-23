import 'dart:convert';
import 'dart:io';

import 'package:codable/codable.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:navis/models/drop_tables/slim.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:path_provider/path_provider.dart';

const String baseUrl = 'https://drops.warframestat.us';

class DropTableService {
  static final _client = http.Client();
  static final _storageService = locator<LocalStorageService>();

  static List<Reward> _table;
  static DropTableService _instance;

  List<Reward> get table => _table;

  static Future<DropTableService> initilizeTable() async {
    final _directory = await getApplicationDocumentsDirectory();
    final _slimTable = File('${_directory.path}/slimTable.json');

    final info = json.decode((await http.get('$baseUrl/data/info.json')).body);

    if (info['timestamp'] != _storageService.tableTimestamp ||
        !_slimTable.existsSync()) {
      await getManifest(_slimTable, info['timestamp']);
    }

    _table ??= await compute(jsonToRewards, await _slimTable.readAsString());
    _instance ??= DropTableService();

    return _instance;
  }

  static Future<void> getManifest(File source, int timestamp) async {
    final open = source.openWrite();

    final response = await _client
        .send(http.Request('GET', Uri.parse('$baseUrl/data/all.slim.json')));

    await response.stream.pipe(open);

    await open.close();

    _storageService.tableTimestamp = timestamp;
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
