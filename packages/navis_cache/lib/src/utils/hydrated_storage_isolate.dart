import 'dart:async';
import 'dart:isolate';
import 'dart:ui' as dart;

import 'package:hive_ce/hive_ce.dart';
// ignore: implementation_imports Need to use this direcly to avoid conflicting with existing Hive.init
import 'package:hive_ce/src/isolate/isolated_hive_impl/isolated_hive_impl.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:synchronized/synchronized.dart';

// This is gonna be super hacky and might brake at a some point

class HydratedNameServer extends IsolateNameServer {
  const HydratedNameServer();

  @override
  dynamic lookupPortByName(String name) => dart.IsolateNameServer.lookupPortByName(name);

  @override
  bool registerPortWithName(dynamic port, String name) =>
      dart.IsolateNameServer.registerPortWithName(port as SendPort, name);

  @override
  bool removePortNameMapping(String name) => dart.IsolateNameServer.removePortNameMapping(name);
}

// Pretty much a reimpl of the one hydrated_bloc uses. The only difference is that it uses an IsolatedHive to offload
// caching to an isolate
class HydratedStorageIsolate implements Storage {
  HydratedStorageIsolate(this._box);

  static Future<HydratedStorageIsolate> build({
    required HydratedStorageDirectory storageDirectory,
    HydratedCipher? encryptionCipher,
  }) {
    return _lock.synchronized(() async {
      hive = IsolatedHiveImpl();
      IsolatedBox<dynamic> box;

      if (storageDirectory == HydratedStorageDirectory.web) {
        box = await hive.openBox<dynamic>('hydrated_box', encryptionCipher: encryptionCipher);
      } else {
        await hive.init(storageDirectory.path, isolateNameServer: const HydratedNameServer());
        box = await hive.openBox<dynamic>('hydrated_box', encryptionCipher: encryptionCipher);
      }

      return HydratedStorageIsolate(box);
    });
  }

  static late IsolatedHiveInterface hive;
  static final _lock = Lock();

  final IsolatedBox<dynamic> _box;

  @override
  dynamic read(String key) {
    dynamic d;
    if (_box.isOpen) {
      _box.get(key).then((data) => d = data);
    }

    return d;
  }

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
      return _lock.synchronized(_box.clear);
    }
  }

  @override
  Future<void> close() async {
    if (_box.isOpen) {
      return _lock.synchronized(_box.close);
    }
  }
}
