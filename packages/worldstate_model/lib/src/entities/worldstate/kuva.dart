import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class Kuva extends WorldstateObject {
  const Kuva({
    DateTime activation,
    DateTime expiry,
    this.node,
    this.enemy,
    this.type,
    this.archwingRequired,
  }) : super(activation: activation, expiry: expiry);

  final String node;
  final String enemy;
  final String type;
  final bool archwingRequired;
}
