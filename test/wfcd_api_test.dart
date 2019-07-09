import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:navis/models/export.dart';
import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/services.dart';
import 'package:navis/services/wfcd_api.dart';
import 'package:navis/utils/utils.dart';
import 'package:test/test.dart';

import 'setup_methods.dart';

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
  final asset = File('../assets/slim.json');

  WFCD wfcd;
  LocalStorageService storage;

  setUpAll(() async {
    await setupPackageMockMethods();
    await setupLocator();

    storage = locator<LocalStorageService>();
    wfcd = WFCD();

    wfcd.warframestat.interceptors
        .add(InterceptorsWrapper(onRequest: (option) async {
      if (option.path.contains('drops'))
        return wfcd.warframestat
            .resolve(json.decode(await asset.readAsString()));

      return wfcd.warframestat.resolve(mockstate);
    }));
  });

  group('Test Worldstate APi', () {
    test('Test PC endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.pc);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test PS4 endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.ps4);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Xbox one endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.xb1);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Switch endpoint', () async {
      final state = await wfcd.getWorldstate(Platforms.swi);
      expect(state, const TypeMatcher<Worldstate>());
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
