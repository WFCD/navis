import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:navis/utils/exceptions.dart';

class ApiBaseHelper {
  const ApiBaseHelper();

  static const String _baseUrl = 'https://api.warframestat.us';

  Future<dynamic> get(String path, [String base]) async {
    try {
      final response = await http.get(base ?? _baseUrl + path);
      return _returnResponse(response);
    } on SocketException {
      throw Exception();
    }
  }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body);
      case 403:
        throw UnauthorisedException(response.body);
      default:
        throw FetchDataException(
            'Error occured while communicating with Server. StatusCode: ${response.statusCode}');
    }
  }
}
