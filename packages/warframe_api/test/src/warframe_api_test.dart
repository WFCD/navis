// Not required for test files
import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:warframe_api/warframe_api.dart';

void main() {
  group('WarframeApi', () {
    test('can be instantiated', () {
      expect(WarframeApi(client: Client()), isNotNull);
    });
  });
}
