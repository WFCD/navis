import 'package:flutter/material.dart';
import 'package:navis_ui/src/layout/spacers.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({
    Key? key,
    required this.title,
    required this.description,
    this.details,
    this.showStacktrace = true,
  }) : super(key: key);

  final String title, description;
  final FlutterErrorDetails? details;
  final bool showStacktrace;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxHeight >= 200) {
                return _NavisErrorWidget(
                  title: title,
                  description: description,
                );
              }

              return _NavisErrorPage(title: title, description: description);
            },
          ),
        ),
      ),
    );
  }
}

class _NavisErrorPage extends StatelessWidget {
  const _NavisErrorPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          title,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        SizedBoxSpacer.spacerHeight12,
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _NavisErrorWidget extends StatelessWidget {
  const _NavisErrorWidget({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            Icons.error_outline,
            color: Theme.of(context).errorColor,
            size: 40,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          subtitle: Text(
            description,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
