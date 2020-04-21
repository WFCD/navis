import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension DateTimeX on DateTime {
  String format(BuildContext context) {
    return MaterialLocalizations.of(context).formatFullDate(this);
  }
}
