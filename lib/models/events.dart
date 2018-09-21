import 'package:codable/codable.dart';

class Events extends Coding {
  String expiry, faction, description, victimNode, health;
  List<_Rewards> rewards;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    expiry = object.decode('expiry');
    faction = object.decode('faction');
    description = object.decode('description');
    victimNode = object.decode('victimNode');
    health = object.decode('health');
    rewards = object.decodeObjects('rewards', () => _Rewards());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('faction', faction);
    object.encode('description', description);
    object.encode('victimNode', victimNode);
    object.encode('health', health);
    object.encodeObjects('rewards', rewards);
  }
}

class _Rewards extends Coding {
  int credits;
  String itemString;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    credits = object.decode('credits');
    itemString = object.decode('itemString');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('credits', credits);
    object.encode('itemString', itemString);
  }
}
