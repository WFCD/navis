import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';

export 'package:flutter_gen/gen_l10n/navis_localizations.dart';

extension AppLocalizationsX on BuildContext {
  NavisLocalizations get l10n {
    final locale = NavisLocalizations.of(this);

    if (locale != null) return locale;

    throw Exception('NavisLocalization is not in the given context');
  }
}

extension LocalesX on Locale {
  String get fullName {
    return _isoLangs[languageCode]!['nativeName'] ?? 'Unknown';
  }
}

const Map<String, Map<String, String>> _isoLangs = {
  'cs': {'name': 'Czech', 'nativeName': 'česky, čeština'},
  'de': {'name': 'German', 'nativeName': 'Deutsch'},
  'en': {'name': 'English', 'nativeName': 'English'},
  'es': {'name': 'Spanish', 'nativeName': 'Español'},
  'fr': {'name': 'French', 'nativeName': 'Français'},
  'it': {'name': 'Italian', 'nativeName': 'Italiano'},
  'ko': {'name': 'Korean', 'nativeName': '한국어 (韓國語), 조선말 (朝鮮語)'},
  'pl': {'name': 'Polish', 'nativeName': 'polski'},
  'pt': {'name': 'Portuguese', 'nativeName': 'Português'},
  'ru': {'name': 'Russian', 'nativeName': 'русский язык'},
  'sr': {'name': 'Serbian', 'nativeName': 'српски језик'},
  'tr': {'name': 'Turkish', 'nativeName': 'Türkçe'},
  'zh': {'name': 'Chinese', 'nativeName': '中文 (Zhōngwén), 汉语, 漢語'},
};
