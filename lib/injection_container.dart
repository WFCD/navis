import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/bloc/navigation_bloc.dart';
import 'core/network/network_info.dart';
import 'features/worldstate/data/datasources/warframestat_local.dart';
import 'features/worldstate/data/datasources/warframestat_remote.dart';
import 'features/worldstate/data/repositories/warframestat_repository_impl.dart';
import 'features/worldstate/domain/usecases/get_synth_targets.dart';
import 'features/worldstate/domain/usecases/get_worldstate.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Blocs
  sl.registerFactory(() => NavigationBloc());
  sl.registerFactory(() => SolsystemBloc(worldstate: sl<GetWorldstate>()));

  // Usecases
  sl.registerSingleton(() => GetWorldstate(sl<WarframestatRepositoryImpl>()));
  sl.registerSingleton(() => GetSynthTargets(sl<WarframestatRepositoryImpl>()));

  // Repository
  sl.registerSingleton(
    () => WarframestatRepositoryImpl(
      local: sl<WarframestatCache>(),
      remote: sl<WarframestatRemote>(),
      networkInfo: sl<NetworkInfo>(),
    ),
  );

  // Data sources
  final temp = await getTemporaryDirectory();
  Hive.init(temp.path);

  sl.registerSingleton(() => WarframestatRemote(http.Client()));
  sl.registerSingleton(
      () async => WarframestatCache(await Hive.openBox<dynamic>('cache')));

  //! Core
  sl.registerSingleton(() => NetworkInfoImpl(DataConnectionChecker()));
}
