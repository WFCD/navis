import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:navis/features/worldstate/domain/repositories/worldstate_repository.dart';
import 'package:navis/features/worldstate/domain/usecases/get_worldstate.dart';
import 'package:test/test.dart';
import 'package:wfcd_client/entities.dart';
import 'package:wfcd_client/wfcd_client.dart';

import '../../../fixtures/fixture_reader.dart';

class MockWorldstateRepository extends Mock implements WorldstateRepository {}

void main() {
  final stateFixture = fixture('worldstate.json');

  late GetWorldstate getWorldstate;
  late WorldstateRepository mockRepository;

  setUp(() {
    mockRepository = MockWorldstateRepository();
    getWorldstate = GetWorldstate(mockRepository);
  });

  final tWorldstate =
      toWorldstate(json.decode(stateFixture) as Map<String, dynamic>);

  test('should get worldstate from repository', () async {
    when(() => mockRepository.getWorldstate(
            forceUpdate: any(named: 'forceUpdate')))
        .thenAnswer((_) async => Right(tWorldstate));

    final result = await getWorldstate(false);

    expect(result, equals(Right<Exception, Worldstate>(tWorldstate)));
    verify(() =>
        mockRepository.getWorldstate(forceUpdate: any(named: 'forceUpdate')));
    verifyNoMoreInteractions(mockRepository);
  });
}
