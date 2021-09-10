String? getSkybox(String node) {
  const caravaggio = 'https://cdn.warframestat.us/rs_512x512';
  const baseUrl = 'https://cdn.warframestat.us/genesis/skyboxes';
  final nodeRegExp = RegExp(r'\(([^)]*)\)');
  final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

  if (nodeBackground != null) {
    return Uri.parse(
            '$caravaggio/$baseUrl/${nodeBackground.replaceAll(' ', '_')}.webp')
        .toString();
  } else {
    return null;
  }
}
