import 'package:cache/cache.dart';
import 'package:codex/codex.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:warframe_repository/warframe_repository.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class RepositoryBootstrap extends StatelessWidget {
  const RepositoryBootstrap({
    super.key,
    required RouteObserver<ModalRoute<void>> routeObserver,
    required Client client,
    required CacheManager cacheManager,
    required Codex codex,
    required UserSettings settings,
    required this.child,
  }) : _settings = settings,
       _routeObserver = routeObserver,
       _codex = codex,
       _client = client,
       _cacheManager = cacheManager;

  final RouteObserver<ModalRoute<void>> _routeObserver;
  final Client _client;
  final CacheManager _cacheManager;
  final UserSettings _settings;
  final Codex _codex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final language = Language.values.byName(_settings.language.languageCode);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _codex),
        RepositoryProvider.value(value: _settings),
        RepositoryProvider(create: (_) => _routeObserver),
        RepositoryProvider(
          create: (_) => WarframestatRepository(client: _client, manager: _cacheManager)..language = language,
        ),
        RepositoryProvider(
          create: (_) => WarframeRepository(client: _client, manager: _cacheManager),
        ),
        RepositoryProvider(create: (_) => NotificationRepository()),
      ],
      child: child,
    );
  }
}
