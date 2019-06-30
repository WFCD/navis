import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

class Arbitration extends WorldstateObject {
  String solnode, planet, enemy, type;
  bool archwing, sharkwing;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    type = object.decode('type');
    enemy = object.decode('enemy');
    planet = object.decode('planet');
    solnode = object.decode('solnode');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('type', type);
    object.encode('enemy', enemy);
    object.encode('planet', planet);
    object.encode('solnode', solnode);
  }

  @override
  List get props =>
      super.props..addAll([solnode, planet, enemy, type, archwing, sharkwing]);
}
