/// {@template server_exception}
/// Exception thrown when the server returns an error or an empty state.
/// {@endtemplate}
class ServerException implements Exception {
  /// {@macro server_exception}
  const ServerException(this.message);

  /// Exception message.
  final String message;
}

/// {@template 404}
/// Exception thrown when an item wasn't found for a daily deal.
/// {@endtemplate}
class ItemNotFoundException implements Exception {
  /// {@macro 404}
  const ItemNotFoundException(this.name);

  /// Name of the item.
  final String name;
}
