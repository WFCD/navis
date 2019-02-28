import 'package:codable/codable.dart';
import 'package:codable/cast.dart' as cast;

class Nightwave extends Coding {
  String id, startString, tag;
  DateTime activation, expiry;
  bool active;
  num season, phase;

  List<Challenges> possibleChallenges, activeChallenges;
  List<String> rewardTypes;

  @override
  Map<String, cast.Cast> get castMap =>
      {'rewardTypes': const cast.List(cast.String)};

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    activation = DateTime.parse(object.decode('activation'));
    startString = object.decode('startString');
    expiry = DateTime.parse(object.decode('expiry'));
    active = object.decode('active');
    season = object.decode('season');
    tag = object.decode('tag');
    phase = object.decode('phase');

    possibleChallenges =
        object.decodeObjects('possibleChallenges', () => Challenges());

    activeChallenges =
        object.decodeObjects('activeChallenges', () => Challenges());

    rewardTypes = object.decode('rewardTypes');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('activation', activation.toIso8601String());
    object.encode('startString', startString);
    object.encode('expiry', expiry.toIso8601String());
    object.encode('active', active);
    object.encode('season', season);
    object.encode('tag', tag);
    object.encode('phase', phase);
    object.encode('rewardTypes', rewardTypes);
  }
}

class Challenges extends Coding {
  String id, startString, desc;
  DateTime activation, expiry;
  bool active, isDaily;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    activation = DateTime.parse(object.decode('activation'));
    startString = object.decode('startString');
    expiry = object.decode('expiry');
    active = object.decode('active');
    isDaily = object.decode('isDaily');
    desc = object.decode('desc');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('activation', activation.toIso8601String());
    object.encode('startString', startString);
    object.encode('expiry', expiry.toIso8601String());
    object.encode('active', active);
    object.encode('isDaily', isDaily);
    object.encode('desc', desc);
  }
}
