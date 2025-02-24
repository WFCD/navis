const _baseUrl = 'https://cdn.warframestat.us';
const _gitAssets = 'https://raw.githubusercontent.com/WFCD/genesis-assets/master';
const _opts = 'o_webp,progressive_true';

extension StringX on String {
  String optimize() {
    return Uri.encodeFull('$_baseUrl/$_opts/$this');
  }

  String warframeItemsCdn() {
    return Uri.encodeFull('$_baseUrl/img/$this');
  }

  String genesisCdn() {
    return Uri.encodeFull('$_baseUrl/genesis/$this');
  }

  /// See https://github.com/Baseflow/flutter_cached_network_image/issues/494
  String genesisGitCdn() {
    return Uri.encodeFull('$_gitAssets/$this');
  }
}
