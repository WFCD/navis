import 'dart:typed_data';

import 'package:hive_ce/hive.dart';
import 'package:http_client/src/models/cache_item.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<CachedItem>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}
