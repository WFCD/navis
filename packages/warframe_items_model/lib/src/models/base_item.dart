import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:warframe_items_model/src/common/patch_log.dart';
import 'package:meta/meta.dart';

part 'base_item.g.dart';

@JsonSerializable()
class BaseItem extends Equatable {
  const BaseItem({
    this.uniqueName,
    @required this.name,
    @required this.description,
    @required this.type,
    @required this.imageName,
    this.category,
    this.tradable = false,
    this.patchlogs,
    this.wikiaUrl,
    this.wikiaThumbnail,
  })  : assert(name != null),
        assert(description != null),
        assert(type != null),
        assert(imageName != null);

  factory BaseItem.fromJson(Map<String, dynamic> json) {
    return _$BaseItemFromJson(json);
  }

  final String uniqueName;
  final String name;
  final String description;
  final String type;
  final String imageName;
  final String category;
  final bool tradable;
  final List<Patchlog> patchlogs;
  final String wikiaUrl, wikiaThumbnail;

  String get imageUrl {
    const opts = 'o_webp,progressive_false';
    final uriEncoded =
        Uri.encodeFull('https://cdn.warframestat.us/img/$imageName');

    return 'https://cdn.warframestat.us/$opts/$uriEncoded';
  }

  Map<String, dynamic> toJson() => _$BaseItemToJson(this);

  @override
  List<Object> get props {
    return [
      uniqueName,
      name,
      description,
      type,
      imageName,
      category,
      tradable,
      patchlogs,
      wikiaUrl,
      wikiaThumbnail,
    ];
  }
}
