const _baseUrl = 'https://cdn.warframestat.us';
const _gitAssets = 'https://raw.githubusercontent.com/WFCD/genesis-assets/master';
const _opts = 'o_webp,progressive_true';
const _defaultImage = 'https://raw.githubusercontent.com/WFCD/genesis-assets/master/img/menu/LotusEmblem.png';

extension CdnExtensions on String? {
  String optimize({int width = 60, required double pixelRatio}) {
    final opts = 'rs_${(width * pixelRatio).round()},$_opts';
    return Uri.encodeFull('$_baseUrl/$opts/${this ?? _defaultImage}');
  }

  String warframeItemsCdn() {
    return Uri.encodeFull('$_baseUrl/img/${this ?? _defaultImage}');
  }

  String genesisCdn() {
    return Uri.encodeFull('$_baseUrl/genesis/${this ?? _defaultImage}');
  }

  /// See https://github.com/Baseflow/flutter_cached_network_image/issues/494
  String genesisGitCdn() {
    return Uri.encodeFull('$_gitAssets/${this ?? _defaultImage}');
  }
}
