import 'package:worldstate_api_model/src/objects/worldstate_object.dart';

class DarvoDeal extends WorldstateObject {
  const DarvoDeal({
    String id,
    DateTime activation,
    DateTime expiry,
    this.item,
    this.originalPrice,
    this.salePrice,
    this.total,
    this.sold,
    this.discount,
  }) : super(id: id, activation: activation, expiry: expiry);

  final String item;
  final int originalPrice, salePrice, total, sold, discount;

  @override
  List<Object> get props {
    return super.props
      ..addAll([item, originalPrice, salePrice, total, sold, discount]);
  }
}
