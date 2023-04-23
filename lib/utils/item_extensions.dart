import 'package:warframestat_client/warframestat_client.dart';

const _baseUrl = 'https://cdn.warframestat.us';
const _opts = 'o_webp,progressive_false';

extension ItemX on Item {
  String get imageUrl {
    final uriEncoded = Uri.encodeFull('$_baseUrl/img/$imageName');

    return '$_baseUrl/$_opts/$uriEncoded';
  }
}

extension PatchlogX on Patchlog {
  String get imageUrl {
    final uriEncoded = Uri.encodeFull(imgUrl ?? '');

    return '$_baseUrl/$_opts/$uriEncoded';
  }
}
