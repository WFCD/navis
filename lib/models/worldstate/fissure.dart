import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

class VoidFissure extends WorldstateObject {
  String node, missionType, enemy, tier;
  int tierNum;
  bool active, expired;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    node = object.decode('node');
    missionType = object.decode('missionType');
    enemy = object.decode('enemy');
    tier = object.decode('tier');
    tierNum = object.decode('tierNum');
    active = object.decode('active');
    expired = object.decode('expired');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('node', node);
    object.encode('missionType', missionType);
    object.encode('enemy', enemy);
    object.encode('tier', tier);
    object.encode('tierNum', tierNum);
    object.encode('expired', expired);
  }

  @override
  List get props => super.props
    ..addAll([node, missionType, enemy, tier, tierNum, active, expired]);
}
