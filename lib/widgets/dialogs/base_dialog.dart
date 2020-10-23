import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    Key key,
    this.dialogTitle,
    @required this.child,
    this.padding,
    this.actions,
  })  : assert(child != null),
        super(key: key);

  final Widget dialogTitle;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final ThemeData theme = Theme.of(context);

    final title = Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 20.0),
      child: DefaultTextStyle(
        style:
            dialogTheme.titleTextStyle ?? Theme.of(context).textTheme.headline6,
        child: Semantics(
          child: dialogTitle,
          namesRoute: true,
          container: true,
        ),
      ),
    );

    final content = DefaultTextStyle(
      style: dialogTheme.contentTextStyle ?? theme.textTheme.subtitle1,
      child: Flexible(
        child: Padding(
          padding: padding ?? const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 14.0),
          child: child,
        ),
      ),
    );

    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        child: Container(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (dialogTitle != null) title,
                content,
                if (actions != null) ButtonBar(children: <Widget>[...actions])
              ]),
        ));
  }
}
