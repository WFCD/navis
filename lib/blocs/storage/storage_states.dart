import 'package:equatable/equatable.dart';
import 'package:navis/blocs/storage/storage_utils.dart';

abstract class StorageState extends Equatable {
  String platform;
  Formats dateFormat;
}

class AppStart extends StorageState {}

class MainStorageState extends StorageState {}
