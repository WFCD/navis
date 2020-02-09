import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';

extension PlatformX on GamePlatforms {
  String platformToString() => toString().split('.').last;
}

extension DateTimeX on DateTime {
  String format(BuildContext context) {
    return MaterialLocalizations.of(context).formatFullDate(this);
  }
}
