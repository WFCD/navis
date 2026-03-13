import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis_codex/navis_codex.dart';
import 'package:navis_settings/navis_settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:warframe_repository/warframe_repository.dart';

class RepositoryBootstrap extends StatelessWidget {
  const RepositoryBootstrap({
    super.key,
    required RouteObserver<ModalRoute<void>> routeObserver,
    required CodexDatabase codex,
    required SettingsDatabase settings,
    required WarframeRepository warframeRepository,
    required this.child,
  }) : _settings = settings,
       _routeObserver = routeObserver,
       _codex = codex,
       _warframeRepository = warframeRepository;

  final RouteObserver<ModalRoute<void>> _routeObserver;
  final SettingsDatabase _settings;
  final CodexDatabase _codex;
  final WarframeRepository _warframeRepository;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _codex),
        RepositoryProvider.value(value: _settings),
        RepositoryProvider.value(value: _routeObserver),
        RepositoryProvider.value(value: _warframeRepository),
        RepositoryProvider(create: (_) => NotificationRepository()),
      ],
      child: child,
    );
  }
}
