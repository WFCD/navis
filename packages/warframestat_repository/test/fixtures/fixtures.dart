import 'fixture_reader.dart';

abstract class Fixtures {
  static final Map<String, dynamic> worldstateFixture = fixture<Map<String, dynamic>>('worldstate.json');

  static final List<dynamic> synthTargetsFixture = fixture<List<dynamic>>('synthTargets.json');

  static final List<dynamic> itemsFixture = fixture<List<dynamic>>('items.json');
}
