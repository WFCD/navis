import 'dart:async';

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
    required this.child,
  });

  final UserSettings settings;
  final Box<Map<dynamic, dynamic>> cache;
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
      cache: widget.cache,
    );

    _notifications.configure();

    Timer.periodic(
      const Duration(minutes: 30),
      (_) => widget.cache.cleanupCache(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.settings),
        RepositoryProvider.value(value: _warframestatRepository),
        RepositoryProvider.value(value: _notifications),
      ],
      child: widget.child,
    );
  }
}
