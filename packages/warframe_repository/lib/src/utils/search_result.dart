import 'package:navis_codex/navis_codex.dart';
import 'package:warframestat_client/warframestat_client.dart';

class SearchResult {
  SearchResult({required this.uniqueName, required this.name, required this.description, required this.imageName});

  factory SearchResult.fromItem(ItemCommon item) {
    return SearchResult(
      uniqueName: item.uniqueName,
      name: item.name,
      description: item.description,
      imageName: item.imageName,
    );
  }

  factory SearchResult.fromCodexItem(CodexItem item) {
    return SearchResult(
      uniqueName: item.uniqueName,
      name: item.name,
      description: item.description,
      imageName: item.imageName,
    );
  }

  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
}
