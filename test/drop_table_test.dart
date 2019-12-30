import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navis/repository/drop_table_repository.dart';
import 'package:navis/resources/api/drop_table_client.dart';

Future<void> main() async {
  const methodChannel = MethodChannel('plugins.flutter.io/path_provider');
  final directory = await Directory.systemTemp.createTemp();
  final table = File('${directory.path}/drop_table.json');

  TestWidgetsFlutterBinding.ensureInitialized();

  DropTableClient api;
  DropTableRepository repository;

  setUpAll(() {
    api = const DropTableClient();
    repository = DropTableRepository();

    methodChannel.setMockMethodCallHandler((MethodCall methodCall) async {
      if (methodCall.method == 'getTemporaryDirectory') return directory.path;

      return null;
    });
  });

  tearDownAll(() {
    api = null;
    repository = null;
  });

  group('Test drop table api', () {
    test('Download drop table', () async {
      await api.downloadDropTable(table);

      expect(table.existsSync(), true);
    });
  });

  group('Test drop table repository', () {
    test('Download drop table using isolates', () async {
      await repository.initDrops();

      expect(table.existsSync(), true);
    });
  });
}
