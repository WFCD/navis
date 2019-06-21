import 'package:codable/codable.dart';

import '../abstract_classes.dart';

class KuvaNode extends WorldstateObject {
  String solnode, node, planet, enemy, type;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    solnode = object.decode('solnode');
    node = object.decode('node');
    planet = object.decode('planet');
    enemy = object.decode('enemy');
    type = object.decode('type');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);

    object.encode('solnode', solnode);
    object.encode('node', node);
    object.encode('planet', planet);
    object.encode('enemy', enemy);
    object.encode('type', type);
  }
}
