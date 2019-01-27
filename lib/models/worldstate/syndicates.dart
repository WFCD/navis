import 'package:codable/cast.dart' as cast;
import 'package:codable/codable.dart';

class Syndicates extends Coding {
  String syndicate, activation;
  DateTime expiry;
  bool active;
  List<Jobs> jobs;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    syndicate = object.decode('syndicate');
    activation = object.decode('activation');

    active = object.decode('active');
    jobs = object.decodeObjects('jobs', () => Jobs());

    if (object.decode('expiry') == null)
      expiry = DateTime.now().add(Duration(minutes: 120));
    else
      expiry = DateTime.parse(object.decode('expiry')).toLocal();
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('syndicate', syndicate);
    object.encode('activation', activation);
    object.encode('expiry', expiry);
    object.encode('active', active);
    object.encodeObjects('jobs', jobs);
  }
}

class Jobs extends Coding {
  String type;
  List enemyLevels;
  List standingStages;
  List<String> rewardPool;

  @override
  Map<String, cast.Cast<dynamic>> get castMap =>
      {'rewardPool': cast.List(cast.String)};

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    type = object.decode('type');
    enemyLevels = object.decode('enemyLevels');
    standingStages = object.decode('standingStages');
    rewardPool = object.decode('rewardPool');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('type', type);
    object.encode('enemyLevels', enemyLevels);
    object.encode('standingStages', standingStages);
    object.encode('rewardPool', rewardPool);
  }
}
