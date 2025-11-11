import 'package:cache/src/models/cached_data.dart';
import 'package:hive_ce/hive.dart';

@GenerateAdapters([AdapterSpec<CachedData>()])
part 'hive_adapters.g.dart';
