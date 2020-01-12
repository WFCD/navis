import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:html/parser.dart';
import 'package:navis/themes.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:worldstate_api_model/misc.dart';

import '../global_keys.dart';
import 'enums.dart';

String platformToString(Platforms platform) =>
    platform.toString().split('.').last;

List<ItemObject> jsonToItemObjects(String data) {
  final searchs = json.decode(data).cast<Map<String, dynamic>>();

  return searchs.map<ItemObject>(_jsonToItemObject).toList();
}

ItemObject _jsonToItemObject(Map<String, dynamic> item) {
  if (item['category'] == 'Warframes' ||
      item['category'] == 'Archwing' && !item.containsKey('damage')) {
    return Warframe.fromJson(item);
  }

  if (item['category'] == 'Primary' ||
      item['category'] == 'Secondary' ||
      item['category'] == 'Melee') {
    return Weapon.fromJson(item);
  }

  return BasicItem.fromJson(item);
}

List<SynthTarget> jsonToTargets(String data) {
  final targets = json.decode(data) as List<dynamic>;

  return targets.map<SynthTarget>((t) => SynthTarget.fromJson(t)).toList();
}

Future<void> launchLink(String link) async {
  try {
    await launch(link,
        option: CustomTabsOption(
          toolbarColor: AppTheme.primaryColor,
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

  return table.map<SlimDrop>((d) => SlimDrop.fromJson(d)).toList();
}
