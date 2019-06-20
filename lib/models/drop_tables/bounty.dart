import 'package:codable/codable.dart';

class Bounty extends Coding {
  String id, bountyLevel;
  Rotation rewards;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('_id');
    bountyLevel = object.decode('bountyLevel');
    rewards = object.decodeObject('rewards', () => Rotation());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('_id', id);
    object.encode('bountyLevel', bountyLevel);
    object.encodeObject('rewards', rewards);
  }
}

class Rotation extends Coding {
  List<Reward> rotationA, rotationB, rotationC;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    rotationA = object.decodeObjects('A', () => Reward());
    rotationB = object.decodeObjects('B', () => Reward());
    rotationC = object.decodeObjects('C', () => Reward());
  }

  @override
  void encode(KeyedArchive object) {
    object.encodeObjects('A', rotationA);
    object.encodeObjects('B', rotationB);
    object.encodeObjects('C', rotationC);
  }
}

class Reward extends Coding {
  String id, itemName, rarity, stage;
  num chance;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('_id');
    itemName = object.decode('itemName');
    rarity = object.decode('rarity');
    chance = object.decode('chance');
    stage = object.decode('stage');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('_id', id);
    object.encode('itemName', itemName);
    object.encode('rarity', rarity);
    object.encode('chance', chance);
    object.encode('stage', stage);
  }
}
