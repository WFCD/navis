import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:navis/utils/enums.dart';

abstract class ChangeEvent extends Equatable {
  ChangeEvent([List props = const []]) : super(props);
}

class RestoreEvent extends ChangeEvent {}

class ChangePlatformEvent extends ChangeEvent {
  ChangePlatformEvent(this.platform) : super([platform]);

  final Platforms platform;
}

class ChangeDateFormat extends ChangeEvent {
  ChangeDateFormat(this.dateformat) : super([dateformat]);

  final Formats dateformat;
}

class ToggleNotification extends ChangeEvent {
  ToggleNotification(this.key, this.value, [this.options])
      : super([key, value, options]);

  final String key;
  final bool value;
  final List<String> options;
}

class ChangeThemeData extends ChangeEvent {
  ChangeThemeData({this.enableDark, this.primaryColor, this.accentColor})
      : super([enableDark, primaryColor, accentColor]);

  final bool enableDark;
  final Color primaryColor, accentColor;
}
