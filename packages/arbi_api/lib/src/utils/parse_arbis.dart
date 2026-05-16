// ignore_for_file: experimental_member_use I'm using it

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart';

const arbitrationActiveTime = Duration(hours: 1, seconds: 60);

Iterable<Arbitration> parseArbitrations(String csv, [WorldstateDataLocale locale = .en]) sync* {
  final timestamp = DateTime.timestamp();
  final nodes = solNodes(locale);
  final lines = const LineSplitter().convert(csv);

  for (final line in lines) {
    final [seconds, key] = line.split(',');
    final activation = DateTime.fromMillisecondsSinceEpoch(int.parse(seconds) * 1000);
    final expiry = activation.add(arbitrationActiveTime);

    if (timestamp.isAfter(expiry)) continue;

    final node = nodes.fetchNode(key);
    yield Arbitration(
      id: md5.convert(utf8.encode(line)).toString(),
      activation: activation,
      expiry: expiry,
      node: node.name,
      nodeKey: key,
      enemy: node.enemy,
      type: node.type ?? key,
      typeKey: key,
      archwing: false,
      sharkwing: false,
      expired: timestamp.isAfter(expiry),
    );
  }
}
