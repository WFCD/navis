import 'package:flutter/widgets.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';

export 'package:flutter_gen/gen_l10n/navis_localizations.dart';

extension AppLocalizationsX on BuildContext {
  NavisLocalizations get l10n => NavisLocalizations.of(this);
}
