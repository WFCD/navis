part of 'toggle_filters_bloc.dart';

sealed class ToggleFiltersState extends Equatable {
  const ToggleFiltersState();

  @override
  List<Object?> get props => [];
}

final class ToggleFiltersInitial extends ToggleFiltersState {}

final class ToggleUpdated extends ToggleFiltersState {
  const ToggleUpdated({
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
