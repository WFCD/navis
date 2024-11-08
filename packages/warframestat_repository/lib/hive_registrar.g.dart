import 'package:hive_ce/hive.dart';
import 'package:warframestat_repository/src/cache_client.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(HiveCacheItemAdapter());
  }
}
