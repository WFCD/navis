import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({this.title, this.style});

  final String title;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final _style = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return Container(
        margin: const EdgeInsets.only(top: 4.0, left: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(title, style: style ?? _style));
  }
}
