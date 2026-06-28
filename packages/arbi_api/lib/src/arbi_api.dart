// ignore_for_file: experimental_member_use why not

import 'package:http/http.dart';


/// {@template arbi_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class ArbiApi {
  /// {@macro arbi_api}
  const ArbiApi(Client client) : _client = client;

  final Client _client;

  Future<String> fetchArbis() async {
    final res = await _client.get(Uri.parse('https://browse.wf/arbys.txt'));
    return res.body;
  }
}
