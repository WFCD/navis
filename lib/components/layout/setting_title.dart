import 'package:flutter/material.dart';

class SettingTitle extends StatelessWidget {
  const SettingTitle({this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final style = Theme.of(context)
        .textTheme
        .subtitle
        .copyWith(fontSize: 15, color: Theme.of(context).accentColor);

    return Container(
        margin: const EdgeInsets.only(top: 10.0, left: 8.0),
        alignment: Alignment.centerLeft,
        child: Text(title, style: style));
  }
}
