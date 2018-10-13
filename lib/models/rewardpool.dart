import 'package:codable/codable.dart';

class Rewards extends Coding {
  String place, item, rarity;
  int chance;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    place = object.decode('place');
    item = object.decode('item');
    rarity = object.decode('rarity');
    chance = object.decode('chance');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('place', place);
    object.encode('item', item);
    object.encode('rarity', rarity);
    object.encode('chance', chance);
  }
}
