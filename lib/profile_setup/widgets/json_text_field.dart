import 'package:material_ui/material_ui.dart';

class JsonTextField extends StatelessWidget {
  const new({super.key, required this.onChanged});

  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.of(context);
    return TextField(
      maxLines: 3,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.secondary)),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: colorScheme.error)),
        labelText: 'User Data',
      ),
    );
  }
}
