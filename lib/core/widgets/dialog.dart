import 'package:flutter/material.dart';

class NavisDialog extends StatelessWidget {
  const NavisDialog({
    Key? key,
    this.title,
    this.contentPadding,
    this.actions,
    required this.content,
  }) : super(key: key);

  final Widget? title;
  final Widget content;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final dialogTheme = DialogTheme.of(context);

    final _title = Padding(
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 20.0),
      child: DefaultTextStyle(
        style: dialogTheme.titleTextStyle ??
            Theme.of(context).textTheme.headline6!,
        child: Semantics(
          namesRoute: true,
          container: true,
          child: title,
        ),
      ),
    );

    final _content = DefaultTextStyle(
      style: dialogTheme.contentTextStyle ??
          Theme.of(context).textTheme.headline6!,
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
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (title != null) _title,
            _content,
            if (actions != null)
              ButtonBar(children: <Widget>[if (actions != null) ...actions!])
          ]),
    );
  }
}
