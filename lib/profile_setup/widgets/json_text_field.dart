import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';

class JsonTextField extends StatelessWidget {
  const JsonTextField({super.key, required this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: 3,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: context.theme.colorScheme.secondary)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: context.theme.colorScheme.error)),
        labelText: 'User Data',
      ),
    );
  }
}
