import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:warframe_api/src/exceptions.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
const _profileApi = 'https://api.warframe.com/cdn/getProfileViewingData.php';
const _dropPage =
    'https://warframe-web-assets.nyc3.cdn.digitaloceanspaces.com/uploads/cms/hnfvc0o3jnfvc873njb03enrf56.html';

/// {@template warframe_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeApi {
  /// {@macro warframe_api}
  const WarframeApi({required Client client}) : _client = client;

  final Client _client;

  Future<Map<String, dynamic>> fetchWorldstate([String locale = 'en']) async {
    final body = await fetchWorldstateBytes(locale);
    return utf8.decoder.fuse(json.decoder).convert(body)! as Map<String, dynamic>;
  }

  Future<Uint8List> fetchWorldstateBytes([String locale = 'en']) async {
    final res = await _client.get(Uri.parse(_worldstateApi));
    return res.bodyBytes;
  }

  Future<String> fetchDropData() async {
    final res = await _client.get(Uri.parse(_dropPage));
    return utf8.decode(res.bodyBytes);
  }

  Future<Map<String, dynamic>> fetchProfile(String id) async {
    final body = await fetchProfileBytes(id);
    return utf8.decoder.fuse(json.decoder).convert(body)! as Map<String, dynamic>;
  }

  Future<Uint8List> fetchProfileBytes(String id) async {
    final res = await _client.get(Uri.parse('$_profileApi?playerId=$id'));
    if (res.statusCode == HttpStatus.notFound || res.statusCode == HttpStatus.conflict) {
      throw ProfileNotFound(res.body);
    }

    return res.bodyBytes;
  }
}
