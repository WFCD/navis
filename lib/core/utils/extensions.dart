import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/navis_localizations.dart';

extension DateTimeX on DateTime {
  String format(BuildContext context) {
    return MaterialLocalizations.of(context).formatFullDate(this);
  }
}

extension ContextX on BuildContext {
  NavisLocalizations get locale => NavisLocalizations.of(this);
}
