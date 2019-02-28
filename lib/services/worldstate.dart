import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';
import 'package:navis/models/export.dart';
import 'package:http/http.dart' as http;

class WorldstateAPI {
  final String _baseRoute = 'https://api.warframestat.us/';

  Future<WorldState> updateState(http.Client client, {String platform}) async {
    final response = await client.get(_baseRoute + platform);

    if (response.statusCode != 200) throw Exception('error loading state');

    final data = json.decode(response.body);

    final key = KeyedArchive.unarchive(data);
    final WorldState state = WorldState()..decode(key);

    return state;
  }
}
