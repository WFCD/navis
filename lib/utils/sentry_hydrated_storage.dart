// I copied this from hydrated_bloc and switched up hive for sentry_hive
// ignore_for_file: avoid_catches_without_on_clauses

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hive/hive.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:matomo_tracker/utils/lock.dart';
import 'package:sentry_hive/sentry_hive.dart';

// This is a copy and paste version of HydratedStorage with the exception that
// all Hive boxes are replaced with Sentry's version.
class SentryHydratedStorage implements Storage {
  SentryHydratedStorage(this._box);

  static final webStorageDirectory = Directory('');

  static Future<SentryHydratedStorage> build({required Directory storageDirectory, HydratedCipher? encryptionCipher}) {
    return _lock.synchronized(() async {
      if (_instance != null) return _instance!;

      Box<dynamic> box;

      if (storageDirectory == webStorageDirectory) {
        box = await SentryHive.openBox<dynamic>('hydrated_box', encryptionCipher: encryptionCipher);
      } else {
        SentryHive.init(storageDirectory.path);
        box = await SentryHive.openBox<dynamic>('hydrated_box', encryptionCipher: encryptionCipher);
        await _migrate(storageDirectory, box);
      }

      return _instance = SentryHydratedStorage(box);
    });
  }

  static Future<dynamic> _migrate(Directory directory, Box<dynamic> box) async {
    final file = File('${directory.path}/.hydrated_bloc.json');
    if (file.existsSync()) {
      try {
        final dynamic storageJson = json.decode(await file.readAsString());
        final cache = (storageJson as Map).cast<String, String>();
        for (final key in cache.keys) {
          try {
            final string = cache[key];
            final dynamic object = json.decode(string ?? '');
            await box.put(key, object);
          } catch (_) {}
        }
      } catch (_) {}
      await file.delete();
    }
  }

  static final _lock = Lock();
  static SentryHydratedStorage? _instance;

  final Box<dynamic> _box;

  @override
  dynamic read(String key) => _box.isOpen ? _box.get(key) : null;

  @override
  Future<void> write(String key, dynamic value) async {
    if (_box.isOpen) {
      return _lock.synchronized(() => _box.put(key, value));
    }
  }

  @override
  Future<void> delete(String key) async {
    if (_box.isOpen) {
      return _lock.synchronized(() => _box.delete(key));
    }
  }

  @override
  Future<void> clear() async {
    if (_box.isOpen) {
      _instance = null;
      return _lock.synchronized(_box.clear);
    }
  }

  @override
  Future<void> close() async {
    if (_box.isOpen) {
      _instance = null;
      return _lock.synchronized(_box.close);
    }
  }
}
