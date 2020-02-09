import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'core/bloc/navigation_bloc.dart';
import 'core/data/datasources/warframestat_local.dart';
import 'core/data/datasources/warframestat_remote.dart';
import 'core/data/repositories/warframestat_repository_impl.dart';
import 'core/network/network_info.dart';
import 'features/worldstate/domain/usecases/get_synth_targets.dart';
import 'features/worldstate/domain/usecases/get_worldstate.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerSingleton<NetworkInfoImpl>(
      NetworkInfoImpl(DataConnectionChecker()));

  // Data sources
  final temp = await getTemporaryDirectory();
  Hive.init(temp.path);

  sl.registerSingleton<WarframestatRemote>(WarframestatRemote(http.Client()));

  sl.registerSingleton<WarframestatCache>(
      WarframestatCache(await Hive.openBox<dynamic>('cache')));

  // Repository
  sl.registerSingleton<WarframestatRepositoryImpl>(
    WarframestatRepositoryImpl(
      local: sl<WarframestatCache>(),
      remote: sl<WarframestatRemote>(),
      networkInfo: sl<NetworkInfoImpl>(),
    ),
  );

  // Usecases
  sl.registerSingleton<GetWorldstate>(
      GetWorldstate(sl<WarframestatRepositoryImpl>()));

  sl.registerSingleton<GetSynthTargets>(
      GetSynthTargets(sl<WarframestatRepositoryImpl>()));

  // Blocs
  sl.registerFactory<NavigationBloc>(() => NavigationBloc());
  sl.registerFactory<SolsystemBloc>(
      () => SolsystemBloc(worldstate: sl<GetWorldstate>()));
}
