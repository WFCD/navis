import 'package:warframe_api/warframe_api.dart';
import 'package:warframestat_client/warframestat_client.dart';

Language localeToLang(WorldstateLocale locale) {
  return Language.values.byName(locale.name);
}
