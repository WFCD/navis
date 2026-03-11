// ignore_for_file: public_member_api_docs For documentation just see ItemCommon

import 'package:json_annotation/json_annotation.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'warframe_item.g.dart';

/// Required props to tell the warframe-items to include
const List<ItemProps> codexProps = [
  ItemProps.uniqueName,
  ItemProps.name,
  ItemProps.description,
  ItemProps.imageName,
  ItemProps.type,
  ItemProps.category,
  ItemProps.vaulted,
  ItemProps.masterable,
  ItemProps.maxLevelCap,
  ItemProps.wikiaUrl,
  ItemProps.wikiaThumbnail,
];

@JsonSerializable()
class WarframeItem extends Item {
  const WarframeItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageName,
    required this.category,
    required this.type,
    required this.maxLevelCap,
    required this.wikiaUrl,
    required this.wikiaThumbnail,
    this.vaulted = false,
    this.masterable = false,
  });

  factory WarframeItem.fromJson(Map<String, dynamic> json) => _$WarframeItemFromJson(json);

  final String uniqueName;

  final String name;

  final String? description;

  final String? imageName;

  final String category;

  final bool vaulted;

  final bool masterable;

  final int? maxLevelCap;

  final String? wikiaUrl;

  final String? wikiaThumbnail;

  @ItemTypeConverter()
  final ItemType type;

  Map<String, dynamic> toJson() => _$WarframeItemToJson(this);

  @override
  List<Object?> get props => [
    uniqueName,
    name,
    description,
    imageName,
    type,
    category,
    vaulted,
    masterable,
    maxLevelCap,
    wikiaUrl,
    wikiaThumbnail,
  ];
}
