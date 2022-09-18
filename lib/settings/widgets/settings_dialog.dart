import 'package:flutter/material.dart';
import 'package:navis/settings/settings.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    const circularRadius = 8.0;
    const heightMultiplier = 90;
    const widthMultiplier = 80;

    final screenSize = MediaQuery.of(context).size;
    final heightRatio = screenSize.height / 100;
    final widthRatio = screenSize.width / 100;

    return Dialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(circularRadius)),
      ),
      child: SizedBox(
        height: heightRatio * heightMultiplier,
        width: widthRatio * widthMultiplier,
        child: const Padding(
          padding: EdgeInsets.all(8),
          child: SettingsContent(),
        ),
      ),
    );
  }
}
