import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_repository/market_repository.dart';
import 'package:notification_repository/notification_repository.dart';
import 'package:worldstate_repository/worldstate_repository.dart';

class DependenciesProvider extends StatelessWidget {
  const DependenciesProvider({
    super.key,
    required this.notifications,
    required this.worldstateRepository,
    required this.marketRepository,
    required this.child,
  });

  final NotificationRepository notifications;

  final WorldstateRepository worldstateRepository;

  final MarketRepository marketRepository;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: notifications),
        RepositoryProvider.value(value: worldstateRepository),
        RepositoryProvider.value(value: marketRepository),
      ],
      child: child,
    );
  }
}
