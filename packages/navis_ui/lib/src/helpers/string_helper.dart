import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:html/parser.dart';
import 'package:navis_ui/src/colors/colors.dart';

extension StringNx on String {
  String parseHtmlString() {
    final document = parse(this);
    return document.body?.text ?? '';
  }

  Future<void> launchLink(BuildContext context, {bool pop = false}) async {
    if (pop) Navigator.of(context).pop();

    try {
      await FlutterWebBrowser.openWebPage(
        url: this,
        customTabsOptions: const CustomTabsOptions(
          defaultColorSchemeParams:
              CustomTabsColorSchemeParams(toolbarColor: NavisColors.blue),
          urlBarHidingEnabled: true,
          showTitle: true,
        ),
        safariVCOptions: const SafariViewControllerOptions(
          barCollapsingEnabled: true,
          dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
          modalPresentationCapturesStatusBarAppearance: true,
        ),
      );
    } catch (e) {
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
