import 'dart:async';

import 'package:hive_ce/hive_ce.dart';

/// {@template storage_exception}
/// Exception thrown if a storage operation fails.
/// {@endtemplate}
class StorageException implements Exception {
  /// {@macro storage_exception}
  const StorageException(this.error);

  /// Error thrown during the storage operation.
  final Object error;
}

/// A Dart Storage Client Interface
class Storage<T> {
  Storage({required this._box});

  final Box<T> _box;

  Future<void> clear() async {
    try {
      await _box.clear();
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  Future<void> delete(String key) async {
    try {
      await _box.delete(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  Future<void> deleteAll(Iterable<dynamic> keys) async {
    try {
      await _box.deleteAll(keys);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  T? read(String key) {
    try {
      return _box.get(key);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  Iterable<T> readAll() => _box.toMap().values;

  Future<void> write(String key, T value) async {
    try {
      await _box.put(key, value);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(StorageException(error), stackTrace);
    }
  }

  Future<void> writeAll(Map<String, T> entries) async {
    try {
      await _box.putAll(entries);
    } on Exception catch (error, stackTrace) {
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  

  Future<void> close() => _box.close();
}
