import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/error/failures.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/repositories/warfamestat_repository.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:wfcd_client/enums.dart';
import 'package:worldstate_api_model/worldstate_models.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWarframestatRepository extends Mock
    implements WarframestatRepository {}

void main() {
  GetWorldstate getWorldstate;
  WarframestatRepository mockRepository;

  setUp(() {
    mockRepository = MockWarframestatRepository();
    getWorldstate = GetWorldstate(mockRepository);
  });

  final tWorldstate = toWorldstate(fixture('worldstate.json'));

  test('should get worldstate from repository', () async {
    when(mockRepository.getWorldstate(any))
        .thenAnswer((_) async => Right(tWorldstate));

    final result = await getWorldstate(Platforms.pc);

    expect(result, equals(Right<Failure, Worldstate>(tWorldstate)));
    verify(mockRepository.getWorldstate(Platforms.pc));
    verifyNoMoreInteractions(mockRepository);
  });
}
