import 'package:codable/codable.dart';

class Oddities extends Coding {
  String lore, shortcode;
  num lat, lng;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);
    lore = object.decode('lore');
    shortcode = object.decode('shortcode');
    lat = object.decode('lat');
    lng = object.decode('lng');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('lore', lore);
    object.encode('shortcode', shortcode);
    object.encode('lat', lat);
    object.encode('lng', lng);
  }
}
