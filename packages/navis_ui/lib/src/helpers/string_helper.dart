import 'package:black_hole_flutter/black_hole_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html/parser.dart';

extension StringNx on String {
  String parseHtmlString() {
    final document = parse(this);
    return document.body?.text ?? '';
  }

  Future<void> launchLink(BuildContext context, {bool pop = false}) async {
    if (pop) Navigator.of(context).pop();

    try {
      await launchUrl(
        Uri.parse(this),
        customTabsOptions: CustomTabsOptions(
          urlBarHidingEnabled: true,
          showTitle: true,
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: context.theme.colorScheme.surface,
          ),
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: context.theme.colorScheme.surface,
          preferredControlTintColor: context.theme.colorScheme.onSurface,
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
        ),
      );

      // Only need a general error here
      // ignore: avoid_catches_without_on_clauses
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          duration: Duration(seconds: 5),
          content: Text(
            'Unable to open, either no browser detected or an'
            ' invalid link provided by API.',
          ),
        ),
      );
    }
  }
}
