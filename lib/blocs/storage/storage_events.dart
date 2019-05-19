import 'package:equatable/equatable.dart';
import 'package:navis/utils/enums.dart';

abstract class ChangeEvent extends Equatable {}

class RestoreEvent extends ChangeEvent {}

class ChangePlatformEvent extends ChangeEvent {
  ChangePlatformEvent(this.platform);

  final Platforms platform;
}

class ChangeDateFormat extends ChangeEvent {
  ChangeDateFormat(this.dateformat);

  final Formats dateformat;
}

class ToggleNotification extends ChangeEvent {
  ToggleNotification(this.key, this.value, [this.options]);

  final String key;
  final bool value;
  final List<String> options;
}
