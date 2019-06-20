import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

class Syndicate extends WorldstateObject {
  String name;
  bool active;
  List<Jobs> jobs;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    name = object.decode('syndicate');
    active = object.decode('active');
    jobs = object.decodeObjects('jobs', () => Jobs());

    if (expiry == null)
      expiry = DateTime.now().add(const Duration(minutes: 120));
    else
      expiry = DateTime.parse(object.decode('expiry')).toLocal();
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('syndicate', name);
    object.encode('active', active);
    object.encodeObjects('jobs', jobs);
  }
}

class Jobs extends Coding {
  String type;
  List enemyLevels;
  List standingStages;
  List rewardPool;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    type = object.decode('type');
    enemyLevels = object.decode('enemyLevels');
    standingStages = object.decode('standingStages');

    if (object.decode('rewardPool') is List)
      rewardPool = object.decode('rewardPool');
    else
      rewardPool = <String>[];
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('type', type);
    object.encode('enemyLevels', enemyLevels);
    object.encode('standingStages', standingStages);
    object.encode('rewardPool', rewardPool);
  }
}
