import 'package:flutter/material.dart';
import 'package:navis_ui/src/layout/spacers.dart';

class NavisErrorWidget extends StatelessWidget {
  const NavisErrorWidget({
    super.key,
    required this.title,
    required this.description,
    this.details,
    this.showStacktrace = true,
  });

  final String title;
  final String description;
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
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 40,
        ),
        Gaps.gap8,
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Gaps.gap12,
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
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          leading: Icon(
            Icons.error_outline,
            color: Theme.of(context).colorScheme.error,
            size: 40,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
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
