import 'dart:async';

import 'package:connecteo/connecteo.dart';

final _connectionChecker = ConnectionChecker(
  checkConnectionEntriesWeb: [
    ConnectionEntry.fromUrl('https://api.warframestat.us/'),
  ],
);

Future<bool> get hasInternetConnection => _connectionChecker.isConnected;

Future<T> onReconnect<T>(FutureOr<T> Function() todo) async {
  await _connectionChecker.untilConnects();

  return await todo();
}
