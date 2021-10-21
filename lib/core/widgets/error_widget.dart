import 'package:flutter/material.dart';

import '../../constants/sizedbox_spacer.dart';
import '../../l10n/l10n.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({
    Key? key,
    this.details,
    this.showStacktrace = true,
  }) : super(key: key);

  final bool showStacktrace;
  final FlutterErrorDetails? details;

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
              SizedBoxSpacer.spacerHeight8,
              Text(
                l10n.errorTitle,
                style: Theme.of(context).textTheme.headline6,
                textAlign: TextAlign.center,
              ),
              SizedBoxSpacer.spacerHeight12,
              Text(
                l10n.errorDescription,
                textAlign: TextAlign.center,
              ),
              SizedBoxSpacer.spacerHeight12,
              if (showStacktrace)
                LimitedBox(
                  maxHeight: 100,
                  child: Text(details?.exceptionAsString() ?? ''),
                )
            ],
          ),
        ),
      ),
    );
  }
}
