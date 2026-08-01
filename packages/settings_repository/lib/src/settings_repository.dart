import 'package:settings_repository/src/settings_keys.dart';
import 'package:storage/storage.dart';

/// {@template settings_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SettingsRepository {
  /// {@macro settings_repository}
  const SettingsRepository(this._settings);

  final Storage<dynamic> _settings;

  String? get accountId => _settings.read(SettingsKeys.accountId) as String?;
  set accountId(String id) => _settings.write(SettingsKeys.accountId, id);

  String get locale => _settings.read(SettingsKeys.locale) as String? ?? 'en';
  set locale(String locale) => _settings.write(SettingsKeys.locale, locale);

  int get theme => _settings.read(SettingsKeys.theme) as int? ?? 0;
  set theme(int value) => _settings.write(SettingsKeys.theme, value);

  bool get firstRun => _settings.read(SettingsKeys.firstRun) as bool? ?? true;
  set firstRun(bool value) => _settings.write(SettingsKeys.firstRun, value);

  int? get platform => _settings.read(SettingsKeys.platformKey) as int?;
  set platform(int value) => _settings.write(SettingsKeys.platformKey, value);
}
