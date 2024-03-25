const _baseUrl = 'https://cdn.warframestat.us';
const _opts = 'o_webp,progressive_false';

extension StringX on String {
  Uri proxyImage() {
    return Uri.parse(Uri.encodeFull('$_baseUrl/$_opts/$this'));
  }

  Uri genesisCdn() {
    return Uri.parse(Uri.encodeFull('$_baseUrl/img/$this'));
  }
}
