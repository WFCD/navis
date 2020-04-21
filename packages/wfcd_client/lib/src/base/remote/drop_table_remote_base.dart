abstract class DropTableRemoteBase {
  Future<DateTime> dropsTimestamp();

  Future<List<Map<String, dynamic>>> getDropTable();
}
