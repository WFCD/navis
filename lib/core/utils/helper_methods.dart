import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_web_browser/flutter_web_browser.dart';
import 'package:html/parser.dart';
import 'package:navis/core/themes/colors.dart';

Future<void> launchLink(BuildContext context, String link,
    {bool pop = false}) async {
  if (pop) Navigator.of(context).pop();

  try {
    await FlutterWebBrowser.openWebPage(
      url: link,
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
    Scaffold.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 5),
      content: Text(
        'Unable to open, either no browser detected or an'
        ' invalid link provided by API.',
      ),
    ));
  }
}

void scrollToSelectedContent(BuildContext context) {
  const duration = Duration(milliseconds: 200);

  if (context != null) {
    Future<void>.delayed(duration).then((value) {
      Scrollable.ensureVisible(context, duration: duration);
    });
  }
}

Color healthColor(double health) {
  if (health > 50.0) {
    return Colors.green;
  } else if (health <= 50.0 && health >= 10.0) {
    return Colors.orange[900];
  } else {
    return Colors.red;
  }
}

String parseHtmlString(String html) {
  final document = parse(html);
  return document.body.text;
}

double roundDouble(double value, int places) {
  final mod = math.pow(10.0, places);

  return (value * mod).roundToDouble() / mod;
}
