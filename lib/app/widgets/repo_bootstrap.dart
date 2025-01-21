import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

class RepositoryBootstrap extends StatefulWidget {
  const RepositoryBootstrap({
    super.key,
    required this.settings,
    required this.cache,
    required this.routeObserver,
    required this.child,
  });

  final UserSettings settings;
  final Box<CachedItem> cache;
  final RouteObserver<ModalRoute<void>> routeObserver;
  final Widget child;

  @override
  State<RepositoryBootstrap> createState() => _RepositoryBootstrapState();
}

class _RepositoryBootstrapState extends State<RepositoryBootstrap> {
  late NotificationRepository _notifications;
  late WarframestatRepository _warframestatRepository;

  @override
  void initState() {
    super.initState();

    _notifications = NotificationRepository();
    _warframestatRepository = WarframestatRepository(
      client: SentryHttpClient(),
      database: ArsenalDatabase(driftDatabase(name: 'arsenal')),
    )..updateArsenalItems();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.settings),
        RepositoryProvider.value(value: _warframestatRepository),
        RepositoryProvider.value(value: _notifications),
        RepositoryProvider.value(value: widget.routeObserver),
      ],
      child: widget.child,
    );
  }
}
