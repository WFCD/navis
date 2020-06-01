import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/usecases/usecases.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:warframestat_api_models/entities.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWorldstateRepository extends Mock implements WorldstateRepository {}

void main() {
  GetWorldstate getWorldstate;
  WorldstateRepository mockRepository;

  setUp(() {
    mockRepository = MockWorldstateRepository();
    getWorldstate = GetWorldstate(mockRepository);
  });

  final tWorldstate = toWorldstate(fixture('worldstate.json'));

  test('should get worldstate from repository', () async {
    when(mockRepository.getWorldstate())
        .thenAnswer((_) async => Right(tWorldstate));

    final result = await getWorldstate(NoParama());

    expect(result, equals(Right<Exception, Worldstate>(tWorldstate)));
    verify(mockRepository.getWorldstate());
    verifyNoMoreInteractions(mockRepository);
  });
}
