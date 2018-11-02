import 'package:codable/codable.dart';

import 'syndicates.dart';

class Events extends Coding {
  String expiry, faction, description, victimNode, health, node, tooltip;
  List<_Rewards> rewards;
  List<Jobs> jobs;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    expiry = object.decode('expiry');
    faction = object.decode('faction');
    description = object.decode('description');
    victimNode = object.decode('victimNode');
    health = object.decode('health');
    node = object.decode('node');
    tooltip = object.decode('tooltip');
    rewards = object.decodeObjects('rewards', () => _Rewards());
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('expiry', expiry);
    object.encode('faction', faction);
    object.encode('description', description);
    object.encode('victimNode', victimNode);
    object.encode('health', health);
    object.encode('node', node);
    object.encode('tooltip', tooltip);
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
