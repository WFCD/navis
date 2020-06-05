import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart' as intl;
import 'package:navis/themes.dart';
import 'package:warframestat_api_models/warframestat_api_models.dart';

import '../global_keys.dart';

Future<void> launchLink(String link) async {
  try {
    await launch(link,
        option: CustomTabsOption(
          toolbarColor: NavisThemes.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          //animation: CustomTabsAnimation.slideIn(),
          extraCustomTabs: const <String>[
            'org.mozilla.firefox',
            'org.mozilla.fenix',
            'com.microsoft.emmx'
          ],
        ));
  } catch (e) {
    appScaffold.currentState.showSnackBar(const SnackBar(
      duration: Duration(seconds: 5),
      content: Text('No valid link provided by API'),
    ));
  }
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  return parse(document.body.text).documentElement.text;
}

List<SlimDrop> toDrops(String data) {
  final table = json.decode(data);

  if (table is Map<String, dynamic>) return [];

  return table.map<SlimDrop>((d) => SlimDropModel.fromJson(d)).toList();
}

extension DateTimeX on DateTime {
  String format(intl.DateFormat format) {
    try {
      return format.format(toLocal());
    } catch (err) {
      return 'Fetching Date';
    }
  }

  String get timestamp {
    final Duration duration = difference(DateTime.now().toUtc()).abs();

    const Duration hour = Duration(hours: 1);
    const Duration day = Duration(hours: 24);

    if (duration < hour) {
      return '${duration.inMinutes.floor()}m';
    } else if (duration >= hour && duration < day) {
      return '${duration.inHours.floor()}h ${(duration.inMinutes % 60).floor()}m';
    } else
      return '${duration.inDays.floor()}d';
  }
}
