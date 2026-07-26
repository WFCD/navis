import 'package:notification_repository/src/topics.dart';
import 'package:storage/storage.dart';

class NotificationStorage {
  NotificationStorage(this._storage);

  final Storage<dynamic> _storage;

  bool fetchNotificationStatus(String key) => _storage.read(key) as bool? ?? false;

  Future<void> toggleNotification(String key) async {
    final old = await _storage.read(key) as bool? ?? false;
    await _storage.write(key, !old);
  }

  Map<String, bool> fetchAllNotifications() {
    return {for (final t in Topics.topics) t.name: _storage.read(t.name) as bool? ?? false};
  }
}
