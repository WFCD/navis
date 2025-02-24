import 'package:navis/utils/string_extensions.dart';
import 'package:warframestat_client/warframestat_client.dart';

const defaultImage = 'https://raw.githubusercontent.com/WFCD/genesis-assets/master/img/menu/LotusEmblem.png';

String _imageUrl(String? imageName) {
  if (imageName == null) {
    return defaultImage.optimize();
  }

  return imageName.warframeItemsCdn().optimize();
}

extension ItemX on Item {
  String get imageUrl => _imageUrl(imageName);
}

extension AbilityX on Ability {
  String get imageUrl => _imageUrl(imageName);
}
