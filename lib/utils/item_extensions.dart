import 'package:warframestat_client/warframestat_client.dart';

extension ItemX on Item {
  String get imageUrl => _imageUrl(imageName);
}

extension PatchlogX on Patchlog {
  String get imageUrl => _imageUrl(imgUrl);
}

String _imageUrl(String? imageName) {
  const baseUrl = 'https://cdn.warframestat.us';
  const opts = 'o_webp,progressive_false';
  final uriEncoded = Uri.encodeFull('$baseUrl/img/$imageName');

  return '$baseUrl/$opts/$uriEncoded';
}
