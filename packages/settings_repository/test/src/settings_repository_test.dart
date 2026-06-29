// Not required for test files
// ignore_for_file: prefer_const_constructors
import 'package:settings_repository/settings_repository.dart';
import 'package:test/test.dart';

void main() {
  group('SettingsRepository', () {
    test('can be instantiated', () {
      expect(SettingsRepository(), isNotNull);
    });
  });
}
