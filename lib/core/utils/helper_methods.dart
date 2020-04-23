import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as customTabs;
import 'package:html/parser.dart';
import 'package:navis/core/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchLink(BuildContext context, String link,
    {bool pop = false}) async {
  if (pop) Navigator.of(context).pop();

  if (await canLaunch(link)) {
    try {
      await customTabs.launch(
        link,
        option: const customTabs.CustomTabsOption(
          toolbarColor: primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          extraCustomTabs: <String>[
            'org.mozilla.firefox',
            'org.mozilla.fenix',
            'org.mozilla.fenix.nightly',
            'com.microsoft.emmx'
          ],
        ),
      );
    } catch (e) {
      Scaffold.of(context).showSnackBar(const SnackBar(
        duration: Duration(seconds: 5),
        content: Text('No valid link provided by API'),
      ));
    }
  } else {
    Scaffold.of(context).showSnackBar(const SnackBar(
      duration: Duration(seconds: 5),
      content: Text('Unable to open this page'),
    ));
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
