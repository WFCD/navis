import 'dart:typed_data';

import 'package:cache_client/src/cached_item.dart';
import 'package:hive_ce/hive.dart';

part 'hive_adapters.g.dart';

@GenerateAdapters([AdapterSpec<CachedItem>()])
// Annotations must be on some element
// ignore: unused_element
void _() {}
