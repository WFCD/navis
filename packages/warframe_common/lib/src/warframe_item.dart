import 'package:warframestat_client/warframestat_client.dart';

class WarframeItem {
  WarframeItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageName,
    required this.category,
    required this.isVaulted,
    required this.isMasterable,
    required this.maxLevel,
    required this.wikiaUrl,
    required this.wikiaThumbnail,
    required this.type,
  });

  factory WarframeItem.fromApi(Map<String, dynamic> map) {
    return WarframeItem(
      uniqueName: map['uniqueName'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      imageName: map['imageName'] as String?,
      category: map['category'] as String,
      isVaulted: map['vaulted'] as bool?,
      isMasterable: map['masterable'] as bool? ?? false,
      maxLevel: map['maxLevelCap'] as int?,
      wikiaUrl: map['wikiaUrl'] as String?,
      wikiaThumbnail: map['wikiaThumbnail'] as String?,
      type: ItemType.byType(map['type'] as String),
    );
  }

  factory WarframeItem.fromDatabase(Map<String, dynamic> map) {
    return WarframeItem(
      uniqueName: map['uniqueName'] as String,
      name: map['name'] as String,
      description: map['description'] as String?,
      imageName: map['imageName'] as String?,
      category: map['category'] as String,
      isVaulted: map['isVaulted'] as bool?,
      isMasterable: map['isMasterable'] as bool? ?? false,
      maxLevel: map['maxLevel'] as int?,
      wikiaUrl: map['wikiaUrl'] as String?,
      wikiaThumbnail: map['wikiaThumbnail'] as String?,
      type: ItemType.byType(map['type'] as String),
    );
  }

  final String uniqueName;
  final String name;
  final String? description;
  final String? imageName;
  final String category;
  final bool? isVaulted;
  final bool isMasterable;
  final int? maxLevel;
  final String? wikiaUrl;
  final String? wikiaThumbnail;
  final ItemType type;

  static const requiredProps = <ItemProps>[
    .uniqueName,
    .name,
    .description,
    .imageName,
    .category,
    .vaulted,
    .masterable,
    .maxLevelCap,
    .wikiaUrl,
    .wikiaThumbnail,
    .type,
  ];

  Map<String, dynamic> toJson() {
    return {
      'uniqueName': uniqueName,
      'name': name,
      'description': description,
      'imageName': imageName,
      'category': category,
      'isVaulted': isVaulted,
      'isMasterable': isMasterable,
      'maxLevel': maxLevel,
      'wikiaUrl': wikiaUrl,
      'wikiaThumbnail': wikiaThumbnail,
      'type': type.type,
    };
  }
}
