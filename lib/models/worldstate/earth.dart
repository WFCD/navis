import 'package:json_annotation/json_annotation.dart';
import 'package:navis/models/abstract_classes.dart';

part 'earth.g.dart';

const earthCycle = Duration(hours: 4);
const cetusDay = Duration(minutes: 100);
const cetusNight = Duration(minutes: 50);

@JsonSerializable()
class Earth extends WorldstateObject with CycleModel {
  Earth({
    String id,
    //DateTime activation,
    DateTime expiry,
    this.isDay,
    this.isCetus,
  }) : super(id: id, expiry: expiry);

  factory Earth.fromJson(Map<String, dynamic> json) => _$EarthFromJson(json);

  final bool isDay, isCetus;

  Map<String, dynamic> toJson() => _$EarthToJson(this);

  @override
  bool getStateBool() => isDay;

  @override
  String getState() => isDay ? 'Day' : 'Night';
}
