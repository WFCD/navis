import 'dart:async';
import 'dart:convert';

import 'package:codable/codable.dart';

import 'package:navis/models/export.dart';
import 'package:http/http.dart' as http;
import 'package:navis/utils/enums.dart';
import 'package:navis/utils/worldstate_utils.dart';

class WorldstateAPI {
  static const String _baseRoute = 'https://api.warframestat.us/';

  Future<WorldState> getWorldstate(Platforms platform,
      {http.Client client}) async {
    client ??= http.Client();
    platform ??= Platforms.pc;

    final response =
        await client.get(_baseRoute + platform.toString().split('.').last);

    if (response.statusCode != 200)
      throw Exception('Error connecting: ${response.statusCode}');

    final data = json.decode(response.body);

    final key = KeyedArchive.unarchive(data);
    final WorldState state = WorldState()..decode(key);

    cleanState(state);
    return state;
  }
}
