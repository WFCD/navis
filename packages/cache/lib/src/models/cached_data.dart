/// {@template cached_data}
/// Represents the data being cached
/// {@endtemplate}
class CachedData {
  /// {@macro cached_data}
  CachedData({required this.data, required this.cachedAt, required this.ttl});

  /// {@macro cached_data}
  factory CachedData.create(String data, {required Duration ttl}) {
    return CachedData(data: data, cachedAt: DateTime.timestamp(), ttl: ttl);
  }

  /// Data being stored
  final String data;

  /// Timestamp of when it was cached at
  final DateTime cachedAt;

  /// How long before it's considered expired
  final Duration ttl;

  /// Whether or not the data is expired
  bool get isExpired => DateTime.timestamp().difference(cachedAt) > ttl || ttl == Duration.zero;
}
