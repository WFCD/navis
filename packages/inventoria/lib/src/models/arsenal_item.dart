import 'package:json_annotation/json_annotation.dart';
import 'package:warframestat_client/warframestat_client.dart';

part 'arsenal_item.g.dart';

@JsonSerializable()
class ArsenalItem extends Item {
  const ArsenalItem({
    required this.uniqueName,
    required this.name,
    required this.description,
    required this.imageName,
    required this.type,
    required this.productCategory,
    this.masterable = false,
  });

  factory ArsenalItem.fromJson(Map<String, dynamic> json) => _$ArsenalItemFromJson(json);

  final String uniqueName;
  final String name;
  final String description;
  final String imageName;

  @ItemTypeConverter()
  final ItemType type;

  final String productCategory;

  final bool masterable;

  Map<String, dynamic> toJson() => _$ArsenalItemToJson(this);

  @override
  List<Object?> get props => [uniqueName, name, description, imageName, type, productCategory, masterable];
}
