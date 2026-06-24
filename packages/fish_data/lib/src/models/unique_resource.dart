import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'unique_resource.g.dart';

/// {@template unique_resource}
/// Unque resource dropped by specific fish.
/// {@endtemplate}
@JsonSerializable()
class UniqueResource extends Equatable {
  /// {@macro unique_resource}
  const UniqueResource({
    required this.name,
    required this.thumbnail,
    required this.wikiUrl,
  });

  /// {@macro unique_resource}
  factory UniqueResource.fromJson(Map<String, dynamic> json) {
    return _$UniqueResourceFromJson(json);
  }

  /// Resource name
  final String name;

  /// Resource thumbnail
  @JsonKey(name: 'thumb')
  final String? thumbnail;

  /// Resource wiki url.
  @JsonKey(name: 'wiki')
  final String? wikiUrl;

  /// Returns a json map.
  Map<String, dynamic> toJson() => _$UniqueResourceToJson(this);

  @override
  List<Object?> get props => [name, thumbnail, wikiUrl];
}
