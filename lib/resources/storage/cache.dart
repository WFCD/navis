import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:warframe_items_model/warframe_items_model.dart';

import 'storage_base.dart';

class CacheResource extends StorageResource {
  const CacheResource(Box box) : super(box);

  Map<String, dynamic> get getDarvoDeal {
    final deal = box.get('deal', defaultValue: '{}') as String;

    return json.decode(deal) as Map<String, dynamic>;
  }

  String get dealId => getDarvoDeal['id'] as String ?? '';

  ItemObject get dealItem {
    final item = getDarvoDeal['item'] as Map<String, dynamic>;

    return BasicItem.fromJson(item);
  }

  DateTime get getDropTableTimestamp {
    return box.get(
      'timestamp',
      defaultValue: DateTime.now().subtract(const Duration(days: 31)),
    );
  }

  void saveDarvoDealItem(String id, ItemObject item) {
    final toSave = {'id': id, 'item': item.toJson()};

    box.put('deal', json.encode(toSave));
  }

  void saveDropTableTimestamp(DateTime timestamp) {
    box.put('timestamp', timestamp);
  }
}
