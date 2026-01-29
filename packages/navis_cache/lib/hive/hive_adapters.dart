import 'package:hive_ce/hive.dart';
import 'package:navis_cache/src/models/cached_data.dart';

@GenerateAdapters([AdapterSpec<CachedData>()])
part 'hive_adapters.g.dart';
