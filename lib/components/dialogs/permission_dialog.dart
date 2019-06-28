import 'package:flutter/material.dart';
import 'package:navis/components/dialogs/base_dialog.dart';
import 'package:navis/services/permission_service.dart';
import 'package:navis/services/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsDialog extends StatelessWidget {
  PermissionsDialog({Key key, @required this.permissionGroup})
      : super(key: key);

  final PermissionGroup permissionGroup;

  final PermissionsService _handler = locator<PermissionsService>();

  static Future<void> requestPermission(
      BuildContext context, PermissionGroup permissionGroup) async {
    showDialog(
        context: context,
        builder: (_) => PermissionsDialog(permissionGroup: permissionGroup));
  }

  Future<void> _requestPermission() async {
    switch (permissionGroup) {
      case PermissionGroup.storage:
        return await _handler.requestStoragePermission();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final dialogTheme = DialogTheme.of(context);

    return BaseDialog(
      dialogTitle: 'Permission Handler',
      child: Text(
        storageReason,
        style: dialogTheme.contentTextStyle,
      ),
      padding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      actions: <Widget>[
        FlatButton(
          child: const Text('DENY'),
          onPressed: () => Navigator.pop(context),
        ),
        FlatButton(
          child: const Text('ALLOW'),
          onPressed: () async {
            _requestPermission();
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
