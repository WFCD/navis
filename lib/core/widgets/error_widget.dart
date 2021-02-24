import 'package:flutter/material.dart';

import '../../l10n/l10n.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({
    Key key,
    this.details,
    this.showStacktrace = true,
  }) : super(key: key);

  final bool showStacktrace;
  final FlutterErrorDetails details;

  Widget _getStackTraceWidget() {
    if (showStacktrace) {
      return LimitedBox(
        maxHeight: 100,
        child: Text(details.exceptionAsString()),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Material(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Center(
          child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  color: Theme.of(context).errorColor,
                  size: 40,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.errorTitle,
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  l10n.errorDescription,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                _getStackTraceWidget()
              ]),
        ),
      ),
    );
  }
}
