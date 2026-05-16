abstract class CacheKeys {
  static const dropData = 'drop_data';
  static const worldstate = 'worldstate';
  static const profile = 'profile';
  static const arbitrations = 'arbitrations';
}

abstract class CacheTime {
  static const dropDataRefresh = Duration(days: 30);
  static const worldstateRefreshTime = Duration(seconds: Duration.secondsPerMinute * 3);
  static const profileRefreshTime = Duration(hours: 1);
  static const itemRefreshTime = Duration(days: DateTime.daysPerWeek);
}
