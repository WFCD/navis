import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom;
import 'package:html/parser.dart';
import 'package:navis/blocs/search/search_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../global_keys.dart';

Future<void> launchLink(BuildContext context, String link,
    {bool isStream = false}) async {
  const String warframeTwitch = 'twitch://open?stream=warframe';
  if (await canLaunch(link)) {
    if (isStream) {
      if (await canLaunch(warframeTwitch)) {
        await launch(warframeTwitch);
      } else {
        launchLink(context, link, isStream: false);
      }
    } else {
      await custom.launch(link,
          option: custom.CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
            enableDefaultShare: true,
            enableUrlBarHiding: true,
            showPageTitle: true,
            animation: custom.CustomTabsAnimation.slideIn(),
            extraCustomTabs: const <String>[
              'org.mozilla.firefox',
              'org.mozilla.fenix',
              'com.microsoft.emmx'
            ],
          ));
    }
  } else {
    appScaffold.currentState.showSnackBar(SnackBar(
      duration: const Duration(seconds: 5),
      content: link?.isEmpty ?? true
          ? const Text('No valid link provided by API')
          : const Text('No App compatible detected to open link'),
    ));
  }
}

String timestamp(DateTime timestamp) {
  final Duration duration = timestamp.difference(DateTime.now().toUtc()).abs();

  const Duration hour = Duration(hours: 1);
  const Duration day = Duration(hours: 24);

  if (duration < hour) {
    return '${duration.inMinutes.floor()}m';
  } else if (duration >= hour && duration < day) {
    return '${duration.inHours.floor()}h ${(duration.inMinutes % 60).floor()}m';
  } else
    return '${duration.inDays.floor()}d';
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  return parse(document.body.text).documentElement.text;
}

SearchTypes stringToSearchType(String type) {
  return SearchTypes.values.firstWhere(
    (v) => v.toString() == 'SearchTypes.$type',
    orElse: () => SearchTypes.drops,
  );
}

String searchTypeToString(SearchTypes type) {
  return type.toString().split('.').last;
}
