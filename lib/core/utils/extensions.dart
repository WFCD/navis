import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:html/parser.dart';

import '../themes/colors.dart';

extension BuildContextNx on BuildContext {
  void scrollToSelectedContent() {
    const duration = Duration(milliseconds: 200);

    Future<void>.delayed(duration).then((value) {
      Scrollable.ensureVisible(this, duration: duration);
    });
  }
}

extension DateTimeX on DateTime {
  String format(BuildContext context) {
    return MaterialLocalizations.of(context).formatFullDate(this);
  }
}

extension ThemeX on ThemeData {
  bool get isDark => brightness == Brightness.dark;
}

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
          toolbarColor: primary,
          addDefaultShareMenuItem: true,
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
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        content: Text(
          'Unable to open, either no browser detected or an'
          ' invalid link provided by API.',
        ),
      ));
    }
  }
}
