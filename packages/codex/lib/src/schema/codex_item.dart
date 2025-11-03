import 'package:codex/src/schema/masterable_item.dart';
import 'package:codex/src/utils.dart';
import 'package:isar_community/isar.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'codex_item.g.dart';

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

@Collection(ignore: {'props', 'toJson', 'stringify'})
@JsonSerializable()
class CodexItem extends Item {
  CodexItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageName,
    required this.category,
    required this.type,
    this.vaulted = false,
    this.masterable = false,
    required this.maxLevelCap,
    required this.wikiaUrl,
    required this.wikiaThumbnail,
  });

  factory CodexItem.fromJson(Map<String, dynamic> json) => _$CodexItemFromJson(json);

  @Index(type: IndexType.value, unique: true, replace: true)
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
  @Enumerated(EnumType.name)
  final ItemType type;

  @Backlink(to: 'item')
  final xpInfo = IsarLink<MasterableItem>();

  Id get isarId => fastHash(uniqueName);

  Map<String, dynamic> toJson() => _$CodexItemToJson(this);

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
