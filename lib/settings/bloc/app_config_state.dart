part of 'app_config_bloc.dart';

sealed class AppConfigState extends Equatable {
  const AppConfigState();

  @override
  List<Object> get props => [];
}

final class AppConfigInitial extends AppConfigState {}

final class AppConfigUpdated extends AppConfigState {
  const AppConfigUpdated({required this.config});

  final AppConfig config;

  @override
  List<Object> get props => [config];
}
