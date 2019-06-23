import 'package:codable/codable.dart';

class Reward extends Coding {
  String place, item, rarity;
  num chance;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    place = object.decode('place');
    item = object.decode('item');
    rarity = object.decode('rarity');

    if (object.decode('chance') is String) {
      chance = num.parse(object.decode('chance'));
    } else
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
