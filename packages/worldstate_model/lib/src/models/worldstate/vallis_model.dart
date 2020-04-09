import 'package:json_annotation/json_annotation.dart';
import 'package:worldstate_api_model/src/entities/worldstate/vallis.dart';

part 'vallis_model.g.dart';

@JsonSerializable()
class VallisModel extends Vallis {
  const VallisModel({
    String id,
    DateTime activation,
    DateTime expiry,
    String state,
    bool isWarm,
  }) : super(
          id: id,
          activation: activation,
          expiry: expiry,
          state: state,
          isWarm: isWarm,
        );

  factory VallisModel.fromJson(Map<String, dynamic> json) {
    return _$VallisModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$VallisModelToJson(this);
}
