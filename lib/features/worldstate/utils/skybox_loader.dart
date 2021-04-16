String? getSkybox(String node) {
  const _baseUrl =
      'https://raw.githubusercontent.com/WFCD/navis/master/assets/skyboxes';
  final nodeRegExp = RegExp(r'\(([^)]*)\)');
  final nodeBackground = nodeRegExp.firstMatch(node)?.group(1);

  if (nodeBackground != null)
    return '$_baseUrl/${nodeBackground.replaceAll(' ', '_')}.webp';
  else
    return null;
}
