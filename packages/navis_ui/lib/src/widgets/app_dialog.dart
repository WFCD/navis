import 'package:flutter/material.dart';

class NavisDialog extends StatelessWidget {
  const NavisDialog({
    super.key,
    this.title,
    this.contentPadding,
    this.actions,
    required this.content,
  });

  final Widget? title;
  final Widget content;
  final EdgeInsetsGeometry? contentPadding;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    final dialogTheme = DialogTheme.of(context);

    final title = Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: DefaultTextStyle(
        style: dialogTheme.titleTextStyle ??
            Theme.of(context).textTheme.titleLarge!,
        child: Semantics(
          namesRoute: true,
          container: true,
          child: this.title,
        ),
      ),
    );

    final content = DefaultTextStyle(
      style: dialogTheme.contentTextStyle ??
          Theme.of(context).textTheme.titleLarge!,
      child: Flexible(
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.fromLTRB(8, 10, 8, 14),
          child: this.content,
        ),
      ),
    );

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (this.title != null) title,
          content,
          if (actions != null)
            OverflowBar(children: <Widget>[if (actions != null) ...actions!]),
        ],
      ),
    );
  }
}
