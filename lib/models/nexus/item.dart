import 'package:codable/codable.dart';

class Item extends Coding {
  String uniqueName;
  String apiUrl, description, imgUrl, name, webUrl;
  String category, polarity, rarity, type;
  num baseDrain, fusionLimit;
  bool tradable;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    uniqueName = object.decode('uniqueName');

    apiUrl = object.decode('apiUrl');
    description = object.decode('description');
    imgUrl = object.decode('imgUrl');
    name = object.decode('name');
    webUrl = object.decode('webUrl');

    category = object.decode('category');
    polarity = object.decode('polarity');
    rarity = object.decode('rarity');
    type = object.decode('type');

    baseDrain = object.decode('baseDrain');
    fusionLimit = object.decode('fusionLimit');

    tradable = object.decode('tradable');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('uniqueName', uniqueName);

    object.encode('apiUrl', apiUrl);
    object.encode('description', description);
    object.encode('imgUrl', imgUrl);
    object.encode('name', name);
    object.encode('webUrl', webUrl);

    object.encode('category', category);
    object.encode('polarity', polarity);
    object.encode('rarity', rarity);
    object.encode('type', type);

    object.encode('baseDrain', baseDrain);
    object.encode('fusionLimit', fusionLimit);

    object.encode('tradable', tradable);
  }
}
