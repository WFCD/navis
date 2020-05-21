import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class Arbitration extends WorldstateObject {
  const Arbitration({
    DateTime activation,
    DateTime expiry,
    this.node,
    this.enemy,
    this.type,
    this.archwingRequired,
  }) : super(activation: activation, expiry: expiry);

  final String node, enemy, type;

  // archwing and sharkwing still require an archwing so better to put them together
  final bool archwingRequired;

  @override
  List<Object> get props {
    return super.props..addAll([node, enemy, type, archwingRequired]);
  }
}
