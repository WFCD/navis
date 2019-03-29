import 'package:codable/codable.dart';

class DarvoDeal extends Coding {
  String item, id;
  DateTime expiry;
  num originalPrice, salePrice, total, sold, discount;

  @override
  void decode(KeyedArchive object) {
    super.decode(object);

    id = object.decode('id');
    item = object.decode('item');
    expiry = DateTime.parse(object.decode('expiry'));
    originalPrice = object.decode('originalPrice');
    salePrice = object.decode('salePrice');
    total = object.decode('total');
    sold = object.decode('sold');
    discount = object.decode('discount');
  }

  @override
  void encode(KeyedArchive object) {
    object.encode('id', id);
    object.encode('item', item);
    object.encode('expiry', expiry.toIso8601String());
    object.encode('originalPrice', originalPrice);
    object.encode('salePrice', salePrice);
    object.encode('total', total);
    object.encode('sold', sold);
    object.encode('discount', discount);
  }
}
