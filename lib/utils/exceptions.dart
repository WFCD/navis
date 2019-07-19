class AppException implements Exception {
  const AppException({this.prefix, this.message});

  final String prefix;
  final String message;

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppException {
  FetchDataException([String message])
      : super(prefix: 'Error During Communication: ', message: message);
}

class BadRequestException extends AppException {
  BadRequestException([message])
      : super(prefix: 'Invalid Request: ', message: message);
}

class UnauthorisedException extends AppException {
  UnauthorisedException([message])
      : super(prefix: 'Unauthorised: ', message: message);
}

class InvalidInputException extends AppException {
  InvalidInputException([String message])
      : super(prefix: 'Invalid Input: ', message: message);
}
