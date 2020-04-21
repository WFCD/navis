import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:navis/features/worldstate/domain/usecases/get_synth_targets.dart';
import 'package:worldstate_api_model/entities.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWorldstateRepository extends Mock implements WorldstateRepository {}

void main() {
  GetSynthTargets getSynthTargets;
  WorldstateRepository mockRepository;

  setUp(() {
    mockRepository = MockWorldstateRepository();
    getSynthTargets = GetSynthTargets(mockRepository);
  });

  final tSynthTargets = toTargets(fixture('synthTargets.json'));

  test('should get SynthTargets from repository', () async {
    when(mockRepository.getSynthTargets())
        .thenAnswer((_) async => Right(tSynthTargets));

    final results = await getSynthTargets(NoParama());

    expect(results, equals(Right<Exception, List<SynthTarget>>(tSynthTargets)));
    verify(mockRepository.getSynthTargets());
    verifyNoMoreInteractions(mockRepository);
  });
}
