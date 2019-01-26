import 'package:codable/codable.dart';

class PersistentEnemies extends Coding {
  String agentType, locationTag, lastDiscoveredAt;
  DateTime lastDiscoveredTime;
  int fleeDamage, region, rank;
  num healthPercent;
  bool isDiscovered, isUsingTicketing;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    agentType = object.decode('agentType');
    locationTag = object.decode('locationTag');
    lastDiscoveredTime = DateTime.parse(object.decode('lastDiscoveredTime'));
    lastDiscoveredAt = object.decode('lastDiscoveredAt');

    fleeDamage = object.decode('fleeDamage');
    region = object.decode('region');
    rank = object.decode('rank');
    healthPercent = object.decode('healthPercent');
    isDiscovered = object.decode('isDiscovered');
    isUsingTicketing = object.decode('isUsingTicketing');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('agentType', agentType);
    object.encode('locationTag', locationTag);
    object.encode('lastDiscoveredTime', lastDiscoveredTime);
    object.encode('lastDiscovereAt', lastDiscoveredAt);

    object.encode('fleeDamage', fleeDamage);
    object.encode('region', region);
    object.encode('rank', rank);
    object.encode('healthPercent', healthPercent);
    object.encode('isDiscovered', isDiscovered);
    object.encode('isUsingTicketing', isUsingTicketing);
  }
}
