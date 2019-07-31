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
  Platforms get platform => storage.platform;

  @override
  ThemeData get theme {
    final enabled = storage.darkMode;

    const primary = Color.fromRGBO(26, 80, 144, .9);
    const accent = Color(0xFF00BC8C);

    return ThemeData(
        brightness: enabled ? Brightness.dark : Brightness.light,
        primaryColor: primary,
        accentColor: accent,
        cardColor: enabled ? const Color(0xFF2C2C2C) : null,
        dialogBackgroundColor: enabled ? const Color(0xFF212121) : null,
        scaffoldBackgroundColor: enabled ? const Color(0xFF212121) : null,
        canvasColor: enabled ? const Color(0xFF212121) : null,
        splashColor: accent);
  }

  @override
  Map<String, bool> get acolytes => storage.acolytes;

  @override
  Map<String, bool> get cycles => storage.cycles;

  @override
  Map<String, bool> get news => storage.news;

  @override
  Map<String, bool> get simple => storage.simple;
}
