import 'package:codable/codable.dart';

class Rewards extends Coding {
  String rewardName, imagePath;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    rewardName = object.decode('rewardName');
    imagePath = object.decode('imagePath');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('rewardName', rewardName);
    object.encode('imagePath', imagePath);
  }
}
