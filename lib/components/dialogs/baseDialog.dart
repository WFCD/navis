import 'package:flutter/material.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.unmodifiable(() sync* {
              if (dialogTitle != null) yield _buildTitle(context);

              yield content;

              if (actions != null)
                yield ButtonTheme.bar(child: ButtonBar(children: actions));
            }())));
  }
}
