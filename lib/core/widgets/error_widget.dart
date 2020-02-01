import 'package:flutter/material.dart';
import 'package:navis/l10n/localizations.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({
    Key key,
    this.showStacktrace = true,
    this.details,
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
    return Container(
      margin: const EdgeInsets.all(20),
      child: Center(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                NavisLocalizations.of(context).errorTitle,
                style: Theme.of(context).textTheme.title,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                NavisLocalizations.of(context).errorDescription,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              _getStackTraceWidget()
            ]),
      ),
    );
  }
}
