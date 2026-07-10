part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsSuccess extends SettingsState {
  const SettingsSuccess({
    required this.language,
    required this.themeMode,
    required this.isFirstTime,
    this.isOptOut = false,
  });

  final Locale language;
  final ThemeMode themeMode;
  final bool isFirstTime;
  final bool isOptOut;

  SettingsSuccess copyWith({
    String? username,
    Locale? language,
    ThemeMode? themeMode,
    bool? isFirstTime,
    bool? isOptOut,
  }) {
    return SettingsSuccess(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isOptOut: isOptOut ?? this.isOptOut,
    );
  }

  @override
  List<Object?> get props => [language, themeMode, isFirstTime];

  @override
  String toString() =>
      'UserSettingsSucccess(locale: $language theme: $themeMode isfirstRun: $isFirstTime isOptOut: $isOptOut)';
}

final class SettingsFailure extends SettingsState {}
