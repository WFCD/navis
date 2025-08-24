import 'package:json_annotation/json_annotation.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'search_item.g.dart';

@JsonSerializable()
class SearchItem extends Item {
  const SearchItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageName,
    required this.type,
    required this.category,
    this.vaulted,
    this.wikiaUrl,
    this.wikiaThumbnail,
  });

  factory SearchItem.fromJson(Map<String, dynamic> json) => _$SearchItemFromJson(json);

  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
  final String category;

  @ItemTypeConverter()
  final ItemType type;

  final bool? vaulted;

  final String? wikiaUrl;

  final String? wikiaThumbnail;

  Map<String, dynamic> toJson() => _$SearchItemToJson(this);

  Misc toMisc() {
    return Misc(
      uniqueName: uniqueName,
      name: name,
      description: description,
      type: type,
      category: category,
      productCategory: '',
      imageName: imageName,
      tradable: false,
      patchlogs: const [],
      releaseDate: '',
      excludeFromCodex: false,
      wikiaThumbnail: wikiaThumbnail,
      wikiaUrl: wikiaUrl,
    );
  }

  @override
  List<Object?> get props => [
    uniqueName,
    name,
    description,
    imageName,
    type,
    category,
    vaulted,
    wikiaUrl,
    wikiaThumbnail,
  ];
}
