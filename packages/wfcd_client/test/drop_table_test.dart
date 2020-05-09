import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/remotes.dart';
import 'package:wfcd_client/src/local/drop_table_local.dart';
import 'package:worldstate_api_model/models.dart';

import 'fixtures/fixture_reader.dart';

class MockClient extends Mock implements http.Client {}

class MockBox<T> extends Mock implements Box<T> {}

void main() {
  final tInfoFixture = fixture('info.json');
  final tTableFixture = fixture('drop_table.json');

  final tTimestamp = DateTime.fromMillisecondsSinceEpoch(
      json.decode(tInfoFixture)['timestamp'] as int);

  final tTable = (json.decode(tTableFixture) as List<dynamic>)
      .map((dynamic e) => SlimDropModel.fromJson(e as Map<String, dynamic>))
      .toList();

  http.Client mockClient;

  DropTableRemote remote;
  DropTableLocal local;

  setUpAll(() async {
    final directory = Directory.systemTemp;

    Hive.init(directory.path);

    mockClient = MockClient();

    remote = DropTableRemote(mockClient);
    local = DropTableLocal(directory, await Hive.openBox<dynamic>('test'));
  });

  group('Remote test', () {
    test('timestamp', () async {
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(tInfoFixture, 200));

      final timestamp = await remote.dropsTimestamp();

      expect(timestamp, equals(tTimestamp));
    });

    test('drop table', () async {
      when(mockClient.get(any))
          .thenAnswer((_) async => http.Response(tTableFixture, 200));

      final table = await remote.getDropTable();

      final objects = (json.decode(table) as List<dynamic>)
          .map((dynamic e) => SlimDropModel.fromJson(e as Map<String, dynamic>))
          .toList();

      expect(objects, equals(tTable));
    });
  });

  group('Local test', () {
    test('timestamp', () async {
      final now = DateTime.now();

      local.cacheTableTimestamp(now);
      expect(local.getTableTimestamp(), equals(now));
    });

    test('drop table', () async {
      await local.saveDropTable(tTableFixture);

      final table = await local.getDropTable();

      expect(table, equals(tTable));
    });
  });
}
