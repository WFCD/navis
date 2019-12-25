import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:navis/resources/api/drop_table_client.dart';
import 'package:path_provider/path_provider.dart';

class DropTableRepository {
  const DropTableRepository();

  static const DropTableClient _dropTableProvider = DropTableClient();

  Future<DateTime> get timestamp => _dropTableProvider.dropsTimestamp();

  Future<void> initDrops() async {
    final table = await _dropTablePath();

    if (table.existsSync()) return;

    await compute<File, void>(_downloadDrops, table);
  }

  Future<DateTime> updateDrops(DateTime timestamp) async {
    final _timestamp = await this.timestamp;
    final table = await _dropTablePath();

    if (timestamp != _timestamp) {
      await compute<File, void>(_downloadDrops, table);
      return _timestamp;
    }

    return timestamp;
  }

  static Future<void> _downloadDrops(File table) async {
    const DropTableClient _dropTableProvider = DropTableClient();
    await _dropTableProvider.downloadDropTable(table);
  }

  Future<File> _dropTablePath() async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/drop_table.json');

    return table;
  }
}
