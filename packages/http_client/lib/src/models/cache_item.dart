import 'dart:typed_data';

import 'package:hive_ce/hive.dart';

class CachedItem extends HiveObject {
  CachedItem({required this.data, required this.timestamp, required this.ttl});

  final Uint8List data;

  final DateTime timestamp;

  final Duration ttl;

  bool get isExpired => DateTime.timestamp().difference(timestamp) >= ttl;
}
