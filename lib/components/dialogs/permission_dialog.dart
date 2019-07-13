import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/components/dialogs/base_dialog.dart';
import 'package:navis/services/permission_service.dart';
import 'package:navis/services/repository.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionsDialog extends StatelessWidget {
  const PermissionsDialog({Key key, @required this.permissionGroup})
      : super(key: key);

  final PermissionGroup permissionGroup;

  static Future<void> requestPermission(
      BuildContext context, PermissionGroup permissionGroup) async {
    showDialog(
        context: context,
        builder: (_) => PermissionsDialog(permissionGroup: permissionGroup));
  }

  Future<void> _requestPermission(PermissionsService handler) async {
    switch (permissionGroup) {
      case PermissionGroup.storage:
        return await handler.requestStoragePermission();
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    final PermissionsService handler =
        RepositoryProvider.of<Repository>(context).permissionsService;

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
            _requestPermission(handler);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
