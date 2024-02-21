import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navis/settings/settings.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class RepositoryBootstrap extends StatefulWidget {
  const RepositoryBootstrap({
    super.key,
    required this.settings,
    required this.warframestatCache,
    required this.child,
  });

  final UserSettings settings;
  final WarframestatCache warframestatCache;
  final Widget child;

  @override
  State<RepositoryBootstrap> createState() => _RepositoryBootstrapState();
}

class _RepositoryBootstrapState extends State<RepositoryBootstrap> {
  late NotificationRepository _notifications;
  late WorldstateRepository _worldstateRepository;

  @override
  void initState() {
    super.initState();

    _notifications = NotificationRepository();
    _worldstateRepository = WorldstateRepository(
      client: SentryHttpClient(),
      cache: widget.warframestatCache,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.settings),
        RepositoryProvider.value(value: _worldstateRepository),
        RepositoryProvider.value(value: _notifications),
      ],
      child: widget.child,
    );
  }
}
