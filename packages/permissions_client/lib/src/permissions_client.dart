import 'package:permission_handler/permission_handler.dart';

/// {@template permissions_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class PermissionsClient {
  /// {@macro permissions_client}
  const PermissionsClient();

  Future<PermissionStatus> requestNotifications() => Permission.notification.request();

  Future<PermissionStatus> notificationsStatus() => Permission.notification.status;

  Future<bool> openPermissionSettings() => openAppSettings();
}
