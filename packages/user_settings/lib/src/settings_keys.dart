/// Stores constant values for UserSettings keys stored in the UserSetting hive
/// box.
class SettingsKeys {
  /// The key where the setting for app first launch is stored.
  static const String isFirstTime = 'firstTime';

  /// The key where user's language is stored as a String.
  static const String userLanguage = 'language';

  /// The key where the user's set GamePlatform is stored as a String.
  static const String platformKey = 'platform';

  /// The key where the user's set ThemeMode is stored as a String.
  static const String theme = 'theme';

  /// The key where the user's set preference on using the back key is stored
  /// as a bool.
  static const String backKey = 'back_key';
}
