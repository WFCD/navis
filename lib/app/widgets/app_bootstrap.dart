import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/items/cubit/item_update_cubit.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/settings/settings.dart';
import 'package:navis/worldstate/bloc/worldstate_bloc.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:settings_repository/settings_repository.dart';
import 'package:warframe_drop_repository/warframe_drop_repository.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({
    super.key,
    required this._routeObserver,
    required this._settingsRepository,
    required this._notificationRepository,
    required this._itemsRepository,
    required this._worldstateRepository,
    required this._profileRepository,
    required this._warframeDropRepository,
    required this.child,
  });

  final RouteObserver<ModalRoute<void>> _routeObserver;
  final SettingsRepository _settingsRepository;
  final NotificationRepository _notificationRepository;
  final ItemsRepository _itemsRepository;
  final WorldstateRepository _worldstateRepository;
  final ProfileRepository _profileRepository;
  final WarframeDropRepository _warframeDropRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _routeObserver),
        RepositoryProvider.value(value: _settingsRepository),
        RepositoryProvider.value(value: _notificationRepository),
        RepositoryProvider.value(value: _itemsRepository),
        RepositoryProvider.value(value: _worldstateRepository),
        RepositoryProvider.value(value: _profileRepository),
        RepositoryProvider.value(value: _warframeDropRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => SettingsCubit(_settingsRepository)),
          BlocProvider(create: (_) => ProfileCubit(_profileRepository, _settingsRepository)..refreshProfile()),
          BlocProvider(create: (_) => WorldstateBloc(_settingsRepository.locale, _worldstateRepository)),
          BlocProvider(create: (_) => ItemUpdateCubit(_itemsRepository)),
        ],
        child: child,
      ),
    );
  }
}
