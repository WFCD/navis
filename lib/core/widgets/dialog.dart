import 'package:flutter/material.dart';

class NavisDialog extends StatelessWidget {
  const NavisDialog({
    Key key,
    @required this.title,
    this.contentPadding,
    this.actions,
    @required this.content,
  })  : assert(title != null),
        assert(content != null),
        super(key: key);

  final Widget title;
  final EdgeInsetsGeometry contentPadding;
  final Widget content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    final DialogTheme dialogTheme = DialogTheme.of(context);
    final ThemeData theme = Theme.of(context);

    final _title = Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 20.0),
      child: DefaultTextStyle(
        style: dialogTheme.titleTextStyle ?? Theme.of(context).textTheme.title,
        child: Semantics(
          namesRoute: true,
          container: true,
          child: title,
        ),
      ),
    );

    final _content = DefaultTextStyle(
      style: dialogTheme.contentTextStyle ?? theme.textTheme.subhead,
      child: Flexible(
        child: Padding(
          padding:
              contentPadding ?? const EdgeInsets.fromLTRB(8.0, 10.0, 8.0, 14.0),
          child: content,
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
                if (title != null) _title,
                _content,
                if (actions != null) ButtonBar(children: <Widget>[...actions])
              ]),
        ));
  }
}
