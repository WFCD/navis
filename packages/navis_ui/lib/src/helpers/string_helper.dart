import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html/parser.dart';
import 'package:material_ui/material_ui.dart';

extension StringNx on String {
  String parseHtmlString() {
    final document = parse(this);
    return document.body?.text ?? '';
  }

  Future<void> launchLink(BuildContext context, {bool pop = false}) async {
    final colorScheme = Theme.of(context).colorScheme;
    if (pop) Navigator.of(context).pop();

    try {
      await launchUrl(
        Uri.parse(this),
        customTabsOptions: CustomTabsOptions(
          urlBarHidingEnabled: true,
          showTitle: true,
          colorSchemes: CustomTabsColorSchemes.defaults(
            toolbarColor: colorScheme.surface,
          ),
          closeButton: CustomTabsCloseButton(
            icon: CustomTabsCloseButtonIcons.back,
          ),
        ),
        safariVCOptions: SafariViewControllerOptions(
          preferredBarTintColor: colorScheme.surface,
          preferredControlTintColor: colorScheme.onSurface,
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
