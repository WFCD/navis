import 'package:codable/codable.dart';

class Rewards extends Coding {
  String reward;
  String level;
  String path;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    reward = object.decode('reward');
    level = object.decode('level');
    path = object.decode('path');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('reward', reward);
    object.encode('level', level);
    object.encode('path', path);
  }
}
