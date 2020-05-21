import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/earth.dart';

part 'earth_model.g.dart';

@JsonSerializable()
class EarthModel extends Earth {
  const EarthModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String state,
    bool isDay,
    bool isCetus,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          state: state,
          isDay: isDay,
          isCetus: isCetus,
        );

  factory EarthModel.fromJson(Map<String, dynamic> json) {
    return _$EarthModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$EarthModelToJson(this);
}
