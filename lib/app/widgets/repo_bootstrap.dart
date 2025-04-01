import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:inventoria/inventoria.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class RepositoryBootstrap extends StatelessWidget {
  const RepositoryBootstrap({
    super.key,
    required UserSettings settings,
    required RouteObserver<ModalRoute<void>> routeObserver,
    required Client client,
    required this.child,
  }) : _settings = settings,
       _routeObserver = routeObserver,
       _client = client;

  final UserSettings _settings;
  final RouteObserver<ModalRoute<void>> _routeObserver;
  final Client _client;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final language = Language.values.byName(_settings.language.languageCode);

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _settings),
        RepositoryProvider(create: (_) => WarframestatRepository(client: _client)..language = language),
        RepositoryProvider(create: (_) => NotificationRepository()),
        RepositoryProvider(create: (_) => _routeObserver),
        RepositoryProvider(create: (_) => Inventoria(client: _client)),
      ],
      child: child,
    );
  }
}
