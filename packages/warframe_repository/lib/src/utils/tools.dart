import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_repository/src/models/slim_item.dart';
import 'package:warframestat_client/warframestat_client.dart';

Language localeToLang(WorldstateLocale locale) {
  return Language.values.byName(locale.name);
}

SlimItem encodeSlimItem(Map<String, dynamic> item) {
  final name = item['name'] as String;
  final uniqueName = item['uniqueName'] as String;
  final category = item['category'] as String;

  if (name == 'Venari' || name == 'Venari Prime') item['type'] = 'Pets';
  if (category == 'Arcanes') item['type'] = 'Arcane';

  if (uniqueName.contains(RegExp('MoaPetParts|ZanukaPetParts'))) {
    item['type'] = 'Pet Resource';
  }

  return SlimItem.fromJson(item);
}
