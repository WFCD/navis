import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart';
import 'package:warframe_api/src/enum.dart';
import 'package:warframe_api/src/exceptions.dart';

const _worldstateApi = 'https://api.warframe.com/cdn/worldState.php';
const _dropPage =
    'https://warframe-web-assets.nyc3.cdn.digitaloceanspaces.com/uploads/cms/hnfvc0o3jnfvc873njb03enrf56.html';

/// {@template warframe_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class WarframeApi {
  /// {@macro warframe_api}
  const WarframeApi(Client client) : _client = client;

  final Client _client;

  Future<Map<String, dynamic>> fetchWorldstate() async {
    final body = await fetchWorldstateBytes();
    return utf8.decoder.fuse(json.decoder).convert(body)! as Map<String, dynamic>;
  }

  Future<Uint8List> fetchWorldstateBytes() async {
    final res = await _client.get(Uri.parse(_worldstateApi));
    return res.bodyBytes;
  }

  Future<String> fetchDropData() async {
    final res = await _client.get(Uri.parse(_dropPage));
    return utf8.decode(res.bodyBytes);
  }

  Future<Map<String, dynamic>> fetchProfile(WarframeSupportedPlatform platform, String id) async {
    final body = await fetchProfileBytes(platform, id);
    return utf8.decoder.fuse(json.decoder).convert(body)! as Map<String, dynamic>;
  }

  Future<Uint8List> fetchProfileBytes(WarframeSupportedPlatform platform, String id) async {
    final apiSub = 'api${platform == .pc ? '' : '-${platform.name}'}';
    final uri = Uri.https('$apiSub.warframe.com', '/cdn/getProfileViewingData.php', {'playerId': id});
    final res = await _client.get(uri);
    if (res.statusCode == HttpStatus.notFound || res.statusCode == HttpStatus.conflict) {
      throw ProfileNotFound(res.body);
    }

    return res.bodyBytes;
  }
}
