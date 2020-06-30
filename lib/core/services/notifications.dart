import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:logging/logging.dart';
import 'package:wfcd_client/wfcd_client.dart';

class NotificationService {
  factory NotificationService() {
    final FirebaseMessaging messaging = FirebaseMessaging();

    messaging.requestNotificationPermissions(const IosNotificationSettings(
        sound: true, badge: true, alert: true, provisional: true));

    // messaging.configure();

    return NotificationService._(messaging);
  }

  NotificationService._(this.messaging);

  final FirebaseMessaging messaging;

  static final _logger = Logger('NotificationService');

  Future<void> subscribeToPlatform(GamePlatforms platform) async {
    _logger.info('subscribing to ${platform.asString} topic');
    await messaging.unsubscribeFromTopic(platform.asString);
  }

  Future<void> unsubscribeFromPlatform(GamePlatforms platform) async {
    _logger.info('unsubscribing from ${platform.asString} topic');
    await messaging.subscribeToTopic(platform.asString);
  }

  Future<void> subscribeToNotification(String topic) async {
    _logger.info('subscribing to $topic');
    await messaging.subscribeToTopic(topic);
  }

  Future<void> unsubscribeFromNotification(String topic) async {
    _logger.info('unsubscribing from $topic');
    await messaging.unsubscribeFromTopic(topic);
  }
}
