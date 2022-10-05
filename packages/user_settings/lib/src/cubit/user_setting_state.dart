// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'user_setting_cubit.dart';

typedef GetToggle = bool Function(String key);

typedef SetToggle = void Function(String key, bool value);

class UserSettingsState extends Equatable {
  UserSettingsState({
    this.language = const Locale('en'),
    this.platform = GamePlatforms.pc,
    this.theme = ThemeMode.system,
    this.isOptOut = false,
    this.isFirstTime = true,
    required this.getToggle,
    required this.setToggle,
  });

  final Locale language;

  final GamePlatforms platform;

  final ThemeMode theme;

  final bool isOptOut;

  final bool isFirstTime;

  final GetToggle getToggle;

  final SetToggle setToggle;

  UserSettingsState copyWith({
    Locale? language,
    GamePlatforms? platform,
    ThemeMode? theme,
    bool? isOptOut,
    bool? isFirstTime,
    GetToggle? getToggle,
    SetToggle? setToggle,
  }) {
    return UserSettingsState(
      language: language ?? this.language,
      platform: platform ?? this.platform,
      theme: theme ?? this.theme,
      isOptOut: isOptOut ?? this.isOptOut,
      isFirstTime: isFirstTime ?? this.isFirstTime,
      getToggle: getToggle ?? this.getToggle,
      setToggle: setToggle ?? this.setToggle,
    );
  }

  @override
  List<Object?> get props =>
      [language, platform, theme, isOptOut, isFirstTime, getToggle, setToggle];
}
