import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({
    this.title,
    this.alignment = Alignment.centerLeft,
    this.style,
  });

  final String title;
  final AlignmentGeometry alignment;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return Container(
      margin: const EdgeInsets.only(top: 4.0, left: 16.0, right: 16.0),
      alignment: alignment,
      child: Text(title, style: style ?? _style),
    );
  }
}
