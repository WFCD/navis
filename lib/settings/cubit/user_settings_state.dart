part of 'user_settings_cubit.dart';

sealed class UserSettingsState extends Equatable {
  const UserSettingsState();

  @override
  List<Object> get props => [];
}

final class UserSettingsInitial extends UserSettingsState {}

final class UserSettingsSuccess extends UserSettingsState {
  const UserSettingsSuccess({
    required this.language,
    required this.themeMode,
    required this.platform,
    required this.isOptOut,
    required this.isFirstTime,
    required this.toggles,
  });

  final Locale language;
  final ThemeMode themeMode;
  final GamePlatform platform;
  final bool isOptOut;
  final bool isFirstTime;
  final Map<String, bool> toggles;

  UserSettingsSuccess copyWith({
    Locale? language,
    ThemeMode? themeMode,
    GamePlatform? platform,
    bool? isOptOut,
    bool? isFirstTime,
    Map<String, bool>? toggles,
  }) {
    return UserSettingsSuccess(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      platform: platform ?? this.platform,
      isOptOut: isOptOut ?? this.isOptOut,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      toggles: toggles ?? this.toggles,
    );
  }

  @override
  List<Object> get props =>
      [language, themeMode, platform, isOptOut, isFirstTime, toggles];
}

final class UserSettingsFailure extends UserSettingsState {}
