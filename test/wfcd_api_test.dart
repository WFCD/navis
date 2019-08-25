import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:navis/services/repository.dart';
import 'package:test/test.dart';
import 'package:wfcd_api_wrapper/worldstate_wrapper.dart';
import 'package:worldstate_model/worldstate_models.dart';

import 'mock_class.dart';
import 'setup_methods.dart';

Future<void> main() async {
  final client = MockClient();

  Repository repository;

  setUpAll(() async {
    await setupPackageMockMethods();
    repository = await Repository.initialize(client: client);
  });

  group('Test Worldstate APi', () {
    test('Test PC endpoint', () async {
      final state = await repository.getWorldstate(Platforms.pc);

      when(client.get('https://api.warframestat.us/pc/')).thenAnswer(
          (_) async => http.Response(
              File('test/mockstate.json').readAsStringSync(), 200));

      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test PS4 endpoint', () async {
      final state = await repository.getWorldstate(Platforms.ps4);

      when(client.get('https://api.warframestat.us/ps4/')).thenAnswer(
          (_) async => http.Response(
              File('test/mockstate.json').readAsStringSync(), 200));

      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Xbox one endpoint', () async {
      final state = await repository.getWorldstate(Platforms.xb1);

      when(client.get('https://api.warframestat.us/xb1/')).thenAnswer(
          (_) async => http.Response(
              File('test/mockstate.json').readAsStringSync(), 200));

      expect(state, const TypeMatcher<Worldstate>());
    });

    test('Test Switch endpoint', () async {
      final state = await repository.getWorldstate(Platforms.swi);

      when(client.get('https://api.warframestat.us/swi/')).thenAnswer(
          (_) async => http.Response(
              File('test/mockstate.json').readAsStringSync(), 200));

      expect(state, const TypeMatcher<Worldstate>());
    });
  });

  // group('Test Drop table endpoint', () {
  //   test('Test file download', () async {
  //     final directory = await Directory.systemTemp.createTemp();
  //     final source = File('${directory.path}/drop_table.json');

  //     when(client.get('${Repository.dropTable}/data/all.slim.json')).thenAnswer(
  //         (_) async => http.Response(
  //             File('test/slim_mock_table.json').readAsStringSync(), 200));

  //     await repository.updateDropTable(source.path);

  //     expectLater(source.existsSync(), true);
  //   });
  // });
}
