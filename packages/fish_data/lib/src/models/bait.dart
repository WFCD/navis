import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'bait.g.dart';

/// {@template bait}
/// Fish bait data.
/// {@endtemplate}
@JsonSerializable()
class Bait extends Equatable {
  /// {@macro bait}
  const Bait({
    required this.name,
    required this.thumbnail,
    this.recommended = false,
  });

  /// {@macro bait}
  factory Bait.fromJson(Map<String, dynamic> json) {
    return _$BaitFromJson(json);
  }

  /// Name of bait.
  final String name;

  /// Bait thumbnail.
  @JsonKey(name: 'thumb')
  final String? thumbnail;

  /// Whether bait is recommended or not.
  final bool recommended;

  /// Returns a json map.
  Map<String, dynamic> toJson() => _$BaitToJson(this);

  @override
  List<Object?> get props => [name, thumbnail, recommended];
}
