import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:user_settings/user_settings.dart';
import 'package:wfcd_client/wfcd_client.dart';

Future<void> main() async {
  final temp = await Directory.systemTemp.createTemp();

  late UserSettings settings;

  setUpAll(() async {
    settings = await UserSettings.initSettings(temp.path);
  });

  tearDownAll(() async {
    await settings.close();
    await temp.delete(recursive: true);
  });

  test('Test language toggles', () {
    const locale = Locale('en');

    settings.setLanguage(locale);
    expect(settings.language, locale);
  });

  test('Test platform toggles', () {
    for (final platform in GamePlatforms.values) {
      settings.platform = platform;
      expect(settings.platform, platform);
    }
  });

  test('Test theme toggles', () {
    // Make sure that it returns ThemeMode.system by default
    expect(settings.theme, ThemeMode.system);

    for (final mode in ThemeMode.values) {
      settings.theme = mode;
      expect(settings.theme, mode);
    }
  });

  test('Test back key enable/disable toggle', () {
    // Make sure the default value is false.
    expect(settings.backkey, false);

    settings.backkey = true;
    expect(settings.backkey, true);

    settings.backkey = false;
    expect(settings.backkey, false);
  });

  test('Test analytics enable/disable toggle', () {
    // Make sure the default value is false.
    expect(settings.isOptOut, false);

    settings.isOptOut = true;
    expect(settings.isOptOut, true);

    settings.isOptOut = false;
    expect(settings.isOptOut, false);
  });

  test("Test that isFirstTime returns true the first time it's called", () {
    expect(settings.isFirstTime, true);

    // We want it to return false the second time we call it
    expect(settings.isFirstTime, false);
  });
}
