import 'package:flutter/material.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/utils/utils.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';

abstract class StorageState {
  Formats dateformat;
  Platforms platform;

  ThemeData theme;

  Map<String, bool> acolytes;
  Map<String, bool> cycles;
  Map<String, bool> news;
  Map<String, bool> simple;
}

class MainStorageState extends StorageState {
  MainStorageState(this.storage);

  final LocalStorageService storage;

  @override
  Formats get dateformat => storage.dateformat;

  @override
  Platforms get platform => storage.platform ?? Platforms.pc;

  @override
  Map<String, bool> get acolytes => storage.acolytes;

  @override
  Map<String, bool> get cycles => storage.cycles;

  @override
  Map<String, bool> get news => storage.news;

  @override
  Map<String, bool> get simple => storage.simple;
}
