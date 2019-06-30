import 'package:codable/codable.dart';
import 'package:equatable/equatable.dart';

class Reward extends Coding with EquatableMixinBase, EquatableMixin {
  String itemString, thumbnail, asString;
  int credits;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    itemString = object.decode('itemString');
    asString = object.decode('asString');
    credits = object.decode('credits');
    thumbnail = object.decode('thumbnail');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('itemString', itemString);
    object.encode('asString', asString);
    object.encode('credits', credits);
    object.encode('thumbnail', thumbnail);
  }

  @override
  List get props => [itemString, thumbnail, asString, credits];
}
