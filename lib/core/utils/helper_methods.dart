import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:navis/core/themes/colors.dart';

Future<void> launchLink(String link) async {
  try {
    await launch(link,
        option: const CustomTabsOption(
          toolbarColor: primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          //animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'org.mozilla.fenix',
            'com.microsoft.emmx'
          ],
        ));
  } catch (e) {
    // appScaffold.currentState.showSnackBar(const SnackBar(
    //   duration: Duration(seconds: 5),
    //   content: Text('No valid link provided by API'),
    // ));
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
