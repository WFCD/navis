import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/usecases/get_synth_targets.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWarframestatRepository extends Mock
    implements WarframestatRepository {}

void main() {
  GetSynthTargets getSynthTargets;
  WarframestatRepository mockRepository;

  setUp(() {
    mockRepository = MockWarframestatRepository();
    getSynthTargets = GetSynthTargets(mockRepository);
  });

  final tSynthTargets = toTargets(fixture('synthTargets.json'));

  test('should get SynthTargets from repository', () async {
    when(mockRepository.getSynthTargets())
        .thenAnswer((_) async => tSynthTargets);

    final results = await getSynthTargets(NoParama());

    expect(results, equals(tSynthTargets));
    verify(mockRepository.getSynthTargets());
    verifyNoMoreInteractions(mockRepository);
  });
}
