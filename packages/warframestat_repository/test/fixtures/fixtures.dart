import 'fixture_reader.dart';

abstract class Fixtures {
  static final worldstateFixture =
      fixture<Map<String, dynamic>>('worldstate.json');

  static final synthTargetsFixture =
      fixture<List<dynamic>>('synthTargets.json');

  static final itemsFixture = fixture<List<dynamic>>('items.json');
}
