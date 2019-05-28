import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'base_dialog.dart';

class ColorPickerDialog extends StatelessWidget with DialogWidget {
  const ColorPickerDialog(this.primary);

  final bool primary;

  static Future<void> selectPrimary(BuildContext context) async {
    DialogWidget.openDialog(context, const ColorPickerDialog(true));
  }

  static Future<void> selectAccent(BuildContext context) async {
    DialogWidget.openDialog(context, const ColorPickerDialog(false));
  }

  void _submit(BuildContext context, StorageBloc bloc, Color color) {
    if (primary) {
      bloc.dispatch(ChangeThemeData(primaryColor: color));
    } else {
      bloc.dispatch(ChangeThemeData(accentColor: color));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final storage = BlocProvider.of<StorageBloc>(context);

    return BlocBuilder<ChangeEvent, StorageState>(
      bloc: storage,
      builder: (_, state) {
        Color tempColor;

        final currentColor =
            primary ? state.theme.primaryColor : state.theme.accentColor;

        return BaseDialog(
          dialogTitle: 'Select Color',
          child: MaterialColorPicker(
            selectedColor: currentColor,
            onColorChange: (color) => tempColor = color,
            onMainColorChange: (color) => tempColor = color,
          ),
          actions: <Widget>[
            FlatButton(
              child: const Text('APPLY'),
              onPressed: () => _submit(context, storage, tempColor),
            )
          ],
        );
      },
    );
  }
}
