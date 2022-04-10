import 'fixture_reader.dart';

abstract class Fixtures {
  static final worldstateFixture =
      fixture<Map<String, dynamic>>('worldstate.json');

  static final synthTargetsFixture =
      fixture<List<dynamic>>('synthTargets.json');

  static final dealFixture = fixture<Map<String, dynamic>>('darvo_deal.json');
}
