import 'dart:typed_data';

import 'package:hive_ce/hive.dart';

class CachedItem extends HiveObject {
  CachedItem(this.data, this.expiry);

  final Uint8List data;

  final DateTime expiry;

  bool get isExpired => DateTime.timestamp().isAfter(expiry);
}
