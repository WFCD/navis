import 'package:navis/utils/string_extensions.dart';
import 'package:warframestat_client/warframestat_client.dart';
import 'package:warframestat_repository/warframestat_repository.dart';

const defaultImage = 'https://raw.githubusercontent.com/WFCD/genesis-assets/master/img/menu/LotusEmblem.png';

String imageUri(String? imageName) {
  if (imageName == null) {
    return defaultImage.optimize();
  }

  return imageName.warframeItemsCdn().optimize();
}

extension ItemX on ItemCommon {
  String get imageUrl => imageUri(imageName);
}

extension SearchItemX on SearchItem {
  String get imageUrl => imageUri(imageName);
}

extension AbilityX on Ability {
  String get imageUrl => imageUri(imageName);
}
