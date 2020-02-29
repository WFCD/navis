import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:navis/core/domain/repositories/warfamestat_repository.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';

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
        .thenAnswer((_) async => tWorldstate);

    final result = await getWorldstate(GamePlatforms.pc);

    expect(result, equals(tWorldstate));
    verify(mockRepository.getWorldstate(GamePlatforms.pc));
    verifyNoMoreInteractions(mockRepository);
  });
}
