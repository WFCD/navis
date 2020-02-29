import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:navis/core/error/exceptions.dart';
import 'package:navis/core/utils/data_source_utils.dart';
import 'package:navis/core/data/datasources/warframestat_remote.dart';
import 'package:test/test.dart';

import '../../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  http.Client mockHttpClient;
  WarframestatRemote api;

  setUp(() {
    mockHttpClient = MockHttpClient();
    api = WarframestatRemote(mockHttpClient);
  });

  void setUpMockHttpClientSuccess200(String fixture) {
    when(mockHttpClient.get(any, headers: anyNamed('headers'))).thenAnswer(
      (_) async => http.Response(
        fixture,
        200,
        headers: {'content-type': 'application/json; charset=utf-8'},
      ),
    );
  }

  void setUpMockHttpClientFailure404() {
    when(mockHttpClient.get(any, headers: anyNamed('headers')))
        .thenAnswer((_) async => http.Response('Something went wrong', 404));
  }

  group('getWorldstate', () {
    final tWorldstate = toWorldstate(fixture('worldstate.json'));

    test('should return an instance of Worldstate equal to tWorldstate',
        () async {
      setUpMockHttpClientSuccess200(fixture('worldstate.json'));

      final result = await api.getWorldstate(GamePlatforms.pc);

      expect(result, equals(tWorldstate));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = api.getWorldstate;

      expect(() => call(GamePlatforms.pc),
          throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('getSynthTargets', () {
    final tSynthTargets = toTargets(fixture('synthTargets.json'));

    test('should return an instance of SynthTargts equal to tSynthtargets',
        () async {
      setUpMockHttpClientSuccess200(fixture('synthTargets.json'));

      final result = await api.getSynthTargets();

      expect(result, equals(tSynthTargets));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = api.getSynthTargets;

      expect(() => call(), throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group('searchItems', () {
    final tSearchResults = toBaseItems(fixture('search_results.json'));

    test('should return an instances of BaseItem equal to tSearchResults',
        () async {
      setUpMockHttpClientSuccess200(fixture('search_results.json'));

      final result = await api.searchItems('chroma');

      expect(result, equals(tSearchResults));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      setUpMockHttpClientFailure404();

      final call = api.searchItems;

      expect(
          () => call('chroma'), throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
