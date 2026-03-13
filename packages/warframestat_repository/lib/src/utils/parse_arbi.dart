// ignore_for_file: experimental_member_use I'm using it

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart';

List<Arbitration> parseArbitration(String csv) {
  const arbitrationActiveTime = Duration(hours: 1, seconds: 60);

  final now = DateTime.timestamp();
  final nodes = solNodes();
  final lines = const LineSplitter().convert(csv);

  final arbis = <Arbitration>[];
  for (final line in lines) {
    final parts = line.split(',');
    final activation = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[0]) * 1000);
    final expiry = activation.add(arbitrationActiveTime);

    // Discard any arbitrations that have passed except the currentyl active one
    if (now.isAfter(expiry)) continue;

    final node = nodes.fetchNode(parts[1]);
    arbis.add(
      Arbitration(
        id: md5.convert(utf8.encode(line)).toString(),
        activation: activation,
        expiry: expiry,
        node: node.name,
        nodeKey: parts[1],
        enemy: node.enemy,
        type: node.type ?? '',
        typeKey: node.type ?? '',
        archwing: false,
        sharkwing: false,
        expired: now.isAfter(expiry),
      ),
    );
  }

  return arbis;
}
