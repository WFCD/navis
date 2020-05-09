import 'package:worldstate_api_model/entities.dart';

abstract class DropTableLocalBase {
  void cacheTableTimestamp(DateTime timestamp);

  Future<void> saveDropTable(String table);

  DateTime getTableTimestamp();

  Future<List<SlimDrop>> getDropTable();
}
