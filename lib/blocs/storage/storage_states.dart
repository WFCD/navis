import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/service_locator.dart';
import 'package:navis/utils/enums.dart';

abstract class StorageState {
  Formats dateformat;
  Platforms platform;

  Map<String, bool> acolytes;
  Map<String, bool> cycles;
  Map<String, bool> news;
  Map<String, bool> simple;
}

class AppStart extends StorageState {}

class MainStorageState extends StorageState {
  final instance = locator<LocalStorageService>();

  @override
  Formats get dateformat => instance.dateformat;

  @override
  Platforms get platform => instance.platform;

  @override
  Map<String, bool> get acolytes => instance.acolytes;

  @override
  Map<String, bool> get cycles => instance.cycles;

  @override
  Map<String, bool> get news => instance.news;

  @override
  Map<String, bool> get simple => instance.simple;
}
