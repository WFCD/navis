part of 'app_config_bloc.dart';

sealed class AppConfigEvent extends Equatable {
  const AppConfigEvent();

  @override
  List<Object?> get props => [];
}

final class AppConfigSubscriptionRequested extends AppConfigEvent {}

final class AppConfigUpdate extends AppConfigEvent {
  const AppConfigUpdate({this.language, this.theme, this.optOut, this.account});

  final String? language;
  final ThemeMode? theme;
  final bool? optOut;
  final String? account;

  @override
  List<Object?> get props => [language, theme, optOut, account];
}
