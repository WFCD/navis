/// {@template cached_data}
/// Represents the data being cached
/// {@endtemplate}
class CachedData {
  /// {@macro cached_data}
  CachedData({required this.data, Duration? ttl, DateTime? cachedAt})
    : cachedAt = cachedAt ?? DateTime.timestamp(),
      ttl = ttl ?? Duration.zero;

  factory CachedData.fromJson(Map<String, dynamic> json) {
    return CachedData(
      data: json['data'] as String,
      ttl: Duration(seconds: json['ttl'] as int),
      cachedAt: DateTime.fromMillisecondsSinceEpoch(json['cachedAt'] as int),
    );
  }

  /// Data being stored
  final String data;

  /// Timestamp of when it was cached at
  final DateTime cachedAt;

  /// How long before it's considered expired
  final Duration ttl;

  /// Whether or not the data is expired
  bool get isExpired => DateTime.timestamp().difference(cachedAt) > ttl || ttl == Duration.zero;

  Map<String, dynamic> toJson() {
    return {'data': data, 'cachedAt': cachedAt.millisecondsSinceEpoch, 'ttl': ttl.inSeconds};
  }
}
