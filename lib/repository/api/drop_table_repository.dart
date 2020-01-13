import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:navis/resources/api/drop_table_client.dart';
import 'package:navis/resources/storage/cache.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

class DropTableRepository {
  DropTableRepository(this.cache);

  final CacheResource cache;

  List<SlimDrop> table;

  static const DropTableClient _dropTableProvider = DropTableClient();

  Future<DateTime> get timestamp => _dropTableProvider.dropsTimestamp();

  Future<void> initDrops() async {
    final table = await _dropTablePath();

    if (table.existsSync()) return;

    await compute<File, void>(_downloadDrops, table);

    this.table = await compute(_toDrops, table.readAsStringSync());

    cache.saveDropTableTimestamp(await timestamp);
  }

  Future<List<SlimDrop>> search(String term) async {
    if (table != null) {
      final instance = DropSearchInstance(term, table);

      return compute(_searcher, instance);
    }

    return null;
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

  Future<File> _dropTablePath() async {
    final temp = await getTemporaryDirectory();
    final table = File('${temp.path}/drop_table.json');

    return table;
  }

  static Future<List<SlimDrop>> _toDrops(String table) async {
    final _table = json.decode(table).cast<Map<String, dynamic>>();

    return _table.map<SlimDrop>((d) => SlimDrop.fromJson(d)).toList();
  }

  static Future<void> _downloadDrops(File table) async {
    const DropTableClient _dropTableProvider = DropTableClient();
    await _dropTableProvider.downloadDropTable(table);
  }

  static List<SlimDrop> _searcher(DropSearchInstance instance) {
    return instance.drops.where((d) => d.item.contains(instance.term)).toList();
  }
}

class DropSearchInstance {
  const DropSearchInstance(this.term, this.drops);

  final String term;
  final List<SlimDrop> drops;
}
