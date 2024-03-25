import 'package:equatable/equatable.dart';
import 'package:fish_repository/fish_repository.dart';
import 'package:json_annotation/json_annotation.dart';

part 'fish_size.g.dart';

/// {@template fish_size}
/// Holds fish size data.
/// {@endtemplate}
@JsonSerializable()
class FishSize<T extends RegionResources> extends Equatable {
  /// {@macro fish_size}
  const FishSize({required this.standing, required this.resources});

  /// {@macro fish_size}
  factory FishSize.fromJson(Map<String, dynamic> json) {
    return _$FishSizeFromJson(json);
  }

  /// Standing earned for fish size.
  final int? standing;

  /// Region specific resources earned with this size.
  @RegionResourcesConverter()
  final T resources;

  /// Returns a json map.
  Map<String, dynamic> toJson() => _$FishSizeToJson(this);

  @override
  List<Object?> get props => [standing, resources];
}
