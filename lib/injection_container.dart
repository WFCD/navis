import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:package_info/package_info.dart';
import 'package:wfcd_client/wfcd_client.dart';

import 'core/cubits/navigation_cubit.dart';
import 'core/local/user_settings.dart';
import 'core/network/network_info.dart';
import 'core/notifiers/user_settings_notifier.dart';
import 'core/services/notifications.dart';
import 'core/services/videos.dart';
import 'features/codex/data/repositories/codex_repository_impl.dart';
import 'features/codex/domian/repositories/codex_repository.dart';
import 'features/codex/domian/usercases/search_items.dart';
import 'features/codex/presentation/bloc/search_bloc.dart';
import 'features/synthtargets/data/repositories/synth_target_rep_impl.dart';
import 'features/synthtargets/domain/repositories/synth_target_repository.dart';
import 'features/synthtargets/domain/usecases/get_synth_targets.dart';
import 'features/synthtargets/presentation/bloc/synthtargets_bloc.dart';
import 'features/worldstate/data/datasources/event_info_parser.dart';
import 'features/worldstate/data/datasources/warframestate_local.dart';
import 'features/worldstate/data/repositories/worldstate_rep_impl.dart';
import 'features/worldstate/domain/repositories/worldstate_repository.dart';
import 'features/worldstate/domain/usecases/get_darvo_deal_info.dart';
import 'features/worldstate/domain/usecases/get_worldstate.dart';
import 'features/worldstate/presentation/bloc/darvodeal_bloc.dart';
import 'features/worldstate/presentation/bloc/solsystem_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl
    ..registerSingleton<NetworkInfo>(
        NetworkInfoImpl(InternetConnectionChecker()))
    ..registerSingletonAsync<EventInfoParser>(EventInfoParser.loadEventData)
    ..registerSingleton<VideoService>(VideoService())
    ..registerSingletonAsync<PackageInfo>(PackageInfo.fromPlatform)
    ..registerSingleton<NotificationService>(NotificationService())

    // Data sources
    ..registerSingleton<WarframestatClient>(WarframestatClient())
    ..registerSingletonAsync(Usersettings.initUsersettings)
    ..registerSingletonAsync<WarframestatCache>(WarframestatCache.initCache);

  await sl.isReady<WarframestatCache>();
  await sl.isReady<Usersettings>();

  // Repository
  sl
    ..registerSingleton<UserSettingsNotifier>(UserSettingsNotifier(
      sl<Usersettings>(),
    ))
    ..registerSingleton<WorldstateRepository>(
      WorldstateRepositoryImpl(
        sl<NetworkInfo>(),
        sl<WarframestatCache>(),
        sl<Usersettings>(),
      ),
    )
    ..registerSingleton<SynthRepository>(SynthRepositoryImpl(sl<NetworkInfo>()))
    ..registerSingleton<CodexRepository>(CodexRepositoryImpl(sl<NetworkInfo>()))

    // Usecases
    ..registerSingleton<GetWorldstate>(
        GetWorldstate(sl<WorldstateRepository>()))
    ..registerSingleton<GetDarvoDealInfo>(
        GetDarvoDealInfo(sl<WorldstateRepository>()))
    ..registerSingleton<GetSynthTargets>(GetSynthTargets(sl<SynthRepository>()))
    ..registerSingleton<SearchItems>(SearchItems(sl<CodexRepository>()))

    // Blocs
    ..registerFactory<NavigationCubit>(() => NavigationCubit())
    ..registerFactory<SolsystemBloc>(() {
      return SolsystemBloc(getWorldstate: sl<GetWorldstate>());
    })
    ..registerFactory<DarvodealBloc>(() {
      return DarvodealBloc(getDarvoDealInfo: sl<GetDarvoDealInfo>());
    })
    ..registerFactory(() => SynthtargetsBloc(sl<GetSynthTargets>()))
    ..registerFactory<SearchBloc>(() => SearchBloc(sl<SearchItems>()));
}
