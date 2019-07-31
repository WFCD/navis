//import 'dart:io';

//import 'package:navis/services/localstorage_service.dart';
import 'package:navis/services/repository.dart';
import 'package:test/test.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

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
  // final directory = await Directory.systemTemp.createTemp();
  // final asset = File('../assets/slim.json');

  Repository repository;

  setUpAll(() async {
    await setupPackageMockMethods();
    repository = await Repository.initialize();
  });

  group('Test Worldstate APi', () {
    test('Test PC endpoint', () async {
      final state = await repository.getWorldstate(Platforms.pc);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test PS4 endpoint', () async {
      final state = await repository.getWorldstate(Platforms.ps4);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Xbox one endpoint', () async {
      final state = await repository.getWorldstate(Platforms.xb1);
      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Switch endpoint', () async {
      final state = await repository.getWorldstate(Platforms.swi);
      expect(state, const TypeMatcher<Worldstate>());
    });
  });

  // group('Test Drop table endpoint', () {
  //   test('Check if file is downloaded', () async {
  //     final source = File('${directory.path}/drop_table.json');

  //     await repository.updateDropTable(source);
  //     expectLater(source.existsSync(), true);
  //   });
  // });
}
