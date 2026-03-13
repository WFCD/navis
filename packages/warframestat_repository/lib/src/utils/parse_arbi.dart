// ignore_for_file: experimental_member_use I'm using it

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:warframe_worldstate_data/warframe_worldstate_data.dart';
import 'package:warframestat_client/warframestat_client.dart';

List<Arbitration> parseArbitration(String csv) {
  final arbis = const LineSplitter().convert(csv).map((line) {
    final parts = line.split(',');
    final activation = DateTime.fromMillisecondsSinceEpoch(int.parse(parts[0]) * 1000);
    final expiry = activation.add(const Duration(hours: 1, seconds: 60));
    final node = solNodes().fetchNode(parts[1]);

    return Arbitration(
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
      expired: DateTime.timestamp().isAfter(expiry),
    );
  }).toList();

  return arbis..removeWhere((a) => a.expired); // Clean up to reduce look up cost later
}
