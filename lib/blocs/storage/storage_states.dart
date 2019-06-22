import 'package:flutter/material.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/utils/enums.dart';

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
  final instance = locator<LocalStorageService>();

  @override
  Formats get dateformat => instance.dateformat;

  @override
  Platforms get platform => instance.platform;

  @override
  ThemeData get theme {
    final enabled = instance.darkMode;

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
  Map<String, bool> get acolytes => instance.acolytes;

  @override
  Map<String, bool> get cycles => instance.cycles;

  @override
  Map<String, bool> get news => instance.news;

  @override
  Map<String, bool> get simple => instance.simple;
}
