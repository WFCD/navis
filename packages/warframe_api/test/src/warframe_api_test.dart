import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:warframe_api/warframe_api.dart';
import 'package:warframe_drop_data/warframe_drop_data.dart';

String fixture(String file) => File('./test/fixtures/$file').readAsStringSync();

Response response(String body, [int statusCode = 200]) =>
    Response(body, 200, headers: {HttpHeaders.contentTypeHeader: ContentType.json.value});

class MockClient extends Mock implements BaseClient {}

void main() {
  setUpAll(() {
    registerFallbackValue(Uri());
  });

  group('WarframeApi', () {
    late MockClient client;

    setUp(() {
      client = MockClient();
    });

    tearDown(() {
      reset(client);
    });

    group('parseUserData', () {
      test('parses valid user-data JSON from fixture', () {
        final result = WarframeApi().parseUserData(fixture('user-data.json'));

        expect(result, isNotNull);
        verifyZeroInteractions(client);
      });

      test('handles multi-line JSON (line-splitter sanitisation)', () {
        final pretty = const JsonEncoder.withIndent('  ').convert(jsonDecode(fixture('user-data.json')));

        final result = WarframeApi().parseUserData(pretty);

        expect(result, isNotNull);
      });
    });

    group('fetchProfile', () {
      setUp(() {
        when(() => client.get(any())).thenAnswer((_) async => response(fixture('profile.json')));
      });

      test('returns a Profile parsed from fixture response', () async {
        final profile = await WarframeApi(client).fetchProfile('some-player-id');

        expect(profile, isNotNull);
      });

      test('sends request with correct playerId query param', () async {
        await WarframeApi(client).fetchProfile('ABC123');

        final captured = verify(
          () => client.get(
            captureAny(
              that: predicate<Uri>(
                (uri) => uri.toString().contains('getProfileViewingData.php'),
              ),
            ),
            headers: any(named: 'headers'),
          ),
        ).captured;

        expect(captured.first.toString(), contains('playerId=ABC123'));
      });
    });

    group('fetchWorldstate', () {
      test('returns a Worldstate parsed from fixture response', () async {
        when(() => client.get(any())).thenAnswer((_) async => response(fixture('worldstate.json')));
        final worldstate = await WarframeApi(client).fetchWorldstate([]);

        expect(worldstate, isNotNull);
      });
    });

    group('buildSyndicateRewardTable', () {
      test('returns a list without throwing', () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => Response.bytes(
            File('./test/fixtures/drops.html').readAsBytesSync(),
            200,
            headers: {HttpHeaders.contentTypeHeader: ContentType.html.value},
          ),
        );

        final tables = await WarframeApi(client).buildSyndicateRewardTable();

        expect(tables, isA<List<BountyRewardTable>>());
      });
    });
  });
}
