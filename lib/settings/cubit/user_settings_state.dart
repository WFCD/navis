part of 'user_settings_cubit.dart';

sealed class UserSettingsState extends Equatable {
  const UserSettingsState();

  @override
  List<Object?> get props => [];
}

final class UserSettingsInitial extends UserSettingsState {}

final class UserSettingsSuccess extends UserSettingsState {
  const UserSettingsSuccess({
    required this.username,
    required this.language,
    required this.themeMode,
    required this.isOptOut,
    required this.isFirstTime,
    required this.toggles,
  });

  final String? username;
  final Locale language;
  final ThemeMode themeMode;
  final bool isOptOut;
  final bool isFirstTime;
  final Map<String, bool> toggles;

  UserSettingsSuccess copyWith({
    String? username,
    Locale? language,
    ThemeMode? themeMode,
    bool? isOptOut,
    bool? isFirstTime,
    Map<String, bool>? toggles,
  }) {
    return UserSettingsSuccess(
      username: username ?? this.username,
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      isOptOut: isOptOut ?? this.isOptOut,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      toggles: toggles ?? this.toggles,
    );
  }

  @override
  List<Object?> get props =>
      [language, themeMode, isOptOut, isFirstTime, toggles, username];
}

final class UserSettingsFailure extends UserSettingsState {}
