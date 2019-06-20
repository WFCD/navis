import 'package:flutter/material.dart';

mixin DialogWidget on StatelessWidget {
  static Future<void> openDialog(BuildContext context, Widget child) async {
    showDialog(context: context, builder: (BuildContext context) => child);
  }
}

class BaseDialog extends StatelessWidget {
  const BaseDialog({this.dialogTitle, @required this.child, this.actions});

  final String dialogTitle;
  final Widget child;
  final List<Widget> actions;

  Widget _buildTitle(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);

    return Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 20.0),
      child: DefaultTextStyle(
        style: dialogTheme.titleTextStyle ?? Theme.of(context).textTheme.title,
        child: Semantics(
          child: Text(dialogTitle),
          namesRoute: true,
          container: true,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = Container(
        margin: const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 14.0), child: child);

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (dialogTitle != null) _buildTitle(context),
              content,
              if (actions != null)
                ButtonTheme.bar(child: ButtonBar(children: actions))
            ]));
  }
}
