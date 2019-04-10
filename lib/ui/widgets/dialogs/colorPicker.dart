import 'package:flutter/material.dart';
import 'package:navis/blocs/bloc.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

import 'baseDialog.dart';

class ColorPickerDialog extends StatelessWidget {
  const ColorPickerDialog(this.primary);

  final bool primary;

  static Future<void> selectPrimary(BuildContext context) async {
    showDialog(context: context, builder: (_) => const ColorPickerDialog(true));
  }

  static Future<void> selectAccent(BuildContext context) async {
    showDialog(
        context: context, builder: (_) => const ColorPickerDialog(false));
  }

  void _submit(BuildContext context, ThemeBloc bloc, Color color) {
    if (primary) {
      bloc.dispatch(ThemeCustom(primaryColor: color));
    } else {
      bloc.dispatch(ThemeCustom(accentColor: color));
    }

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final themeBloc = BlocProvider.of<ThemeBloc>(context);

    return BlocBuilder(
      bloc: themeBloc,
      builder: (BuildContext context, ThemeState currentTheme) {
        Color tempColor;

        final currentColor = primary
            ? currentTheme.theme.primaryColor
            : currentTheme.theme.accentColor;

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
              onPressed: () => _submit(context, themeBloc, tempColor),
            )
          ],
        );
      },
    );
  }
}
