import 'package:test/test.dart';
import 'package:warframe_items_model/warframe_items_model.dart';
import 'package:wfcd_client/clients.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/entities.dart';

void main() {
  const client = WorldstateClient();

  group('Type casting checks', () {
    test('Worldstate checks', () async {
      final worldstate = await client.getWorldstate(Platforms.pc);

      expect(worldstate, const TypeMatcher<Worldstate>());
    });

    test('Warframe Items search checks', () async {
      final searchs = await client.searchItems('chroma');

      expect(searchs, const TypeMatcher<List<BaseItem>>());
    });

    test('SynthTargets checks', () async {
      final targets = await client.synthTargets();

      expect(targets, const TypeMatcher<List<SynthTarget>>());
    });
  });
}
