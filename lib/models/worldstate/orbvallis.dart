import 'package:json_annotation/json_annotation.dart';

import '../abstract_classes.dart';

part 'orbvallis.g.dart';

@JsonSerializable()
class Vallis extends WorldstateObject with CycleModel {
  Vallis({String id, DateTime activation, DateTime expiry, this.isWarm})
      : super(id: id, activation: activation, expiry: expiry, props: [isWarm]);

  factory Vallis.fromJson(Map<String, dynamic> json) => _$VallisFromJson(json);

  final bool isWarm;

  @override
  bool getStateBool() => isWarm;

  @override
  String getState() => isWarm ? 'Warm' : 'Cold';

  Map<String, dynamic> toJson() => _$VallisToJson(this);
}
