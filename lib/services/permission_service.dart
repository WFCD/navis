import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

const storageReason = 'Cephalon Navis needs storage '
    'permission in order to save crash logs '
    'which can help when creating bug report';

class PermissionsService {
  final PermissionHandler _permissionHandler = PermissionHandler();

  Future<bool> hasPermission(PermissionGroup permission) async {
    final permissionStatus =
        await _permissionHandler.checkPermissionStatus(permission);

    return permissionStatus == PermissionStatus.granted;
  }

  Future<void> requestStoragePermission() async {
    final directory = await getExternalStorageDirectory();
    final granted = await _requestPermission(PermissionGroup.storage);

    if (granted)
      await Directory('${directory.path}/Navis').create(recursive: true);
  }

  Future<bool> _requestPermission(PermissionGroup permission) async {
    final results = await _permissionHandler.requestPermissions([permission]);

    return results[permission] == PermissionStatus.granted;
  }
}
