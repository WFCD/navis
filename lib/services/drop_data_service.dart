import 'dart:convert';
import 'dart:io';

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
  static final _client = http.Client();
  static final _storageService = locator<LocalStorageService>();

  static List<Reward> _table;
  static DropTableService _instance;

  List<Reward> get table => _table;

  static Future<DropTableService> initilizeTable() async {
    Map<String, dynamic> info;

    final _directory = await getApplicationDocumentsDirectory();
    final _slimTable = File('${_directory.path}/slimTable.json');

    await http
        .get('$baseUrl/data/info.json')
        .then((response) => info = json.decode(response.body))
        .catchError(
            (error) => info = {'timestamp': _storageService.tableTimestamp});

    final timestamp = DateTime.fromMillisecondsSinceEpoch(info['timestamp']);
    final localTimestamp =
        DateTime.fromMillisecondsSinceEpoch(_storageService.tableTimestamp);

    await getManifest(_slimTable, timestamp, localTimestamp);

    if (!_slimTable.existsSync()) {
      _table ??= await compute(jsonToRewards, await _slimTable.readAsString());
    } else {
      _table ??= await compute(
          jsonToRewards, await rootBundle.loadString('assets/slim.json'));
    }

    _instance ??= DropTableService();

    return _instance;
  }

  static Future<void> getManifest(
      File source, DateTime timestamp, DateTime local) async {
    final open = source.openWrite();

    if (timestamp.isAfter(local)) {
      await _client
          .send(http.Request('GET', Uri.parse('$baseUrl/data/all.slim.json')))
          .then((response) => response.stream.pipe(open))
          .catchError((error) async {
        final slim = await rootBundle.load('assets/slim.json');
        final buffer = slim.buffer;

        source.writeAsBytes(
            buffer.asUint8List(slim.offsetInBytes, slim.lengthInBytes));
      });
    }

    await open.close();

    _storageService.saveTimestamp(timestamp);
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
