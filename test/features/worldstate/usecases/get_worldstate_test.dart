import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:wfcd_client/base.dart';
import 'package:worldstate_api_model/entities.dart';

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
  const tInstance = GetWorldstateInstance(GamePlatforms.pc, lang: 'en');

  test('should get worldstate from repository', () async {
    when(mockRepository.getWorldstate(any))
        .thenAnswer((_) async => Right(tWorldstate));

    final result = await getWorldstate(tInstance);

    expect(result, equals(Right<Exception, Worldstate>(tWorldstate)));
    verify(
        mockRepository.getWorldstate(tInstance.platform, lang: tInstance.lang));
    verifyNoMoreInteractions(mockRepository);
  });
}
