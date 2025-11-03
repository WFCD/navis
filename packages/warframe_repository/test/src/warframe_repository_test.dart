import 'package:http/http.dart';
import 'package:test/test.dart';
import 'package:warframe_repository/warframe_repository.dart';

void main() {
  group('WarframeRepository', () {
    test('can be instantiated', () {
      expect(WarframeRepository(client: Client()), isNotNull);
    });
  });
}
