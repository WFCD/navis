import 'package:hive_ce/hive.dart';
import '../src/models/cached_data.dart';

@GenerateAdapters([AdapterSpec<CachedData>()])
part 'hive_adapters.g.dart';
