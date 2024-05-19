import 'dart:async';

import 'package:connecteo/connecteo.dart';

abstract class ConnectionManager {
  static final _connectionChecker = ConnectionChecker(
    checkConnectionEntriesWeb: [
      ConnectionEntry.fromUrl('https://api.warframestat.us/'),
    ],
  );

  static Future<bool> get hasInternetConnection =>
      _connectionChecker.isConnected;

  static Future<T> call<T>(FutureOr<T> Function() todo) async {
    if (await hasInternetConnection) return await todo();
    await _connectionChecker.untilConnects();

    return await todo();
  }
}
