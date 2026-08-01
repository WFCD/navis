part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.language,
    required this.themeMode,
    required this.isFirstTime,
    this.isOptOut = false,
    this.notifications = const <String, bool>{},
  });

  final Locale language;
  final ThemeMode themeMode;
  final bool isFirstTime;
  final bool isOptOut;
  final Map<String, bool> notifications;

  SettingsState copyWith({
    String? username,
    Locale? language,
    ThemeMode? themeMode,
    bool? isFirstTime,
    bool? isOptOut,
    Map<String, bool>? notifications,
  }) {
    return SettingsState(
      language: language ?? this.language,
      themeMode: themeMode ?? this.themeMode,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      isOptOut: isOptOut ?? this.isOptOut,
      notifications: {...this.notifications, ...?notifications},
    );
  }

  @override
  List<Object> get props => [language, themeMode, isOptOut, isFirstTime, notifications];

  @override
  String toString() =>
      'UserSettingsSucccess(locale: $language theme: $themeMode isfirstRun: $isFirstTime isOptOut: $isOptOut, notifications: $notifications)';
}
