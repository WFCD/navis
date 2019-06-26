import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/services/wfcd_api.dart';
import 'package:navis/utils/enums.dart';
import 'package:test/test.dart';

Map<String, dynamic> mockstate = {
  'news': [],
  'alerts': [],
  'syndicateMissions': [],
  'fissures': [],
  'invasions': [],
  'persistentEnemies': []
};

Future<void> main() async {
  final directory = await Directory.systemTemp.createTemp();

  WFCD wfcd;
  LocalStorageService storage;

  setUpAll(() async {
    const MethodChannel('plugins.flutter.io/shared_preferences')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getAll') {
        return <String, dynamic>{}; // set initial values here if desired
      }
      return null;
    });

    // Mock out the MethodChannel for the path_provider plugin.
    const MethodChannel('plugins.flutter.io/path_provider')
        .setMockMethodCallHandler((MethodCall methodCall) async {
      // If you're getting the apps documents directory, return the path to the
      // temp directory on the test environment instead.
      if (methodCall.method == 'getApplicationDocumentsDirectory') {
        return directory.path;
      }
      return null;
    });

    await setupLocator(isTest: true);

    storage = locator<LocalStorageService>();
    wfcd = WFCD();

    wfcd.warframestat.interceptors.add(InterceptorsWrapper(
        onRequest: (option) => wfcd.warframestat.resolve(mockstate)));
  });

  group('Test Worldstate APi', () {
    test('Test PC endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.pc);
      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test PS4 endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.ps4);
      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test Xbox one endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.xb1);
      expect(state, const TypeMatcher<WorldState>());
    });

    test('Test Switch endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.swi);
      expect(state, const TypeMatcher<WorldState>());
    });
  });

  group('Test Drop table endpoint', () {
    test('Check if file is downloaded', () async {
      final source = File('${directory.path}/drop_table.json');

      await wfcd.getDropTable(source, storage.tableTimestamp, DateTime.now());
      expectLater(source.existsSync(), true);
    });
  });
}
