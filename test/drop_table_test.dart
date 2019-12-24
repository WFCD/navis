import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:navis/repositories/repositories.dart';
import 'package:navis/resources/drop_table_api_provider.dart';

Future<void> main() async {
  const methodChannel = MethodChannel('plugins.flutter.io/path_provider');
  final directory = await Directory.systemTemp.createTemp();
  final table = File('${directory.path}/drop_table.json');

  TestWidgetsFlutterBinding.ensureInitialized();

  DropTableApiProvider api;
  DropTableRepository repository;

  setUpAll(() {
    api = const DropTableApiProvider();
    repository = const DropTableRepository();

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
