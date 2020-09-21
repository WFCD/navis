import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

Future<void> mockSetup() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  final directory = await Directory.systemTemp.createTemp();

  PathProviderPlatform.instance = MockPathProviderPlatform();

  HydratedBloc.storage = await HydratedStorage.build();
  Hive.init(directory.path);
}

class MockPathProviderPlatform extends Mock
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String> getApplicationDocumentsPath() => _testDirectory();

  @override
  Future<String> getTemporaryPath() => _testDirectory();

  Future<String> _testDirectory() async {
    final directory = await Directory.systemTemp.createTemp();

    return directory.path;
  }
}
