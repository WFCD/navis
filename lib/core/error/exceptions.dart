import 'package:navis/core/error/failures.dart';

class ServerException implements Exception {}

class CacheException implements Exception {}

class UnknownException implements Exception {}

T matchFailure<T>(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      throw ServerException();
    case CacheException:
      throw CacheException();
    default:
      throw UnknownException();
  }
}
