part of 'toggle_filters_bloc.dart';

sealed class ToggleFiltersEvent extends Equatable {
  const ToggleFiltersEvent();

  @override
  List<Object?> get props => [];
}

final class ToggleUpdatesSubscriptionRequest extends ToggleFiltersEvent {}

final class ToggleUpdate extends ToggleFiltersEvent {
  const ToggleUpdate({
    required this.enableGiftAlerts,
    required this.enableOperationAlerts,
    required this.enableBaroAlerts,
    required this.enableDarvoAlerts,
    required this.enableSorieAlerts,
    required this.enableArchonAlerts,
    required this.enablePrimeAccess,
    required this.enableStreams,
    required this.enableUpdates,
  });

  final bool? enableGiftAlerts;
  final bool? enableOperationAlerts;
  final bool? enableBaroAlerts;
  final bool? enableDarvoAlerts;
  final bool? enableSorieAlerts;
  final bool? enableArchonAlerts;
  final bool? enablePrimeAccess;
  final bool? enableStreams;
  final bool? enableUpdates;

  @override
  List<Object?> get props => [
    enableGiftAlerts,
    enableOperationAlerts,
    enableBaroAlerts,
    enableDarvoAlerts,
    enableSorieAlerts,
    enableArchonAlerts,
    enablePrimeAccess,
    enableStreams,
    enableUpdates,
  ];
}
