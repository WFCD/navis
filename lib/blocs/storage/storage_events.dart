import 'package:equatable/equatable.dart';
import 'package:navis/blocs/storage/storage_utils.dart';

abstract class ChangeEvent extends Equatable {}

class RestoreEvent extends ChangeEvent {}

class ChangePlatformEvent extends ChangeEvent {
  ChangePlatformEvent(this.platform);

  final String platform;
}

class ChangeDateFormat extends ChangeEvent {
  ChangeDateFormat(this.dateformat);

  final Formats dateformat;
}
