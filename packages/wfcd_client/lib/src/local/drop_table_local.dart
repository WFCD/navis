import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:wfcd_client/exceptions.dart';
import 'package:worldstate_api_model/entities.dart';
import 'package:worldstate_api_model/models.dart';
import 'package:path/path.dart' as path;

import '../base/local/drop_table_local_base.dart';

class DropTableLocal extends DropTableLocalBase {
  DropTableLocal(this.directory, this.cacheBox);

  final Directory directory;
  final Box<dynamic> cacheBox;

  static const String _timestamp = 'table_timestamp';
  static const String _dropTable = 'drop_table.json';

  File get _getDropTablePath {
    final tablePath = path.join(directory.path, _dropTable);
    return File(tablePath);
  }

  @override
  void cacheTableTimestamp(DateTime timestamp) {
    cacheBox.put(_timestamp, timestamp.toIso8601String());
  }

  @override
  Future<List<SlimDrop>> getDropTable() async {
    final dropTable = _getDropTablePath;

    if (dropTable.existsSync()) {
      return (json.decode(await dropTable.readAsString()) as List<dynamic>)
          .map((dynamic e) => SlimDropModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return null;
  }

  @override
  DateTime getTableTimestamp() {
    final timestamp = cacheBox.get(_timestamp) as String;

    if (timestamp != null) return DateTime.parse(timestamp);

    return null;
  }

  @override
  Future<void> saveDropTable(String table) async {
    final dropTable = _getDropTablePath;

    await dropTable.writeAsString(table);
  }
}
