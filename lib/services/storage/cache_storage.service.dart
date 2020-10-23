import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'storage_base.service.dart';

class CacheStorageService extends StorageService {
  static const String hive = 'cache';

  static CacheStorageService _instance;
  static Box _box;

  static CacheStorageService get instance => _instance;

  @override
  Box get hiveBox => _box;

  @override
  Future<void> startInstance() async {
    super.startInstance();
    final directory = await getTemporaryDirectory();

    Hive.init(directory.path);

    _box ??= await Hive.openBox(
      hive,
      compactionStrategy: (entries, deleted) {
        return entries > 30 || deleted > 25;
      },
    );

    _instance ??= CacheStorageService();
  }

  Map<String, dynamic> get getDarvoDeal {
    final restore = _box.get('deal', defaultValue: '{}');

    return json.decode(restore);
  }

  String get dealId => getDarvoDeal['id'] ?? '';

  BaseItem get dealItem {
    final item = getDarvoDeal['item'];

    return BaseItemModel.fromJson(json.decode(item));
  }

  DateTime get getDropTableTimestamp {
    return _box.get(
      'timestamp',
      defaultValue: DateTime.now().subtract(const Duration(days: 31)),
    );
  }

  Future<void> saveDarvoDealItem(String id, BaseItem item) async {
    final toSave = {'id': id, 'item': json.encode(fromBaseItem(item))};

    _box.put('deal', json.encode(toSave));
  }

  Future<void> saveDropTableTimestamp(DateTime timestamp) async {
    _box.put('timestamp', timestamp);
  }
}
