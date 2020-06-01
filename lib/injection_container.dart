import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:navis/core/local/user_settings.dart';
import 'package:navis/features/synthtargets/data/repositories/synth_target_rep_impl.dart';
import 'package:navis/features/synthtargets/domain/usecases/get_synth_targets.dart';
import 'package:navis/features/synthtargets/presentation/bloc/synthtargets_bloc.dart';

import 'core/bloc/navigation_bloc.dart';
import 'core/local/warframestate_local.dart';
import 'core/network/network_info.dart';
import 'core/network/warframestat_remote.dart';
import 'features/synthtargets/domain/repositories/synth_target_repository.dart';
import 'features/worldstate/data/datasources/event_info_parser.dart';
import 'features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'features/worldstate/domain/repositories/worldstate_repository.dart';
import 'features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'features/worldstate/domain/usecases/get_worldstate.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  //! Core
  sl.registerSingleton<NetworkInfo>(NetworkInfoImpl(DataConnectionChecker()));

  sl.registerSingletonAsync<EventInfoParser>(
    () => EventInfoParser.loadEventData(),
  );

  // Data sources
  sl.registerSingleton<WarframestatClient>(WarframestatClient(http.Client()));

  sl.registerSingletonAsync(() => Usersettings.initUsersettings());

  sl.registerSingletonAsync<WarframestatCache>(
    () => WarframestatCache.initCache(),
  );

  await sl.isReady<WarframestatCache>();
  await sl.isReady<Usersettings>();

  // Repository
  sl.registerSingleton<WorldstateRepository>(
    WorldstateRepositoryImpl(
      sl<NetworkInfo>(),
      sl<WarframestatCache>(),
      sl<Usersettings>(),
    ),
  );
  sl.registerSingleton<SynthRepository>(
    SynthRepositoryImpl(sl<NetworkInfo>()),
  );

  // Usecases
  sl.registerSingleton<GetWorldstate>(
    GetWorldstate(sl<WorldstateRepository>()),
  );
  sl.registerSingleton<GetDarvoDealInfo>(
    GetDarvoDealInfo(sl<WorldstateRepository>()),
  );
  sl.registerSingleton<GetSynthTargets>(
    GetSynthTargets(sl<SynthRepository>()),
  );

  // Blocs
  sl.registerFactory<NavigationBloc>(() => NavigationBloc());
  sl.registerFactory<SolsystemBloc>(() {
    return SolsystemBloc(
      getWorldstate: sl<GetWorldstate>(),
      getDarvoDealInfo: sl<GetDarvoDealInfo>(),
    );
  });
  sl.registerFactory(() => SynthtargetsBloc(sl<GetSynthTargets>()));
}
