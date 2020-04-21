import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:navis/features/worldstate/presentation/bloc/solsystem_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:wfcd_client/locals.dart';
import 'package:wfcd_client/remotes.dart';

import 'core/bloc/navigation_bloc.dart';
import 'core/network/network_info.dart';
import 'features/worldstate/data/datasources/event_info_parser.dart';
import 'features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'features/worldstate/domain/usecases/get_synth_targets.dart';
import 'features/worldstate/domain/usecases/get_worldstate.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  final temp = await getTemporaryDirectory();
  Hive.init(temp.path);

  //! Core
  sl.registerSingleton<NetworkInfoImpl>(
      NetworkInfoImpl(DataConnectionChecker()));

  sl.registerSingleton<EventInfoParser>(await EventInfoParser.loadEventData());

  // Data sources
  sl.registerSingleton<WarframestatRemote>(WarframestatRemote(http.Client()));

  sl.registerSingleton<WarframestatCache>(
      WarframestatCache(await Hive.openBox<dynamic>('worldstate_cache')));

  // Repository
  sl.registerSingleton<WorldstateRepositoryImpl>(
    WorldstateRepositoryImpl(sl<NetworkInfoImpl>(), sl<WarframestatCache>()),
  );

  // Usecases
  sl.registerSingleton<GetWorldstate>(
      GetWorldstate(sl<WorldstateRepositoryImpl>()));
  sl.registerSingleton<GetDarvoDealInfo>(
      GetDarvoDealInfo(sl<WorldstateRepositoryImpl>()));
  sl.registerSingleton<GetSynthTargets>(
      GetSynthTargets(sl<WorldstateRepositoryImpl>()));

  // Blocs
  sl.registerFactory<NavigationBloc>(() => NavigationBloc());
  sl.registerFactory<SolsystemBloc>(() {
    return SolsystemBloc(
      getWorldstate: sl<GetWorldstate>(),
      getDarvoDealInfo: sl<GetDarvoDealInfo>(),
      getSynthTargets: sl<GetSynthTargets>(),
    );
  });
}
