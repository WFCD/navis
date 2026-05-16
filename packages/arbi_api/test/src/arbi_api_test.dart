// Not required for test files
import 'package:arbi_api/arbi_api.dart';
import 'package:http/http.dart';
import 'package:test/test.dart';

void main() {
  group('ArbiApi', () {
    test('can be instantiated', () {
      expect(ArbiApi(Client()), isNotNull);
    });
  });
}
