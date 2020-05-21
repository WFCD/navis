import 'package:json_annotation/json_annotation.dart';
import 'package:warframe_items_model/src/models/base_item.dart';

import 'component_drop.dart';

part 'component.g.dart';

@JsonSerializable()
class Component extends BaseItem {
  const Component({
    String uniqueName,
    String name,
    String description,
    this.itemCount,
    String imageName,
    bool tradable,
    this.drops,
  }) : super(
          uniqueName: uniqueName,
          name: name,
          description: description,
          imageName: imageName,
          tradable: tradable,
          type: '',
        );

  factory Component.fromJson(Map<String, dynamic> json) =>
      _$ComponentFromJson(json);

  final num itemCount;
  final List<ComponentDrop> drops;

  @override
  Map<String, dynamic> toJson() => _$ComponentToJson(this);

  @override
  List<Object> get props => super.props..addAll([itemCount, drops]);
}
