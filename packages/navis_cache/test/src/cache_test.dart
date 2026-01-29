import 'dart:io';

import 'package:hive_ce/hive.dart';
import 'package:navis_cache/navis_cache.dart';
import 'package:test/test.dart';

void main() {
  group('CacheManager', () {
    late Directory testDir;
    late CacheManager cacheManager;
    const testBoxName = 'test_cache';

    setUp(() async {
      // Create temporary directory for tests
      testDir = await Directory.systemTemp.createTemp('cache_test_');

      // Initialize cache manager
      cacheManager = await CacheManager.open(testDir.path, name: testBoxName);
    });

    tearDown(() async {
      // Clean up
      await Hive.close();
      if (testDir.existsSync()) {
        await testDir.delete(recursive: true);
      }
    });

    group('open', () {
      test('creates a CacheManager with correct name', () async {
        final manager = await CacheManager.open(testDir.path, name: 'custom_name');

        expect(manager.name, equals('custom_name'));
        await Hive.close();
      });

      test('uses default name "temp" when not specified', () async {
        final manager = await CacheManager.open(testDir.path);

        expect(manager.name, equals('temp'));
        await Hive.close();
      });
    });

    group('set', () {
      test('stores data successfully', () async {
        final testData = {'key': 'value', 'number': 42};

        await cacheManager.set('test_key', testData);
        final retrieved = cacheManager.get<Map<String, dynamic>>('test_key');

        expect(retrieved, equals(testData));
      });

      test('stores data with TTL', () async {
        final testData = {'message': 'hello'};

        await cacheManager.set('ttl_key', testData, ttl: const Duration(hours: 1));

        final retrieved = cacheManager.get<Map<String, dynamic>>('ttl_key');
        expect(retrieved, equals(testData));
      });

      test('overwrites existing data with same key', () async {
        final firstData = {'version': 1};
        final secondData = {'version': 2};

        await cacheManager.set('overwrite_key', firstData);
        await cacheManager.set('overwrite_key', secondData);

        final retrieved = cacheManager.get<Map<String, dynamic>>('overwrite_key');
        expect(retrieved, equals(secondData));
      });

      test('stores empty map', () async {
        await cacheManager.set('empty_key', {});

        final retrieved = cacheManager.get<Map<String, dynamic>>('empty_key');
        expect(retrieved, equals({}));
      });

      test('stores nested map structure', () async {
        final complexData = {
          'user': {
            'name': 'John',
            'profile': {
              'age': 30,
              'tags': ['dart', 'flutter'],
            },
          },
        };

        await cacheManager.set('nested_key', complexData);

        final retrieved = cacheManager.get<Map<String, dynamic>>('nested_key');
        expect(retrieved, equals(complexData));
      });
    });

    group('get', () {
      test('returns null for non-existent key', () {
        final result = cacheManager.get<Map<String, dynamic>>('non_existent_key');

        expect(result, isNull);
      });

      test('returns stored data for valid key', () async {
        final testData = {'status': 'active'};
        await cacheManager.set('valid_key', testData);

        final result = cacheManager.get<Map<String, dynamic>>('valid_key');

        expect(result, equals(testData));
      });

      test('returns null for expired data', () async {
        final testData = {'temp': 'data'};

        // Set with very short TTL
        await cacheManager.set('expired_key', testData, ttl: const Duration(milliseconds: 1));

        // Wait for expiration
        await Future<void>.delayed(const Duration(milliseconds: 10));

        final result = cacheManager.get<Map<String, dynamic>>('expired_key');
        expect(result, isNull);
      });

      test('returns data before expiration', () async {
        final testData = {'fresh': 'data'};

        await cacheManager.set('fresh_key', testData, ttl: const Duration(seconds: 10));

        final result = cacheManager.get<Map<String, dynamic>>('fresh_key');
        expect(result, equals(testData));
      });

      test('handles multiple keys independently', () async {
        final data1 = {'key': 'value1'};
        final data2 = {'key': 'value2'};
        final data3 = {'key': 'value3'};

        await cacheManager.set('key1', data1);
        await cacheManager.set('key2', data2);
        await cacheManager.set('key3', data3);

        expect(cacheManager.get<Map<String, dynamic>>('key1'), equals(data1));
        expect(cacheManager.get<Map<String, dynamic>>('key2'), equals(data2));
        expect(cacheManager.get<Map<String, dynamic>>('key3'), equals(data3));
      });
    });

    group('TTL behavior', () {
      test('Duration.zero means immediate expiration', () async {
        final testData = {'instant': 'expire'};

        await cacheManager.set('zero_ttl', testData, ttl: Duration.zero);

        // With Duration.zero, data should expire immediately
        final result = cacheManager.get<Map<String, dynamic>>('zero_ttl');
        expect(result, isNull);
      });

      test('long TTL keeps data accessible', () async {
        final testData = {'long': 'lived'};

        await cacheManager.set('long_ttl', testData, ttl: const Duration(days: 365));

        final result = cacheManager.get<Map<String, dynamic>>('long_ttl');
        expect(result, equals(testData));
      });
    });

    group('edge cases', () {
      test('handles special characters in keys', () async {
        const specialKey = r'key:with/special\chars@#$%';
        final testData = {'special': 'chars'};

        await cacheManager.set(specialKey, testData);

        final result = cacheManager.get<Map<String, dynamic>>(specialKey);
        expect(result, equals(testData));
      });

      test('handles various data types in map values', () async {
        final testData = {
          'string': 'text',
          'int': 42,
          'double': 3.14,
          'bool': true,
          'null': null,
          'list': [1, 2, 3],
          'map': {'nested': 'value'},
        };

        await cacheManager.set('mixed_types', testData);

        final result = cacheManager.get<Map<String, dynamic>>('mixed_types');
        expect(result, equals(testData));
      });
    });

    group('persistence', () {
      test('data persists across cache manager instances', () async {
        final testData = {'persist': 'test'};

        // Store data
        await cacheManager.set('persist_key', testData, ttl: const Duration(hours: 1));
        await Hive.close();

        // Create new instance
        final newManager = await CacheManager.open(testDir.path, name: testBoxName);

        // Data should still be there
        final result = newManager.get<Map<String, dynamic>>('persist_key');
        expect(result, equals(testData));
      });
    });
  });
}
