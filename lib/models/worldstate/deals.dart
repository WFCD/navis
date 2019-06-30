import 'package:codable/codable.dart';
import 'package:navis/models/abstract_classes.dart';

class DarvoDeal extends WorldstateObject {
  String item;
  num originalPrice, salePrice, total, sold, discount;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    item = object.decode('item');
    originalPrice = object.decode('originalPrice');
    salePrice = object.decode('salePrice');
    total = object.decode('total');
    sold = object.decode('sold');
    discount = object.decode('discount');
  }

  @override
  void encode(KeyedArchive object) {
    super.encode(object);
    object.encode('item', item);
    object.encode('originalPrice', originalPrice);
    object.encode('salePrice', salePrice);
    object.encode('total', total);
    object.encode('sold', sold);
    object.encode('discount', discount);
  }

  @override
  List get props => super.props
    ..addAll([item, originalPrice, salePrice, total, sold, discount]);
}
