import 'package:codable/codable.dart';

class VoidFissures extends Coding {
  String node, missionType, enemy, tier, eta;
  DateTime expiry;
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
    expiry = DateTime.parse(object.decode('expiry'));
    eta = object.decode('eta');
    active = object.decode('active');
    expired = object.decode('expired');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('node', node);
    object.encode('missionType', missionType);
    object.encode('enemy', enemy);
    object.encode('tier', tier);
    object.encode('tierNum', tierNum);
    object.encode('expiry', expiry);
    object.encode('eta', eta);
    object.encode('active', active);
    object.encode('expired', expired);
  }
}
