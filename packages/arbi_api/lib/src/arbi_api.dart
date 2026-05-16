// ignore_for_file: experimental_member_use why not

import 'package:arbi_api/src/utils/parse_arbis.dart';
import 'package:http/http.dart';
import 'package:warframestat_client/warframestat_client.dart';

/// {@template arbi_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ArbiApi {
  /// {@macro arbi_api}
  const ArbiApi(Client client) : _client = client;

  final Client _client;

  Future<List<Arbitration>> fetchArbis() async {
    final res = await _client.get(Uri.parse('https://browse.wf/arbys.txt'));
    final csv = res.body;

    return parseArbitrations(csv).toList();
  }
}
