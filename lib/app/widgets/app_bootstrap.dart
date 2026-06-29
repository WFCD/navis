import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:item_repository/items_repository.dart';
import 'package:navis/profile/profile.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:profile_repository/profile_repository.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class AppBootstrap extends StatelessWidget {
  const AppBootstrap({
    super.key,
    required this._routeObserver,
    required this._settings,
    required this._notificationRepository,
    required this._itemsRepository,
    required this._worldstateRepository,
    required this._profileRepository,
    required this.child,
  });

  final RouteObserver<ModalRoute<void>> _routeObserver;
  final UserSettings _settings;
  final NotificationRepository _notificationRepository;
  final ItemsRepository _itemsRepository;
  final WorldstateRepository _worldstateRepository;
  final ProfileRepository _profileRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _routeObserver),
        RepositoryProvider.value(value: _settings),
        RepositoryProvider.value(value: _notificationRepository),
        RepositoryProvider.value(value: _itemsRepository),
        RepositoryProvider.value(value: _worldstateRepository),
        RepositoryProvider.value(value: _profileRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => UserSettingsCubit(_settings)),
          BlocProvider(create: (_) => ProfileCubit(_profileRepository, _settings)..refreshProfile()),
        ],
        child: child,
      ),
    );
  }
}
